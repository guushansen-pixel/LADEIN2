<#
.SYNOPSIS
    Baut den Latein-Trainer ueber apk-builder und patcht danach nach, was
    apk-builder selbst nicht unterstuetzt: Portrait-Lock und Keep-Screen-On.
.DESCRIPTION
    apps\Latein-Trainer unter apk-builder wird bei jedem Lauf per -Force
    komplett neu aus dem WebView-Template erzeugt (siehe apk-builder\CLAUDE.md) -
    die Patches unten muessen deshalb bei jedem Build erneut angewendet werden.
    Sie sind mit throw-Guards abgesichert: aendert sich das Template von
    apk-builder, bricht der Build laut ab statt still eine unfertige APK zu
    bauen.

    Die Zurueck-Wischgeste (Predictive Back) patcht seit 2026-09-24 das
    apk-builder-Template selbst nach (Commit "Template: Zurueck-Wischgeste
    abfangen, -Portrait und -KeepScreenOn") - dieser Wrapper muss dafuer
    nichts mehr tun.

    Anders als vokabeltrainer\build.ps1 fehlt hier alles zur Sprachausgabe -
    keine TtsBridge.java, kein <queries>-Block fuer TTS_SERVICE, kein
    onDestroy-Patch. Fuer Latein bringt Android keine Stimme mit, und eine
    fremdsprachige Ersatzstimme wuerde eine Aussprache vorgeben, die im
    Unterricht nicht gemeint ist.
.EXAMPLE
    .\build.ps1 -Release -Install
#>
[CmdletBinding()]
param(
    [string]$VersionName = '1.0',
    [int]$VersionCode = 1,
    [switch]$Release,
    [switch]$Install
)

$ErrorActionPreference = 'Stop'

# javac lehnt eine UTF-8-BOM als "Unzulaessiges Zeichen U+FEFF" ab, und
# Set-Content -Encoding utf8 schreibt in PowerShell 5.1 immer eine BOM -
# deshalb wie new-app.ps1 selbst ueber .NET BOM-frei schreiben.
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
function Write-TextNoBom {
    param([string]$Path, [string]$Content)
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8NoBom)
}

$ApkBuilder = "D:\claude code projects\apk-builder"
$Project    = "D:\claude code projects\latein-trainer"
$PackageId  = "com.daniel.lateintrainer"
$AppName    = "Latein-Trainer"
$appDir     = Join-Path $ApkBuilder "apps\$AppName"

# Ohne generierte Vokabeldaten waere die APK leer - lieber gleich laut sein.
$dataDir = Join-Path $Project 'web\data'
$packs = @(Get-ChildItem -Path $dataDir -Filter 'vocab.agp*.js' -ErrorAction SilentlyContinue)
if ($packs.Count -eq 0) {
    throw "In web\data\ liegt keine vocab.agp*.js - erst die Scans lesen (tools\inspect-scans.ps1) und dann .\tools\build-vocab.ps1 laufen lassen."
}
Write-Host ("  [info] {0} Vokabelpakete werden mitgebaut" -f $packs.Count) -ForegroundColor DarkGray

& "$ApkBuilder\new-app.ps1" -Name $AppName -PackageId $PackageId `
    -WebRoot "$Project\web" `
    -Icon "$Project\icon.xml" `
    -IconBackground "#3A140D" `
    -VersionName $VersionName -VersionCode $VersionCode -Force

$javaDir = Join-Path $appDir ("app\src\main\java\" + $PackageId.Replace('.', '\'))

# --- AndroidManifest.xml: Portrait-Lock ------------------------------------
$manifestPath = Join-Path $appDir 'app\src\main\AndroidManifest.xml'
$manifest = Get-Content $manifestPath -Raw

# Patch 1: Portrait-Lock - beim Tippen soll sich das Layout nicht durch eine
# versehentliche Drehung neu aufbauen und die Eingabe verlieren.
$launchModeNeedle = 'android:launchMode="singleTop">'
if ($manifest -notmatch [regex]::Escape($launchModeNeedle)) {
    throw "Manifest-Patchziel (launchMode) nicht gefunden - hat sich das apk-builder-Template geaendert?"
}
$manifest = $manifest -replace [regex]::Escape($launchModeNeedle), ('android:launchMode="singleTop"' + "`n            android:screenOrientation=`"portrait`">")

Write-TextNoBom -Path $manifestPath -Content $manifest

# --- MainActivity.java: Keep-Screen-On -------------------------------------
$mainActivityPath = Join-Path $javaDir 'MainActivity.java'
$java = Get-Content $mainActivityPath -Raw

$importNeedle = 'import android.view.KeyEvent;'
if ($java -notmatch [regex]::Escape($importNeedle)) {
    throw "MainActivity.java Import-Patchziel nicht gefunden - hat sich das apk-builder-Template geaendert?"
}
$java = $java -replace [regex]::Escape($importNeedle), ($importNeedle + "`nimport android.view.WindowManager;")

# Patch 2: Bildschirm wach halten - beim Nachdenken ueber eine Vokabel
# passiert minutenlang keine Eingabe. FLAG_KEEP_SCREEN_ON braucht keine
# Manifest-Permission (anders als WAKE_LOCK+PowerManager).
$ccNeedle = 'setContentView(webView);'
if ($java -notmatch [regex]::Escape($ccNeedle)) {
    throw "MainActivity.java onCreate-Patchziel nicht gefunden - hat sich das apk-builder-Template geaendert?"
}
$java = $java -replace [regex]::Escape($ccNeedle), ($ccNeedle + "`n`n        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);")

Write-TextNoBom -Path $mainActivityPath -Content $java

Write-Host "  [ok] Patches angewendet (Portrait-Lock, Keep-Screen-On)" -ForegroundColor Green

if ($Release -and $Install) {
    & "$ApkBuilder\build-apk.ps1" -App $AppName -Release -Install
} elseif ($Release) {
    & "$ApkBuilder\build-apk.ps1" -App $AppName -Release
} elseif ($Install) {
    & "$ApkBuilder\build-apk.ps1" -App $AppName -Install
} else {
    & "$ApkBuilder\build-apk.ps1" -App $AppName
}
