<#
.SYNOPSIS
    Macht aus dem geprueften vocab-src\agp<N>.tsv die Vokabeldatei
    web\data\vocab.agp<N>.js.
.DESCRIPTION
    Zwischen Buchseite und App liegt bewusst eine Klartextstufe: das TSV.
    Es ist die Fassung, die sich Zeile fuer Zeile gegen das Buch gegenlesen
    laesst - eine generierte .js-Datei liest niemand nach. Dieses Skript
    konvertiert nur und prueft dabei; es erfindet nichts und raet nichts.

    Spalten, durch Tabulator getrennt:

        Lektion  Lemma    Stammformen           Wortart  Bedeutungen
        L21      ducere   duco, duxi, ductum    v        fuehren; ziehen; leiten
        L21      pax      pacis f.              n        Friede
        L22      semper                         adv      immer

      Lektion      L21 oder 21 - muss in den Bereich des Bandes fallen
                   (Band 2 = L21-L40, Band 3 = L41-L60, Band 1 = L1-L20)
      Lemma        die Vokabel, wie sie abgefragt wird
      Stammformen  Rest des Buch-Eintrags (Stammformen bzw. Genitiv + Genus),
                   darf leer sein
      Wortart      n v adj adv pron praep konj num wend (Wendung) name x
      Bedeutungen  mit ; getrennt; jede zaehlt beim Eintippen als richtig

    Zeilen, die mit # anfangen, und Leerzeilen werden ueberlesen.

    Abgebrochen wird bei: unbekannter Wortart, Lektion ausserhalb des Bandes,
    fehlenden Spalten, leerem Lemma oder leeren Bedeutungen und bei einem
    Lemma, das in derselben Lektion zweimal vorkommt (die Wortschluessel in
    localStorage waeren sonst nicht eindeutig, und der zweite Eintrag wuerde
    den Lernstand des ersten mitbenutzen).

    Am Ende steht die Anzahl je Lektion - die Gegenprobe zum Buch.
.EXAMPLE
    .\tools\build-vocab.ps1 -Band 2
    .\tools\build-vocab.ps1                # alle vorhandenen TSV
#>
[CmdletBinding()]
param(
    [ValidateRange(1, 3)]
    [int[]]$Band = @(1, 2, 3)
)

$ErrorActionPreference = 'Stop'

$root   = Split-Path -Parent $PSScriptRoot
$srcDir = Join-Path $root 'vocab-src'
$outDir = Join-Path $root 'web\data'

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$validPos  = @('n', 'v', 'adj', 'adv', 'pron', 'praep', 'konj', 'num', 'wend', 'name', 'x')

# Band 1 = Lektion 1-20, Band 2 = 21-40, Band 3 = 41-60.
function Get-LessonRange([int]$n) {
    return @{ From = ($n - 1) * 20 + 1; To = $n * 20 }
}

# JS-String-Literal mit einfachen Anfuehrungszeichen. Der Backslash muss
# zuerst weg, sonst verdoppelt der naechste Ersatz seine eigenen Fluchten.
function ConvertTo-JsString([string]$s) {
    $t = $s -replace '\\', '\\'
    $t = $t -replace "'", "\'"
    $t = $t -replace "`r", ''
    $t = $t -replace "`n", ' '
    return "'" + $t + "'"
}

$built = 0

