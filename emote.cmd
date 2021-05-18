#debug 10

var WINDOW Verbs
var COL1 WhiteSmoke
var COL2 #E0B0B0

put #clear %WINDOW
put #window show %WINDOW

if_1 then goto CHECK
put #echo >%WINDOW aqua SAY Emotion categories:
put #echo >%WINDOW
put #echo >%WINDOW 1:
put #link >%WINDOW ANGRY #parse angry
put #echo >%WINDOW 2:
put #link >%WINDOW BOUNCY #parse bouncy
put #echo >%WINDOW 3:
put #link >%WINDOW DOZY #parse sleepy
put #echo >%WINDOW 4:
put #link >%WINDOW LOVEY #parse love
put #echo >%WINDOW 5:
put #link >%WINDOW NERVOUS #parse nervous
put #echo >%WINDOW 6:
put #link >%WINDOW NICE #parse nice
put #echo >%WINDOW 7:
put #link >%WINDOW SAD #parse sad
put #echo >%WINDOW 8:
put #link >%WINDOW SLY #parse sly
put #echo >%WINDOW 9:
put #link >%WINDOW UTILITY #parse utility
CHECK: 
matchre ANGER ^(a|an|ang|ange|anger|angr|angry)$
matchre BOUNCY ^(b|bo|bou|boun|bounc|bounce|bouncy|bouncey)$
matchre LOVE ^(l|lo|lov|love|lovy|lovey)$
matchre SLEEPY ^(sle|slee|sleep|sleepy)$
matchre NERVOUS ^(n|ne|ner|nerv|nervo|nervos|nervou|nervous)$
matchre NICE ^(ni|nic|nice)$
matchre SAD (s|sa|sad)$
matchre SLY ^(sl|sly)$
matchre UTILITY ^(u|ut|uti|util|utili|utilit|utility)$
if_1 put #event 0.1 {#parse %1}
matchwait 

ANGER:
put #clear %WINDOW
put #echo >%WINDOW %COL1 mono "angrily          begrudgingly    bitterly     coldly"
put #echo >%WINDOW %COL2 mono "condescendingly  contemptuously  defiantly    disdainfully"
put #echo >%WINDOW %COL1 mono "disrespectfully  fearlessly      ferociously  fiercely"
put #echo >%WINDOW %COL2 mono "furiously        gruffly         grumpily     irritably"
put #echo >%WINDOW %COL1 mono "loathingly       malevolently    mockingly    patronizingly"
put #echo >%WINDOW %COL2 mono "rancidly         reproachfully   resentfully  sarcasticly"
put #echo >%WINDOW %COL1 mono "savagely         scornfully      sharply      snidely"
put #echo >%WINDOW %COL2 mono "spitefully       sternly         stormily     tersely"
put #echo >%WINDOW %COL1 mono "vehemently       vengefully      venemously   warningly"
exit

LOVE:
put #clear %WINDOW
put #echo >%WINDOW %COL1 mono "admiringly   adoringly     affectionately  bashfully"
put #echo >%WINDOW %COL2 mono "blissfully   fondly        helplessly      insinuatingly"
put #echo >%WINDOW %COL1 mono "longingly    lovingly      naughtily       passionately"
put #echo >%WINDOW %COL2 mono "quaveringly  rapturously   ravenously      tempestuously"
put #echo >%WINDOW %COL1 mono "tenderly     voraciously   warmly          weakly"
put #echo >%WINDOW %COL2 mono "wistfully    worshipfully  yearningly" 
exit

NICE:
put #clear %WINDOW
put #echo >%WINDOW %COL1 mono "calmly        carefully        compassionately  consolingly"
put #echo >%WINDOW %COL2 mono "courteously   delicately       gently           gingerly"
put #echo >%WINDOW %COL1 mono "graciously    hopefully        innocently       kindly"
put #echo >%WINDOW %COL2 mono "meekly        mildly           modestly         patiently"
put #echo >%WINDOW %COL1 mono "politely      primly           quietly          reassuringly"
put #echo >%WINDOW %COL2 mono "respectfully  serenely         softly           soothingly"
put #echo >%WINDOW %COL1 mono "sweetly       sympathetically  tactfully        thoughtfully"
exit               

