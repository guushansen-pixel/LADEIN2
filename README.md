# Latein-Trainer – AGITE plus Bayern (Klasse 7–8)

Offline-Vokabeltrainer für **AGITE plus, Ausgabe Bayern** (Westermann/Schöningh),
Latein als zweite Fremdsprache am bayerischen Gymnasium – **Band 2 (Klasse 7,
Lektion 21–40)** und **Band 3 (Klasse 8, Lektion 41–60)**. Reine Web-App, die
per [apk-builder](../apk-builder) zur signierten Android-APK wird – kein
Framework, keine externen Abhängigkeiten, kein Netzwerkzugriff zur Laufzeit.

Zwei Abfragearten: **Multiple Choice** und **Selbsteingabe** mit toleranter
Prüfung. Dazu ein Leitner-Boxensystem, ein automatisches Deck „Schwierige
Wörter" und ein Editor für eigene Listen.

Entstanden als Kopie des Schwesterprojekts
[vokabeltrainer](../vokabeltrainer) (Green Line, Englisch). Die Lernlogik ist
dieselbe; was sich unterscheidet, steht unten unter „Was hier anders ist als
beim Englisch-Trainer".

## Woher die Vokabeln kommen

Der Wortschatz stammt aus dem Vokabular **„AGITEplus"** auf
**[LateinLex](https://lateinlex.de)**, einer frei zugänglichen Lateinplattform
(Wörterbuch nach Georges, Textbibliothek, Vokabeltrainer; betrieben von
Nikolaus Deiser, München). Dort liegt der Lernwortschatz **lektionsweise von
Lektion 1 bis 60**, also für alle drei Bände von Agite plus:

| | |
| --- | --- |
| Einstieg | `lateinlex.de/?call=Voc&permalink=Tre17` |
| eine Lektion | `?call=Voc&permalink=Tre17-<n−1>` (Lektion 21 = `Tre17-20`) |
| Inhalt je Eintrag | Lemma mit Längenzeichen, Stammformen bzw. Genitiv und Genus, mehrere deutsche Bedeutungen, Konstruktionsangaben (`m. Dat.`, `ad m. Akk.`) |
| Umfang hier | **948 Vokabeln** – 509 in Band 2 (L21–40), 439 in Band 3 (L41–60) |

Zwei Gegenproben, dass das wirklich der Agite-plus-Wortschatz ist und nicht
irgendeine Latein-Liste: die Lektionsinhalte passen thematisch aufs Buch
(Lektion 21 „Der Raub der Europa" bringt *taurus*, *fōrma*, *virgō*, *mūtāre*),
und die Wortzahlen stimmen mit unabhängigen Quellen überein – Lektion 22 hat
hier wie in den öffentlichen Quizlet-Sets 19 Einträge, Lektion 23 in beiden 21.
phase-6 gibt für Band 2 532 und für Band 3 458 Wortpaare an; unsere 509 bzw.
439 liegen bei 96 %, die Differenz sind vermutlich zusätzlich gezählte
Junkturen.

`robots.txt` von lateinlex.de sperrt gezielt Lexikon- und Textseiten, die
Vokabelseiten (`?call=Voc`) ausdrücklich nicht. Die Seiten wurden einmalig und
nacheinander abgerufen. **Rechtlich ändert das nichts:** die Wortauswahl ist
die des Lehrwerks, privat lernen ist unproblematisch, weitergeben nicht.
Deshalb bleiben `vocab-src/` und `web/data/vocab.agp*.js` in `.gitignore`.

### Warum nicht direkt vom Verlag

Beim Green-Line-Trainer war das einfach: Klett stellt den Lernwortschatz aller
Bände als kostenlose PDFs bereit – ursprünglich als Hilfe für ukrainische
Geflüchtete. **Für AGITE plus gibt es nichts Vergleichbares.** In drei
Durchgängen gesucht und ausgeschlossen:

| Quelle | Befund |
| --- | --- |
| [Klett-Vokabellisten](https://www.klett.de/inhalt/vokabellisten/startseite/256463) – die Green-Line-Quelle | nur Englisch, Französisch, Spanisch – **kein Latein**; Agite plus ist ohnehin Westermann |
| Westermanns eigenes Geflüchteten-Programm | nur *Camden Market* und *Notting Hill Gate* (Englisch) |
| [westermann.de, Agite plus 1–3](https://www.westermann.de/reihe/W00646/Agite-plus-Arbeitsbuecher-fuer-Latein-als-zweite-Fremdsprache-Ausgabe-Bayern) | frei ist **nur das Inhaltsverzeichnis** je Band |
| phase-6, cabuu | haben die offiziellen Daten, kostenpflichtig |
| Quizlet | Bruchstücke; Zugriff per Cloudflare gesperrt (HTTP 403), Scraping laut AGB untersagt |
| [latin-is-simple.com](https://www.latin-is-simple.com/de/vocabulary/groupgroup/55/) | führt „Agite plus I" als Lehrwerk, darin aber **genau eine** Lektion (L12) |
| Schul-Websites, `filetype:pdf` über DuckDuckGo und Bing | keine lektionsgeordnete Agite-Wortliste; nur Schulaufgaben-Übungsblätter |
| LearningApps | eine einzige Agite-App, und die ist Grammatik („Konjunktiv Präsens – Agite II L33") |
| AnkiWeb Shared Decks | **null** Treffer für „agite" |
| karteikarte.com, repetico, knowunity, studysmarter | Cursus, Prima, Campus – Agite plus nicht |
| GitHub (Repo-Suche + Code-Suche über grep.app) | nichts zu Agite plus |
| docplayer, yumpu, studocu, scribd | nichts |
| Google Books, ISBN 9783140104500 | nur der bibliografische Eintrag, **keine Leseprobe** |
| eduki, lehrermarktplatz, Westermann-Mediencode | nichts |
| Wayback Machine: Westermanns kompletter Anlagen-Index (35.679 URLs) und der Dateinamen-Index des Downloadservers `c.wgr.de` (182.636 URLs) | **null** Treffer für Vokabel-/Wortschatzdateien zu Agite – der Verlag hat nie eine ausgeliefert |
| archive.org, DNB, HathiTrust, Google Books, Buchhändler-Leseproben | nur Inhaltsverzeichnisse; die einzige echte Vokabelseite im Netz ist Lektion **10** im Werbeprospekt zu Band 1 |

Im Repo liegen deshalb nur Code, die Skripte, die Strukturdaten und eine
eigene Demo-Liste.

Falls LateinLex einmal verschwindet, bleibt der Weg über das **eigene Buch**:
das Vokabelheft (ISBN 978-3-14-010450-0) deckt laut Westermann „6. Schuljahr
bis 8. Schuljahr" ab, also alle drei Bände in einem Heft. Dafür ist
`tools/inspect-scans.ps1` da.

Frei verwertbar ist immerhin die **Struktur**: die
Inhaltsverzeichnis-PDFs von westermann.de liefern alle Lektionsnummern, die
Titel von Kulturteil und Lektionstext und die vier Themenkapitel je Band. Die
stehen wörtlich in `web/data/index.js` – samt Längenzeichen in den
lateinischen Titeln (*Hōc sīgnō vincēs!*, *Cicerōniānus es, nōn Chrīstiānus!*).

### Wie die Extraktion funktioniert

Zwei Stufen, damit nichts still Erfundenes in die App gerät:

```powershell
# 1. Lektionsseiten von lateinlex.de lesen -> vocab-src\agp<N>.tsv (siehe unten)
.\tools\build-vocab.ps1 -Band 2   # 2. TSV -> web\data\vocab.agp2.js
```

**1. Die Lektionsseiten lesen.** LateinLex rendert seine Seiten per
JavaScript, `pdftotext` oder ein simpler HTTP-Abruf helfen also nicht –
gelesen wird im Browser. Der Aufbau ist sauber und stabil: `tr.selectable` ist
je ein Eintrag, `p.Fh` die Kopfform (darin `span.Fstamm` das Lemma), `p.Fs`
die Stammformen, `span.Ft` je eine Bedeutung, `span.Fann1` eine
Konstruktionsangabe. Die Eselsbrücken-Sätze hängen in `div.wordimage` und
fallen damit von selbst weg.

Drei Dinge werden beim Lesen begradigt, und sie sind der Grund, warum das
nicht einfach ein Copy-Paste ist:

- `das Wohl(ergehen)` wird zu **beiden** Varianten aufgefächert. Sonst zählt
  getipptes „Wohlergehen" als falsch, weil `normalize()` Klammerzusätze wegwirft.
- Eine Konstruktionsangabe, die im Bedeutungstext schon steht, wird nicht
  zusätzlich davorgesetzt – sonst steht *Cicero* zweimal mit seinen Lebensdaten da.
- Die **Wortart ist abgeleitet**, nicht aus der Quelle übernommen: Stammformen
  vorhanden → Verb, Genusangabe (`m`, `f`, `n`, `m/f`, auch mit `Pl.`) → Nomen,
  `Adv.`/`Präp.`/`Subj.`/`Konj.` in der Formenspalte → entsprechend,
  mehrteiliger Eintrag → Wendung, deutsche Zahlwörter → Zahlwort, sonst
  Adjektiv. Das trifft 97 % (29 von 948 bleiben „sonstiges").

**2. Das TSV in der Mitte** ist kein Umweg. Es ist die Fassung, die sich Zeile
für Zeile gegenlesen lässt – eine generierte `.js` liest niemand nach:

```
L21	ducere	duco, duxi, ductum	v	führen; ziehen; leiten
L21	pax	pacis f.	n	Friede
L22	semper		adv	immer
```

**Der Konverter prüft und bricht ab**, statt stillschweigend etwas
Halbfertiges zu erzeugen: bei unbekannter Wortart, bei einer Lektion außerhalb
des Bandes (Band 2 = L21–L40), bei fehlenden Spalten, leerem Lemma oder leerer
Bedeutung und bei einem Lemma, das in derselben Lektion zweimal vorkommt –
dann wären die Wortschlüssel in localStorage nicht eindeutig und der zweite
Eintrag würde den Lernstand des ersten mitbenutzen. Am Ende steht die Anzahl
je Lektion als Gegenprobe.

Genau diese Doppelungssperre ist dreimal angeschlagen: `quīdam` (L41),
`Athēniēnsis` (L42) und `quisque` (L49) stehen in der Quelle zweimal in
derselben Lektion, einmal adjektivisch und einmal substantivisch. Sie sind im
TSV zu je einem Eintrag zusammengefasst, mit beiden Formen und beiden
Bedeutungen – deshalb 439 statt 442 Vokabeln in Band 3.

## Datenmodell

`web/data/index.js` (eingecheckt) hält Band-Metadaten, Kapitel und
Lektionstitel, `web/data/vocab.agp<N>.js` (generiert) die Vokabeln:

```js
window.VOCAB_AGP2 = {
  band: 'agp2', version: 1,
  units: [{ code: 'L21', words: [
    { la: 'ducere', forms: 'duco, duxi, ductum', pos: 'v',
      de: ['führen', 'ziehen', 'leiten'], kind: 'w' },
    { la: 'pax', forms: 'pacis f.', pos: 'n', de: ['Friede'], kind: 'w' }
  ]}]
};
```

- `la` ist die Vokabel, wie sie abgefragt wird.
- `forms` sind Stammformen bzw. Genitiv und Genus. Sie stehen als eigene Zeile
  unter der Vokabel – bei **DE → LA erst nach der Antwort**, vorher wären sie
  die Lösung. Abgefragt werden sie nicht (siehe „Bewusst nicht drin").
- `pos` ist die Wortart (`n`, `v`, `adj`, `adv`, `pron`, `praep`, `konj`,
  `num`, `name`, `x`) – eine **Angabe aus dem Buch**, keine Heuristik.
- `de` ist immer eine **Liste** – mehrere gleichwertige Übersetzungen zählen
  bei der Selbsteingabe alle als richtig.
- `kind`: `w` = Einzelwort/kurze Wendung, `p` = ganzer Satz. Der Schalter
  „Nur Einzelwörter" filtert darüber, und in der gemischten Abfrage bekommen
  Sätze immer Multiple Choice statt Eintippen.

Bänder werden einzeln über ein eingefügtes `<script>`-Tag nachgeladen (nicht
per `fetch`, das unter `file://` scheitert).

## Lernlogik

**Leitner-Boxen 1–5 pro Vokabel.** Richtig → eine Box hoch (max. 5), falsch →
zurück auf Box 1, „fast richtig" (Tippfehler) → Box bleibt stehen. Ab Box 4
gilt eine Vokabel als „sitzt" und zählt in den Fortschrittsring.

**Portionsauswahl:** sortiert nach (Box aufsteigend, längster Abstand seit der
letzten Abfrage, Zufall), davon die ersten 10/15/20 – dann gemischt. Wer eine
Lektion mehrfach übt, bekommt also zuerst das, was noch nicht sitzt.

### Ablenker bei Multiple Choice

Ablenker, die offensichtlich unmöglich sind, machen die Frage wertlos – man
rät die richtige Antwort weg, ohne die Vokabel zu kennen. Die App zieht
deshalb gezielt **zwei (manchmal drei) nahe** Ablenker und **einen deutlich
verschiedenen**:

| Signal | Punkte | warum |
| --- | --- | --- |
| Gleiche Wortart | +4 (DE→LA) / +3 (LA→DE) | bei DE→LA ist es die Buchangabe und damit verlässlich; ein Verb gegen drei Nomen fällt sofort auf |
| Nachbarschaft in der Buchreihenfolge (±8) | +4 | eine Lektion hat keine Abschnitte – was im Wortschatz nebeneinander steht, gehört zusammen |
| Gleiche Art (Wort/Satz) | +2 | kein Einzelwort gegen einen ganzen Satz |
| Schreib-Ähnlichkeit | 0–10 | Anfangsbuchstabe, Wortanfang, Wortende, Länge, Wortzahl |

Gezogen wird gewichtet aus dem oberen Feld statt stur von oben – dieselbe
Vokabel sieht bei der nächsten Runde also nicht genau gleich aus. **Nie als
Ablenker** erscheint etwas, das für dieselbe Vokabel richtig wäre: weder eine
andere Übersetzung desselben Eintrags noch ein Wort, das sich eine Übersetzung
mit dem gefragten teilt.

### Tolerante Prüfung bei Selbsteingabe

Das ist das Stück, an dem die App steht oder fällt. Gefragt ist mal eine
deutsche Übersetzung, mal eine lateinische Vokabel – und die beiden Richtungen
werden **unterschiedlich streng** behandelt.

1. **Normalisieren:** Kleinschreibung, Klammerzusätze weg, Satzzeichen weg,
   Anführungszeichen weg, Mehrfach-Leerzeichen weg, führender deutscher
   Artikel weg.
2. **Falten, je nach Richtung:**
   - *deutsche Seite:* `ä/ae → a`, `ö/oe → o`, `ü/ue → u`, `ß/ss → s`. „Mäuse",
     „Maeuse" und „Mause" gelten alle.
   - *lateinische Seite:* Längen- und Kürzezeichen (`amāre` = `amare`), `u`/`v`
     (`servus` = `seruus`) und `i`/`j` (`iustus` = `justus`). Bewusst **nicht**
     die deutschen Umlautumschreibungen: deren `ae → a` und `ue → u` würden im
     Lateinischen echte Wortunterschiede einebnen – aus `puella` würde `pulla`.
3. **Alle Varianten prüfen:** jede Übersetzung aus `de`, und bei Einzelwörtern
   zusätzlich jeder Teil einer Aufzählung. Bei DE → LA zählt auch die volle
   Schreibweise mit Stammformen (`prōvidēre, prōvideō prōvīdī prōvīsum`) als
   richtig. Eine *einzelne* Stammform dagegen nicht: auf „sorgen für" ist
   `prōvīsum` das PPP und nicht die gesuchte Vokabel.
4. **Tippfehler:** Levenshtein-Distanz ≤ 1 bzw. ≤ 2 → „Fast! Achte auf die
   Schreibweise" mit der richtigen Lösung. Zählt als richtig, befördert die
   Vokabel aber **nicht** in die nächste Box. Die Untergrenze ist im Deutschen
   5 bzw. 9 Zeichen, im Lateinischen **7 bzw. 11**: dort ist ein Buchstabe oft
   ein anderes Wort oder eine andere Endung – `aequus`/`equus`,
   `caelum`/`celum`, `puella`/`pulla`, `amat`/`amas` – und genau die Endung ist
   das, worauf es ankommt.

Mit `?test=1` an der URL liegen `normalize`, `fold`, `foldLa`, `lev`,
`checkAnswer`, `acceptedList`, `parseImport` und mehr unter `window.__vt` zum
Prüfen in der Konsole.

## Wortschatz eingrenzen (Hausaufgabe)

Jedes Deck lässt sich über **Vokabeln auswählen** auf den Teil eingrenzen, der
heute dran ist. Die Liste steht in Buchreihenfolge und ist durchnummeriert,
damit „Nr. 1 bis 20" dem entspricht, was im Hausaufgabenheft steht.

- **Bereich**: „Nur Nr. \_\_ bis \_\_" setzt die Auswahl auf genau diesen Block
- **Schnellwahl**: *Alle*, *Keine*, *Noch offen* – und ein Knopf je **Wortart**
  (*Nomen*, *Verb*, *Adjektiv*, …). An der Stelle filtert der
  Green-Line-Trainer nach Abschnitt im Buch; eine Agite-Lektion hat keine, und
  „heute nur die Verben" ist die Hausaufgabe, die es bei Latein wirklich gibt.
- **Einzeln antippen** für Korrekturen

Die Auswahl wird je Deck und Band gespeichert. Auf der Startseite steht dann
„· 19 ausgewählt" an der Karte.

## Eigene Listen

Import per Einfügen, eine Vokabel pro Zeile. Als Trennzeichen zwischen Latein
und Deutsch gehen `=`, ein Tabulator, ` - ` und ` – `; mehrere gültige
Übersetzungen mit `;`:

```
pax = Friede
ducere = führen; ziehen; leiten
rex - König
urbs	Stadt
```

## Was hier anders ist als beim Englisch-Trainer

- **Keine Sprachausgabe.** Für Latein bringt Android keine Stimme mit, und eine
  fremdsprachige Ersatzstimme würde eine Aussprache vorgeben, die im Unterricht
  nicht gemeint ist. Damit entfallen `TtsBridge.java`, der `<queries>`-Block
  fürs Manifest und der `onDestroy`-Patch.
- **Stammformen** als Anzeigezeile unter der Vokabel, abschaltbar.
- **Zwei Faltungen** statt einer, und eine strengere Tippfehler-Toleranz auf
  der lateinischen Seite (siehe oben).
- **Wortart statt Abschnitt** als Filter und als Ablenker-Signal.
- **Kapitel als Zwischentitel** auf der Startseite – zwanzig Lektionen am Stück
  wären sonst eine Wand.
- **Terrakotta statt Grün** und ein anderes Icon (Schriftrolle statt
  Karteikarten): die beiden Apps liegen auf demselben Homescreen.
- **Port 8100** für den Testserver statt 8099 – getrennte Ports heißen
  getrennter localStorage.

## Speicher (localStorage)

| Key | Inhalt |
| --- | --- |
| `lateintrainer.settings.v1` | Theme, Band, Richtung, Modus, Portionsgröße, Filter, Stammformen |
| `lateintrainer.progress.v1` | `{ "agp2\|L21\|pax": {box, right, wrong, last} }` |
| `lateintrainer.stats.v1` | Lerntage (für die Serie), Übungen, Antworten |
| `lateintrainer.decks.v1` | eigene Listen |
| `lateintrainer.selection.v1` | eingegrenzter Wortschatz je Deck |

Der Präfix ist ein anderer als beim Vokabeltrainer – sonst teilen sich die
beiden Apps im Browser denselben Lernstand.

## Projektstruktur

```
build.ps1              apk-builder-Wrapper (Portrait-Lock, Keep-Screen-On, Predictive Back)
icon.xml               Launcher-Icon (Schriftrolle)
tools/
  inspect-scans.ps1    was liegt in source-scans\, hat es eine Textebene?
  build-vocab.ps1      geprueftes TSV -> web/data/vocab.agp<N>.js
  serve.ps1            lokaler Testserver auf http://localhost:8100
web/
  index.html           die komplette App (HTML+CSS+JS inline)
  data/index.js        Band-, Kapitel- und Lektions-Metadaten (eingecheckt)
  data/demo.js         eigene Demo-Liste als Fallback (eingecheckt)
  data/vocab.agp*.js   generiert, gitignored
source-scans/          Rohscans, gitignored
vocab-src/             geprueftes TSV je Band, gitignored
```

## Bauen und Testen

```powershell
.\tools\serve.ps1                                      # http://localhost:8100
.\build.ps1                                            # Debug-APK
.\build.ps1 -Release                                   # signierte Release-APK
.\build.ps1 -Release -Install                          # + adb install
.\build.ps1 -VersionName "1.1" -VersionCode 2 -Release # bei jedem Release hochzaehlen
```

**Im Browser immer über `serve.ps1` testen, nicht per `file://`** – dort
schalten Browser localStorage still ab, und der Lernfortschritt verschwindet
beim Neuladen, ohne dass ein Fehler erscheint.

## Geprüft

Im Browser über `http://localhost:8100` (Chromium):

- **Prüflogik:** 27 Fälle über `?test=1`, alle grün – Groß/Klein, deutsche
  Artikel, Umlaut-Umschreibungen, `ß`/`ss`, Längenzeichen in beide Richtungen,
  `u`/`v`, `i`/`j`, Stammformen-Eingabe, Mehrfach-Bedeutungen, ganze Sätze,
  die Tippfehler-Grenzen beider Richtungen und die vier Paare, an denen die
  lateinische Faltung *nicht* einebnen darf (`aequus`/`equus`,
  `caelum`/`celum`, `puella`/`pulla`, `amat`/`amas`)
- **Prüflogik an echten Einträgen:** 11 Fälle aus Band 2 – `providere` ohne
  Längenzeichen, `prōvidēre` mit voller Stammformenkette, `uirgo` für `virgō`,
  `justitia` für `iūstitia`, alle vier Bedeutungen von `salūs` inklusive der
  Klammervariante *Wohl(ergehen)*, `sorgen für` trotz vorangestellter
  Konstruktionsangabe; `flōs` gegen `fluctus` bleibt falsch
- **Konverter:** beide Bände laufen ohne Beanstandung durch (509 + 439 in je
  20 Lektionen), escapet `'` und `\` im Generat, bricht bei einer Zeile mit
  fehlendem Tabulator mit Zeilennummer ab und hat die drei doppelten Lemmata
  in Band 3 tatsächlich gemeldet
- **Wortzahlen gegengeprüft:** L22 = 19 und L23 = 21 stimmen mit unabhängigen
  öffentlichen Quizlet-Sets überein; die Bandsummen liegen bei 96 % der
  phase-6-Angaben
- **Ablenker auf echten Lektionsdaten**, je 350 gezogene Fragen in L21, L33,
  L40, L47 und L55 in beiden Richtungen: immer vier Optionen, **null**
  Dubletten, **95–100 %** der Fragen haben mindestens zwei Ablenker, die in
  Schreibweise oder Thema nahe liegen, bei **53–68 %** alle drei. In 7–18 %
  sticht die richtige Antwort durch ihre Länge heraus. Zum Vergleich der
  Green-Line-Trainer: 96–100 % bzw. 38–62 %, Längenausreißer 2–12 %
- **Stammformen-Zeile:** bei DE → LA vor der Antwort versteckt, danach
  sichtbar (über 14 Vokabeln durchgespielt); bei LA → DE sofort sichtbar
- **Wortart-Filter:** *Verb* wählt in der Demo-Liste genau die 5 Verben
- **Startseite:** Kapitel als Zwischentitel mit Lektionsbereich, Lektionskarten
  mit Titel aus dem Inhaltsverzeichnis; Übungs-Bildschirm zeigt zusätzlich das
  Kulturthema
- Helles und dunkles Theme, kein horizontales Scrollen auf 375 px

**Noch offen** – dafür braucht es ein Gerät:

- Kompletter Übungsdurchlauf auf einer echten Lektion mit echten
  Tastendrücken, Eingrenzung „Nr. 5 bis 24", Reload-Festigkeit von Fortschritt
  und Serie
- **Am Gerät** (Pixel 11 Pro): Zurück-Wischgeste während einer Übung,
  Bildschirmtastatur vs. Eingabefeld, Portrait-Lock, Keep-Screen-On,
  WebView-Force-Dark

## Bewusst nicht drin

Band 1 (Klasse 6, L1–20) – die Struktur ist vorbereitet, gebraucht wird die App
ab Band 2. Ein Stammformen-Trainer als eigener Modus. Formenbestimmung und
Grammatikabfrage. Sprachausgabe. Die alphabetischen Vokabelverzeichnisse als
Nachschlagewerk. Lernstatistiken über die Zeit und Erinnerungen.

---

Wortschatz zu AGITE plus, Ausgabe Bayern (© Westermann Bildungsmedien Verlag
GmbH, Braunschweig). Nur für den privaten Gebrauch.
