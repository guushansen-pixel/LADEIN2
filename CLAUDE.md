# Latein-Trainer

Offline-Vokabeltrainer zu **AGITE plus, Ausgabe Bayern** (Westermann/Schoeningh),
Latein als zweite Fremdsprache, **Band 2 und 3** (Klasse 7 und 8). Reine Web-App
in einer Datei, die per [apk-builder](../apk-builder) zur APK wird.
Datenherkunft, Extraktions-Pipeline, Datenmodell, Leitner-Logik und die
tolerante Antwortpruefung stehen in [README.md](README.md) - dort nachlesen
statt hier duplizieren.

Das Schwesterprojekt [vokabeltrainer](../vokabeltrainer) (Green Line, Englisch)
ist die Vorlage: `web/index.html` ist als Kopie davon entstanden. Wer hier etwas
an der Lernlogik aendert, schaut dort nach, ob es dieselbe Stelle auch gibt.

## Vokabeldaten

`web/data/vocab.agp*.js`, `vocab-src/` und `source-scans/` sind **gitignored**
und in einem frischen Klon nicht vorhanden.

**Anders als bei Green Line gibt es keine freie Netzquelle.** Klett stellt den
Lernwortschatz seiner Englisch-, Franzoesisch- und Spanischlehrwerke kostenlos
bereit (urspruenglich fuer ukrainische Gefluechtete) - fuer Latein gibt es das
nicht, und Agite plus ist ohnehin Westermann. Westermanns eigenes
Gefluechteten-Programm deckt nur *Camden Market* und *Notting Hill Gate* ab.
Frei herunterladbar sind von westermann.de nur die **Inhaltsverzeichnisse**;
daraus stammen die Lektions- und Kapiteltitel in `web/data/index.js`. Der
Wortschatz selbst kommt aus dem **eigenen Buch**. Wer das noch einmal
nachrecherchieren will: die vollstaendige Liste des Geprueften steht in der
README unter "Woher die Vokabeln kommen" - nicht neu suchen, es war schon
gruendlich.

Neu erzeugen:

```powershell
.\tools\inspect-scans.ps1     # was liegt in source-scans\, hat es eine Textebene?
# -> daraus vocab-src\agp<N>.tsv schreiben und gegenlesen
.\tools\build-vocab.ps1 -Band 2   # TSV -> web\data\vocab.agp2.js
```

Das TSV dazwischen ist kein Umweg, sondern der Punkt, an dem sich die Daten
gegen das Buch gegenlesen lassen. Eine generierte `.js` liest niemand nach.

## Build & Test

Kein Bundler, kein Build-Step fuer die Web-App selbst. Zum Testen **immer
ueber http**, nie per `file://` - dort ist localStorage still abgeschaltet und
jeder Lernfortschritt verschwindet beim Neuladen, ohne Fehlermeldung:

```powershell
.\tools\serve.ps1            # http://localhost:8100
```

Port 8100, nicht 8099: dort laeuft der Green-Line-Trainer. Beide gleichzeitig
offen zu haben ist beim Vergleichen praktisch, und getrennte Ports heissen
getrennter localStorage.

Mit `?test=1` an der URL liegen `normalize`, `fold`, `foldLa`, `lev`,
`checkAnswer`, `acceptedList`, `parseImport`, `buildOptions`, `similarity`,
`makeItem`, `wordsOfUnit` und `settings` unter `window.__vt` - Antwortpruefung
und Ablenkerqualitaet lassen sich damit aus der Konsole ueber hunderte Faelle
messen, statt sie durchzuklicken.

APK bauen - **nicht** direkt `apk-builder\new-app.ps1`/`build-apk.ps1`
aufrufen, sondern immer ueber den eigenen Wrapper, der Portrait-Lock,
Keep-Screen-On und den Predictive-Back-Handler nachpatcht (apk-builder
unterstuetzt nichts davon nativ, und `apps\Latein-Trainer` wird bei jedem
`-Force`-Lauf komplett neu generiert):

```powershell
.\build.ps1                              # Debug-APK
.\build.ps1 -Release                     # signierte Release-APK
.\build.ps1 -Release -Install            # + adb install auf verbundenes Geraet
.\build.ps1 -VersionName "1.1" -VersionCode 2 -Release   # bei jedem Release hochzaehlen
```

Was sich nur auf dem echten Geraet (Pixel 11 Pro) verifizieren laesst:
Zurueck-Wischgeste waehrend einer Uebung, ob die Bildschirmtastatur das
Eingabefeld verdeckt, Portrait-Lock, Keep-Screen-On, WebView-Force-Dark.

## Konventionen

- Alles in `web/index.html` (HTML+CSS+JS inline), kein Framework, keine
  externen Abhaengigkeiten - muss offline funktionieren. `new-app.ps1` wird
  ohne `-Online` aufgerufen.
- `icon.xml` liegt bewusst **neben** `web/`, nicht darin.
- Vokabelpakete werden per eingefuegtem `<script>`-Tag nachgeladen, nie per
  `fetch` - `fetch` scheitert unter `file://`.
- localStorage-Keys sind versioniert und namespaced
  (`lateintrainer.settings.v1`, `lateintrainer.progress.v1`, ...) - bei einer
  Schemaaenderung neue Versionsnummer statt stiller Migration. Der Praefix ist
  ein anderer als beim Vokabeltrainer, sonst teilen sich die beiden Apps im
  Browser denselben Lernstand.
