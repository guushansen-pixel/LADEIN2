/*
 * Eigene kleine Demo-Liste - selbst zusammengestelltes Allerweltslatein,
 * kein Auszug aus AGITE plus. Sie ist eingecheckt, damit die App auch in
 * einem frischen Klon etwas anzeigt, bevor tools\build-vocab.ps1 die echten
 * Banddaten erzeugt hat.
 *
 * Ein paar Eintraege tragen absichtlich Laengenzeichen (amāre, Cōgitō) und ein
 * u statt v (seruus): daran laesst sich im Browser sofort sehen, ob fold()
 * beides zusammenfaltet.
 */
window.VOCAB_DEMO = {
  band: 'demo', version: 1,
  source: 'Eigene Demo-Liste (kein Lehrwerksauszug)',
  units: [
    {
      code: 'D1',
      words: [
        { la: 'amāre',    forms: 'amo, amavi, amatum',       pos: 'v',   de: ['lieben'], kind: 'w' },
        { la: 'videre',   forms: 'video, vidi, visum',       pos: 'v',   de: ['sehen'], kind: 'w' },
        { la: 'dicere',   forms: 'dico, dixi, dictum',       pos: 'v',   de: ['sagen', 'sprechen'], kind: 'w' },
        { la: 'venire',   forms: 'venio, veni, ventum',      pos: 'v',   de: ['kommen'], kind: 'w' },
        { la: 'esse',     forms: 'sum, fui, -',              pos: 'v',   de: ['sein'], kind: 'w' },
        { la: 'servus',   forms: 'servi m.',                 pos: 'n',   de: ['Sklave', 'Diener'], kind: 'w' },
        { la: 'amicus',   forms: 'amici m.',                 pos: 'n',   de: ['Freund'], kind: 'w' },
        { la: 'puella',   forms: 'puellae f.',               pos: 'n',   de: ['Mädchen'], kind: 'w' },
        { la: 'templum',  forms: 'templi n.',                pos: 'n',   de: ['Tempel'], kind: 'w' },
        { la: 'rex',      forms: 'regis m.',                 pos: 'n',   de: ['König'], kind: 'w' },
        { la: 'urbs',     forms: 'urbis f.',                 pos: 'n',   de: ['Stadt'], kind: 'w' },
        { la: 'bellum',   forms: 'belli n.',                 pos: 'n',   de: ['Krieg'], kind: 'w' },
        { la: 'aqua',     forms: 'aquae f.',                 pos: 'n',   de: ['Wasser'], kind: 'w' },
        { la: 'magnus',   forms: 'magna, magnum',            pos: 'adj', de: ['groß', 'bedeutend'], kind: 'w' },
        { la: 'bonus',    forms: 'bona, bonum',              pos: 'adj', de: ['gut'], kind: 'w' },
        { la: 'longus',   forms: 'longa, longum',            pos: 'adj', de: ['lang'], kind: 'w' },
        { la: 'semper',   forms: '',                         pos: 'adv', de: ['immer'], kind: 'w' },
        { la: 'numquam',  forms: '',                         pos: 'adv', de: ['nie', 'niemals'], kind: 'w' },
        { la: 'saepe',    forms: '',                         pos: 'adv', de: ['oft'], kind: 'w' },
        { la: 'sed',      forms: '',                         pos: 'konj', de: ['aber', 'sondern'], kind: 'w' },
        { la: 'quod',     forms: '',                         pos: 'konj', de: ['weil'], kind: 'w' },
        { la: 'in',       forms: '(+ Abl./Akk.)',            pos: 'praep', de: ['in', 'auf'], kind: 'w' },
        { la: 'seruus fessus est', forms: '',                pos: 'x',   de: ['Der Sklave ist müde.'], kind: 'p' },
        { la: 'Cōgitō, ergō sum.', forms: '',                pos: 'x',   de: ['Ich denke, also bin ich.'], kind: 'p' }
      ]
    }
  ]
};
