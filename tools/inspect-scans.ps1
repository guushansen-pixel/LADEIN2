<#
.SYNOPSIS
    Schaut nach, was in source-scans\<band>\ liegt, und prueft bei PDFs, ob
    sie eine Textebene haben.
.DESCRIPTION
    Der Wortschatz zu AGITE plus ist nirgends frei im Netz zu haben (siehe
    README, "Woher die Vokabeln kommen") - er kommt aus dem eigenen Buch.
    Wie muehsam das wird, haengt an einer einzigen Frage: bringt die Datei
    schon Text mit oder nur Pixel?

      Textebene vorhanden  -> pdftotext liefert die Woerter exakt, ohne dass
                              irgendwer sie abliest. Das Ergebnis landet in
                              vocab-src\<band>.raw.txt und wird von dort zum
                              TSV sortiert.
      nur Bilder           -> die Seiten muessen gelesen werden. Auf diesem
                              Rechner gibt es weder Tesseract noch einen
                              PDF-Rasterizer (Git fuer Windows bringt nur
                              pdftotext mit), deshalb liest Claude die
                              Seiten direkt und schreibt das TSV.

    Dieses Skript entscheidet nichts, es sagt nur, welcher der beiden Wege
    ansteht. Gebaut wird danach mit tools\build-vocab.ps1.
.EXAMPLE
    .\tools\inspect-scans.ps1
    .\tools\inspect-scans.ps1 -Band 2
#>
[CmdletBinding()]
param(
    [ValidateRange(1, 3)]
    [int[]]$Band = @(2, 3)
)

$ErrorActionPreference = 'Stop'

$root    = Split-Path -Parent $PSScriptRoot
$scanDir = Join-Path $root 'source-scans'
$srcDir  = Join-Path $root 'vocab-src'

# pdftotext kommt mit Git fuer Windows mit - kein zusaetzlicher Download.
function Get-PdfToText {
    $cmd = Get-Command pdftotext -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    foreach ($p in @("$env:ProgramFiles\Git\mingw64\bin\pdftotext.exe",
                     "${env:ProgramFiles(x86)}\Git\mingw64\bin\pdftotext.exe",
                     "$env:LOCALAPPDATA\Programs\Git\mingw64\bin\pdftotext.exe")) {
        if (Test-Path $p) { return $p }
    }
    return $null
}

$pdftotext = Get-PdfToText
if (-not $pdftotext) {
    Write-Host "  [warn] pdftotext nicht gefunden - die Textebenen-Pruefung faellt aus." -ForegroundColor DarkYellow
}
if (-not (Test-Path $srcDir)) { New-Item -ItemType Directory -Path $srcDir | Out-Null }

$imageExt = @('.jpg', '.jpeg', '.png', '.webp', '.heic', '.tif', '.tiff')

foreach ($n in $Band) {
    $id  = "agp$n"
    $dir = Join-Path $scanDir $id
    Write-Host ""
    Write-Host ("  Agite plus {0}  ({1})" -f $n, $dir) -ForegroundColor Cyan

    if (-not (Test-Path $dir)) {
        Write-Host "  [--  ] Ordner gibt es noch nicht - hier die Scans ablegen." -ForegroundColor DarkGray
        continue
    }

    $files  = @(Get-ChildItem -Path $dir -File -Recurse | Sort-Object FullName)
    $pdfs   = @($files | Where-Object { $_.Extension -eq '.pdf' })
    $images = @($files | Where-Object { $imageExt -contains $_.Extension.ToLower() })
    $rest   = @($files | Where-Object { $_.Extension -ne '.pdf' -and $imageExt -notcontains $_.Extension.ToLower() })

    Write-Host ("  [info] {0} PDF, {1} Bilder, {2} sonstige Dateien" -f $pdfs.Count, $images.Count, $rest.Count)

    if ($images.Count -gt 0) {
        Write-Host "  [ok  ] Bildseiten gefunden - werden gelesen und zu vocab-src\$id.tsv." -ForegroundColor Green
    }

    foreach ($pdf in $pdfs) {
        if (-not $pdftotext) { continue }
        # -layout erhaelt die Spalten; ohne das steht die deutsche Bedeutung
        # irgendwo zwischen den Stammformen.
        $text = & $pdftotext -layout -enc UTF-8 $pdf.FullName - 2>$null
        $joined = ($text -join "`n")
        # Eine reine Bild-PDF liefert fast nichts ausser Seitenumbruechen.
        $letters = ([regex]::Matches($joined, '[A-Za-z]')).Count
        $pages   = [math]::Max(1, ([regex]::Matches($joined, "`f")).Count + 1)
        $perPage = [math]::Round($letters / $pages)

        if ($perPage -lt 200) {
            Write-Host ("  [scan] {0}: {1} Seiten, nur {2} Buchstaben je Seite - keine Textebene, die Seiten muessen gelesen werden." -f $pdf.Name, $pages, $perPage) -ForegroundColor Yellow
        } else {
            $out = Join-Path $srcDir "$id.raw.txt"
            [System.IO.File]::WriteAllText($out, $joined, (New-Object System.Text.UTF8Encoding($false)))
            Write-Host ("  [text] {0}: {1} Seiten mit Textebene ({2} Buchstaben je Seite) -> vocab-src\{3}.raw.txt" -f $pdf.Name, $pages, $perPage, $id) -ForegroundColor Green
        }
    }

    if ($files.Count -eq 0) {
        Write-Host "  [--  ] Ordner ist leer." -ForegroundColor DarkGray
    }
}

Write-Host ""
Write-Host "  Naechster Schritt: aus dem Gelesenen vocab-src\agp<N>.tsv bauen," -ForegroundColor DarkGray
Write-Host "  gegenlesen, dann .\tools\build-vocab.ps1 -Band <N>." -ForegroundColor DarkGray