foreach ($n in $Band) {
    $id  = "agp$n"
    $tsv = Join-Path $srcDir "$id.tsv"
    if (-not (Test-Path $tsv)) {
        if ($PSBoundParameters.ContainsKey('Band')) {
            throw "vocab-src\$id.tsv gibt es nicht - erst die Scans lesen (siehe tools\inspect-scans.ps1)."
        }
        continue
    }

    $range = Get-LessonRange $n
    Write-Host ""
    Write-Host ("  Agite plus {0}  (Lektion {1}-{2})" -f $n, $range.From, $range.To) -ForegroundColor Cyan

    $lines = [System.IO.File]::ReadAllLines($tsv, [System.Text.Encoding]::UTF8)
    $units = [ordered]@{}
    $seen  = @{}
    $lineNo = 0
    $count  = 0

    foreach ($line in $lines) {
        $lineNo++
        if (-not $line) { continue }
        if ($line.TrimStart().StartsWith('#')) { continue }
        if (-not $line.Trim()) { continue }

        $cols = $line -split "`t"
        if ($cols.Count -lt 5) {
            throw "$id.tsv Zeile ${lineNo}: $($cols.Count) Spalten statt 5 - Tabulator vergessen? [$line]"
        }

        $rawLesson = $cols[0].Trim()
        $lemma     = $cols[1].Trim()
        $forms     = $cols[2].Trim()
        $pos       = $cols[3].Trim().ToLower()
        $meanRaw   = $cols[4].Trim()

        if ($rawLesson -notmatch '^L?(\d{1,2})$') {
            throw "$id.tsv Zeile ${lineNo}: '$rawLesson' ist keine Lektionsangabe (erwartet L21 oder 21)."
        }
        $num = [int]$Matches[1]
        if ($num -lt $range.From -or $num -gt $range.To) {
            throw "$id.tsv Zeile ${lineNo}: Lektion $num liegt nicht in Band $n ($($range.From)-$($range.To))."
        }
        $code = 'L' + $num

        if (-not $lemma)   { throw "$id.tsv Zeile ${lineNo}: Lemma fehlt." }
        if (-not $meanRaw) { throw "$id.tsv Zeile ${lineNo}: Bedeutung fehlt bei '$lemma'." }
        if ($validPos -notcontains $pos) {
            throw "$id.tsv Zeile ${lineNo}: Wortart '$pos' bei '$lemma' ist keine von: $($validPos -join ' ')."
        }

        $dupKey = "$code|$lemma"
        if ($seen.ContainsKey($dupKey)) {
            throw "$id.tsv Zeile ${lineNo}: '$lemma' steht in $code schon in Zeile $($seen[$dupKey]) - Wortschluessel waeren nicht eindeutig."
        }
        $seen[$dupKey] = $lineNo

        $meanings = @($meanRaw -split ';' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
        if ($meanings.Count -eq 0) { throw "$id.tsv Zeile ${lineNo}: Bedeutung fehlt bei '$lemma'." }

        # 'p' = ganzer Satz. Der Schalter "Nur Einzelwoerter" filtert darueber,
        # und in der gemischten Abfrage bekommen Saetze immer Auswahl statt
        # Eintippen - einen Satz abzutippen ist Schikane.
        $kind = 'w'
        if ($lemma -match '[.!?]$' -or (($lemma -split '\s+').Count -gt 3)) { $kind = 'p' }

        if (-not $units.Contains($code)) { $units[$code] = New-Object System.Collections.ArrayList }
        [void]$units[$code].Add([pscustomobject]@{
            La = $lemma; Forms = $forms; Pos = $pos; De = $meanings; Kind = $kind
        })
        $count++
    }

    if ($count -eq 0) { throw "$id.tsv enthaelt keine Vokabeln." }

    # Lektionen in Buchreihenfolge, nicht in der Reihenfolge des TSV.
    $codes = @($units.Keys | Sort-Object { [int]($_ -replace '^L', '') })

    $sb = New-Object System.Text.StringBuilder
    [void]$sb.AppendLine("/*")
    [void]$sb.AppendLine(" * ERZEUGT von tools\build-vocab.ps1 - nicht von Hand aendern.")
    [void]$sb.AppendLine(" * Quelle: vocab-src\$id.tsv (aus dem eigenen Schulbuch AGITE plus $n,")
    [void]$sb.AppendLine(" * (c) Westermann Bildungsmedien Verlag GmbH). Nur fuer den privaten")
    [void]$sb.AppendLine(" * Gebrauch - diese Datei steht deshalb in .gitignore.")
    [void]$sb.AppendLine(" */")
    [void]$sb.AppendLine("window.VOCAB_$($id.ToUpper()) = {")
    [void]$sb.AppendLine("  band: '$id', version: 1,")
    [void]$sb.AppendLine("  units: [")

    for ($c = 0; $c -lt $codes.Count; $c++) {
        $code  = $codes[$c]
        $words = $units[$code]
        [void]$sb.AppendLine("    { code: '$code', words: [")
        for ($w = 0; $w -lt $words.Count; $w++) {
            $word = $words[$w]
            $de   = ($word.De | ForEach-Object { ConvertTo-JsString $_ }) -join ', '
            # {{ und }} sind die Fluchten von -f - sonst haelt String.Format
            # die geschweiften Klammern des JS-Objekts fuer Platzhalter.
            $row  = "      {{ la: {0}, forms: {1}, pos: '{2}', de: [{3}], kind: '{4}' }}" -f `
                    (ConvertTo-JsString $word.La), (ConvertTo-JsString $word.Forms), $word.Pos, $de, $word.Kind
            if ($w -lt $words.Count - 1) { $row += ',' }
            [void]$sb.AppendLine($row)
        }
        $close = "    ] }"
        if ($c -lt $codes.Count - 1) { $close += ',' }
        [void]$sb.AppendLine($close)
    }

    [void]$sb.AppendLine("  ]")
    [void]$sb.AppendLine("};")

    if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }
    $outFile = Join-Path $outDir "vocab.$id.js"
    [System.IO.File]::WriteAllText($outFile, $sb.ToString(), $Utf8NoBom)

    foreach ($code in $codes) {
        Write-Host ("    {0,-5} {1,4} Vokabeln" -f $code, $units[$code].Count) -ForegroundColor DarkGray
    }
    $kb = [math]::Round((Get-Item $outFile).Length / 1KB)
    Write-Host ("  [ok  ] {0} Vokabeln in {1} Lektionen -> web\data\vocab.{2}.js ({3} KB)" -f $count, $codes.Count, $id, $kb) -ForegroundColor Green
    $built++
}

if ($built -eq 0) {
    Write-Host "  [--  ] Kein vocab-src\agp<N>.tsv gefunden - nichts zu tun." -ForegroundColor DarkYellow
}
