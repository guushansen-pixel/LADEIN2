/*
 * Band-, Kapitel- und Lektions-Metadaten zu AGITE plus, Ausgabe Bayern
 * (Westermann/Schoeningh), Latein als zweite Fremdsprache.
 *
 * Diese Datei ist von Hand gepflegt und eingecheckt - anders als die
 * generierten vocab.agp<N>.js. Kapiteltitel, Lektionsnummern sowie die
 * Titel von Kulturteil (K:) und Lektionstext (L:) stammen woertlich aus den
 * frei herunterladbaren Inhaltsverzeichnis-PDFs auf westermann.de; die
 * lateinischen Titel stehen dort mit Laengenzeichen und bleiben so.
 *
 * Band 1 (6. Klasse) fehlt bewusst: die App
 * wird ab Agite plus 2 gebraucht. Kommt er dazu, wird hier ein weiterer
 * Eintrag 'agp1' ergaenzt und tools\build-vocab.ps1 einmal dafuer laufen
 * gelassen, sonst aendert sich nichts.
 */
window.VOCAB_INDEX = {
  bands: [
    {
      id: 'agp2', n: 2, label: 'Agite plus 2', grade: '7. Klasse',
      isbn: '978-3-14-010441-8',
      chapters: [
        { title: 'Mythen Europas',              from: 21, to: 25, emoji: '🏺' },
        { title: 'Griechische Kultur in Rom',   from: 26, to: 30, emoji: '🏛️' },
        { title: 'Krisen der römischen Republik', from: 31, to: 35, emoji: '⚔️' },
        { title: 'Die Zeit des Kaisers Augustus',  from: 36, to: 40, emoji: '👑' }
      ],
      lessons: {
        L21: { kultur: 'Der Name unseres Kontinents',  text: 'Der Raub der Europa' },
        L22: { kultur: 'Theseus und der Minotaurus',   text: 'Im Labyrinth eines Monsters' },
        L23: { kultur: 'Ein genialer Erfinder',        text: 'Daedalus und Ikarus' },
        L24: { kultur: 'Kann Musik den Tod überwinden?', text: 'Abstieg in die Unterwelt' },
        L25: { kultur: 'Das Schicksal des Oedipus und seiner Kinder', text: 'Wer hat das Recht?' },
        L26: { kultur: 'Alexander und Diogenes – Weltherrscher trifft Philosophen', text: 'Wer ist wunschlos glücklich?' },
        L27: { kultur: 'Die sieben Weltwunder',        text: 'Ein wahnsinniger Brandstifter' },
        L28: { kultur: 'Römische Literatur und ihre griechischen Vorbilder', text: '„Das Gespensterstück“ – eine römische Komödie' },
        L29: { kultur: 'Das bezwungene Griechenland „bezwingt“ die siegreichen Römer', text: 'Fremde sind bei uns nicht erwünscht!' },
        L30: { kultur: 'Die Römer auf Sizilien',  text: '„Störe meine Kreise nicht!“' },
        L31: { kultur: 'Roms schlimmster Feind',       text: 'Panik in Rom' },
        L32: { kultur: 'Gaius Iulius Caesar: Der Aufstieg zur Macht', text: 'In der Gewalt von Piraten' },
        L33: { kultur: 'Caesar, Cicero und der Kampf um die Republik', text: 'Kleopatra in Rom' },
        L34: { kultur: 'Der Niedergang der Republik',  text: 'Antonius ad portas!' },
        L35: { kultur: 'Von der Republik zur Kaiserherrschaft', text: 'Jetzt ist alles verloren!' },
        L36: { kultur: 'Aus Octavian wird Augustus',   text: 'Der Kaiser erinnert sich' },
        L37: { kultur: 'Römer und Germanen',      text: 'Eine schockierende Niederlage' },
        L38: { kultur: 'Der Dichter Horaz und sein Mäzen', text: 'Ein Dichter im Schlachtgetümmel' },
        L39: { kultur: 'Mythos und Liebe in den Gedichten Ovids', text: 'Sind Frauen geldgierig?' },
        L40: { kultur: 'Sagenhafte Verwandlungen: Ovids Metamorphosen', text: 'Pyramus und Thisbe' }
      }
    },
    {
      id: 'agp3', n: 3, label: 'Agite plus 3', grade: '8. Klasse',
      isbn: '978-3-14-010442-5',
      chapters: [
        { title: 'Griechische Philosophie in Rom', from: 41, to: 45, emoji: '🤔' },
        { title: 'Die frühe Kaiserzeit',      from: 46, to: 50, emoji: '🏛️' },
        { title: 'Rom und die Christen',           from: 51, to: 55, emoji: '✝️' },
        { title: 'Vom Ende des römischen Reiches bis in die Gegenwart', from: 56, to: 60, emoji: '⏳' }
      ],
      lessons: {
        L41: { kultur: 'Wer erklärt die Welt am besten?', text: 'Womit befasst sich ein Philosoph?' },
        L42: { kultur: 'Ein Orakelspruch und seine Folgen',    text: 'Wer ist der Weiseste?' },
        L43: { kultur: 'Ein lustvolles Leben',                 text: 'Zwei unterschiedliche Lebensweisen' },
        L44: { kultur: 'Ein Leben nach der Vernunft',          text: 'Wie kann ein Leben in der Politik glücklich machen?' },
        L45: { kultur: 'Seneca',                               text: 'Behandle die Sklaven wie deine Freunde!' },
        L46: { kultur: 'Die Fabeln des Phaedrus',              text: 'Ein sinnvolles Urteil?' },
        L47: { kultur: 'Gerechtigkeit und Rechtswesen',        text: 'Die Tricks der Redner vor Gericht' },
        L48: { kultur: 'Leben am Limes',                       text: 'Die Römer in Germanien – Besatzer oder Familienmitglieder?' },
        L49: { kultur: 'Die Nachfolger des Augustus',          text: 'Sind diese Kaiser wahnsinnig?' },
        L50: { kultur: 'Nero bei den Olympischen Spielen',     text: 'Ein Kaiser als Olympionike' },
        L51: { kultur: 'Nero als Christenverfolger',           text: 'Wer hat Rom in Brand gesteckt?' },
        L52: { kultur: 'Christenverfolgung in der mittleren Kaiserzeit', text: 'Wie soll man mit den Christen umgehen?' },
        L53: { kultur: 'Tod im Amphitheater',                  text: 'Tod im Namen des Glaubens' },
        L54: { kultur: 'Von der Antike zur Spätantike',   text: 'Hōc sīgnō vincēs!' },
        L55: { kultur: 'Lateinische Literatur der Spätantike', text: 'Cicerōniānus es, nōn Chrīstiānus!' },
        L56: { kultur: 'Der Niedergang des Weströmischen Reichs', text: 'Ein Christ als Berater eines römischen Feldherren' },
        L57: { kultur: 'Aus römischen Provinzen wird das Frankenreich', text: 'Eine echte Bekehrung?' },
        L58: { kultur: 'Latein im Mittelalter',                text: 'Karl der Große – ein Vordenker in Sachen Bildung' },
        L59: { kultur: 'Petrarca und der Renaissance-Humanismus', text: 'Was Petrarca Cicero zu sagen hat' },
        L60: { kultur: 'Latein – auch heute noch lebendig', text: 'Vicipaedia – lībera encyclopaedia: Sōcratēs' }
      }
    }
  ],

  // Wortarten. LateinLex nennt sie nicht, der Konverter leitet sie aus der
  // Form ab (Stammformen -> Verb, Genusangabe -> Nomen, 'Adv.' -> Adverb,
  // mehrteilig -> Wendung; Regeln siehe README). Trifft 97 %, der Rest ist 'x'.
  // buildOptions() zieht damit Ablenker derselben Wortart.
  posLabels: {
    n: 'Nomen', v: 'Verb', adj: 'Adjektiv', adv: 'Adverb',
    pron: 'Pronomen', praep: 'Präposition', konj: 'Konjunktion',
    num: 'Zahlwort', wend: 'Wendung', name: 'Eigenname', x: 'sonstiges'
  }
};