- Lektionstitel, Kulturteil-Titel und Kapitel stehen **nur** in
  `web/data/index.js` - Aenderungen dort, nicht im Generat und nicht im
  App-Code. Sie sind aus den Inhaltsverzeichnis-PDFs woertlich uebernommen,
  samt Laengenzeichen in den lateinischen Titeln ("Hoc signo vinces!" steht
  dort als `Hōc sīgnō vincēs!`).
- **Es gibt keine Sprachausgabe.** Fuer Latein bringt Android keine Stimme
  mit, und eine fremdsprachige Ersatzstimme wuerde eine Aussprache vorgeben,
  die im Unterricht nicht gemeint ist. Deshalb fehlen hier `TtsBridge.java`,
  der `<queries>`-Block fuers Manifest und der `onDestroy`-Patch, die
  `vokabeltrainer\build.ps1` hat. Wer sie zurueckholen will, holt sich beides.
- **Zwei Faltungen, nicht eine.** `fold()` ist die deutsche Seite (Umlaute,
  `ss`/`ß`), `foldLa()` die lateinische (Laengenzeichen, `u`/`v`, `i`/`j`).
  `foldLa()` ist bewusst **nicht** aus `fold()` abgeleitet: dessen `ae -> a`
  und `ue -> u` sind deutsche Umlautumschreibungen und wuerden im
  Lateinischen echte Wortunterschiede einebnen (aus `puella` wuerde `pulla`).
  Welche gilt, entscheidet `item.dir`.
- **Die Tippfehler-Toleranz ist in der lateinischen Richtung strenger**
  (ab 7 bzw. 11 Zeichen statt 5 bzw. 9). Im Deutschen geht es um die
  Bedeutung, im Lateinischen ist ein Buchstabe oft ein anderes Wort oder eine
  andere Endung - `aequus`/`equus`, `caelum`/`celum`, `amat`/`amas`. Wer das
  lockern will, prueft vorher die Fallliste in der Konsole gegen genau diese
  Paare.
- Beim Erweitern der Antwortpruefung immer erst die Fallliste in der Konsole
  (`?test=1`) erweitern, dann den Code - die Pruefung ist das Stueck, an dem
  die App steht oder faellt.
- `word.pos` ist eine **Angabe aus dem Buch**, keine Heuristik. Deshalb wiegt
  "gleiche Wortart" in Richtung DE -> LA schwerer als in der Gegenrichtung, wo
  auf den Knoepfen deutsche Uebersetzungen stehen und wieder geraten werden
  muss. Wer an den Gewichten in `buildOptions()` dreht, misst die Wirkung ueber
  `?test=1` an mehreren hundert gezogenen Fragen nach, nicht an drei
  Beispielen - einzelne Ziehungen sagen bei zufaelliger Auswahl nichts.
- `word.idx` (Platz in der Buchreihenfolge) ist kein Deko-Feld. Eine Lektion
  hat im Buch keine Unterabschnitte, also ist die Nachbarschaft in dieser
  Reihenfolge das **einzige** Themensignal fuer die Ablenker - beim Bauen
  neuer Wortlisten mitsetzen.
- An der Stelle, an der der Green-Line-Trainer nach Abschnitt filtert
  (`Check-in`, `Station 1`), filtert dieser nach **Wortart**. "Heute nur die
  Verben" ist die Hausaufgabe, die es bei Latein tatsaechlich gibt.
- `showScreen(name, title, back)` bekommt als dritten Parameter die Funktion,
  die den darueberliegenden Bildschirm zeichnet (oder `null` fuer den Start).
  Es gibt bewusst immer nur **einen** History-Eintrag; nach einem `popstate`
  legt die naechste Ebene ihn neu an. Zurueck-Knopf und Zurueck-Geste muessen
  danach dieselbe Abfolge ergeben - beides nachpruefen, wenn sich am Router
  etwas aendert.
- Die Eingrenzung (`selections`) speichert Wortschluessel je Deck, nicht
  Indizes - eine bearbeitete eigene Liste soll die Auswahl nicht verschieben.
  "Alles ausgewaehlt" wird geloescht statt gespeichert, und `selectedWords()`
  faellt auf das ganze Deck zurueck, wenn keiner der gespeicherten Schluessel
  mehr existiert.
- Waehrend der Uebung haengen zwei Tastatur-Handler am selben Enter: einer
  am Eingabefeld (prueft, `stopPropagation`) und einer am `document`
  (schaltet weiter). `nextQuestion()` schaltet ausserdem nur weiter, wenn
  `quiz.answered` gesetzt ist, und loescht das Flag sofort - das faengt die
  Doppelausloesung mit dem nativen Klick des fokussierten Weiter-Knopfes ab.
  Wer daran etwas aendert, prueft beide Wege (Tastatur und Maus) und den
  Mehrfachklick nach.
- Farben sind Terrakotta statt des Gruens nebenan. Das ist kein Geschmack,
  sondern Unterscheidbarkeit: beide Apps liegen auf demselben Homescreen. Die
  Rueckmeldungsfarben (`--ok`/`--warn`/`--bad`) bleiben gruen/gelb/rot, die
  bedeuten etwas.
- Kein WebGL (siehe [hopper](../hopper): auf echtem Geraet stark geruckelt
  trotz sauberem Desktop-Test).

## Aktueller Stand

Siehe "Geprueft" in [README.md](README.md).