BOUNCY:
put #clear %WINDOW
put #echo >%WINDOW %COL1 mono "brightly      cheekily     cheerfully      confidently"
put #echo >%WINDOW %COL2 mono "contentedly   delightedly  eagerly         ecstatically"
put #echo >%WINDOW %COL1 mono "euphorically  excitedly    fervently       gleefully"
put #echo >%WINDOW %COL2 mono "jovially      jubilantly   optimistically  playfully"
put #echo >%WINDOW %COL1 mono "proudly       sassily      squeakily       triumphantly" 
put #echo >%WINDOW %COL2 mono "valiantly     voraciously  wickedly        wildly"
exit

SLEEPY:
put #clear %WINDOW
put #echo >%WINDOW %COL1 mono "absentmindedly  dazedly       distractedly   dopily"
put #echo >%WINDOW %COL2 mono "dreamily        drowsily      drunkenly      faintly" 
put #echo >%WINDOW %COL1 mono "feebly          groggily      haggardly      haltingly" 
put #echo >%WINDOW %COL2 mono "hoarsely        incoherently  lethargically  quizzically" 
put #echo >%WINDOW %COL1 mono "sedately        shakily       sleepily       slowly" 
put #echo >%WINDOW %COL2 mono "tiredly         vacantly      vaguely        weakly" 
put #echo >%WINDOW %COL1 mono "wearily         wheezily      whiningly"
exit              

SLY:
put #clear %WINDOW
put #echo >%WINDOW %COL1 mono "darkly         coyly        cunningly     discreetly"
put #echo >%WINDOW %COL2 mono "dramatically   eerily       guardedly     maniacally" 
put #echo >%WINDOW %COL1 mono "mischievously  morbidly     mysteriously  ominously" 
put #echo >%WINDOW %COL2 mono "ponderously    quizzically  shrewdly      slyly" 
put #echo >%WINDOW %COL1 mono "smugly         solemnly     suavely       teasingly" 
put #echo >%WINDOW %COL2 mono "thoughtfully   vaguely      wryly"
exit

SAD:
put #clear %WINDOW
put #echo >%WINDOW %COL1 mono "bleakly      dejectedly    depressingly  despondently" 
put #echo >%WINDOW %COL2 mono "distantly    dully         gloomily      hauntingly"
put #echo >%WINDOW %COL1 mono "hopelessly   joylessly     miserably     morosely" 
put #echo >%WINDOW %COL2 mono "mournfully   numbly        painfully     quietly" 
put #echo >%WINDOW %COL1 mono "regretfully  remorsefully  resignedly    ruefully"
put #echo >%WINDOW %COL2 mono "sadly        shamefully    somberly      sorrowfully"
put #echo >%WINDOW %COL1 mono "tearfully    tiredly       unhappily     uninterestedly"
put #echo >%WINDOW %COL2 mono "uselessly    wearily       whiningly     wistfully"
put #echo >%WINDOW %COL1 mono "woodenly     yearningly"
exit               

NERVOUS:
put #clear %WINDOW
put #echo >%WINDOW %COL1 mono "anxiously      apprehensively  bashfully     cautiously"
put #echo >%WINDOW %COL2 mono "deferentially  desperately     doubtfully    fearfully"
put #echo >%WINDOW %COL1 mono "fretfully      guardedly       helplessly    hesitantly"
put #echo >%WINDOW %COL2 mono "incredulously  nervously       neurotically  obediently"
put #echo >%WINDOW %COL1 mono "quaveringly    queasily        reluctantly   sheepishly"
put #echo >%WINDOW %COL2 mono "shyly          slowly          stutteringly  timidly"
put #echo >%WINDOW %COL1 mono "uncomfortably  uneasily        warily        worriedly"
exit               

UTILITY:
put #clear %WINDOW
put #echo >%WINDOW %COL1 mono "ceremoniously    diplomatically  dryly          faithfully"
put #echo >%WINDOW %COL2 mono "firmly           flatly          hysterically   indignantly"
put #echo >%WINDOW %COL1 mono "imperiously      ironically      knowingly      loudly"
put #echo >%WINDOW %COL2 mono "piously          pityingly       pointedly      reverentially"
put #echo >%WINDOW %COL1 mono "sanctimoniously  sincerely       skeptically    slowly"
put #echo >%WINDOW %COL2 mono "stoically        tactfully       tempestuously  thoughtfully"
put #echo >%WINDOW %COL1 mono "urgently         valiantly       worshipfully   zealously"
exit               
