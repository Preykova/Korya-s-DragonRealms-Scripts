#debug 10

action goto END when ^Elanthia seems to fall away from under your feet as the entire world disappears
action goto END when ^You experience a great wrenching in your gut and everything goes utterly black

action var BERSERKED 0 when %BERSERK_STOP
action var TMREADY 1 when ^Your formation of a targeting pattern around (.*) has completed\.$
action var TMREADY 0 when %SPELLPREP
action var TMREADY 0 when ^Your target pattern dissipates|lose your targeting pattern.$
action var TMREADY 0 when ^Your concentration slips for a moment\, and your spell
action var SPELLREADY 0 when %SPELLPREP
action var SPELLREADY 0 when ^Your concentration slips for a moment\, and your spell is lost\.$
action var SPELLREADY 1 when ^You feel fully prepared to cast your spell\.$
action var RETARGET 1 when ^Your concentration lapses and you lose your targeting pattern.$|^Your target pattern dissipates
action var AIM 1 when ^You think you have your best shot possible now.$
action var TACTIC1 $2 when by landing (a|an) (\w+)
action var TACTIC2 $5 when by landing (a|an) (\w+)(,| and) (a|an) (\w+)
action var TACTIC3 $7 when by landing (a|an) (\w+), (a|an) (\w+)(,| and) (a|an) (\w+)
action var TACTIC4 $8 when by landing (a|an) (\w+), (a|an) (\w+), (a|an) (\w+) and (a|an) (\w+)
action var MONSTERSHORT $1 when ^You turn to face .* (.*)(\.|,)
action var MONSTERSHORT $2 when ^You .* are (facing|flanking|behind) .* (.*) \(.*\)
action var MONSTERSHORT pile of rubble when ^A rock guardian collapses into a pile of stone rubble\.
action var MONSTERFULL $1 when ^You turn to face (.*)(\.|,)
action var MONSTERFULL $2 when ^You .* are (facing|flanking|behind) (.*)(\(.*)
action var MONSTERAPP $3 when ^You .* are (facing|flanking|behind) .* (.*) \((\d)\)
action var APPRESET 1 when ^You turn to face
action var APPRESET 0 when ^You .* are (facing|flanking|behind) .* (.*) \(

action var TACTICDEPTH 1 when by landing (a|an) (\w+)\.$
action var TACTICDEPTH 2 when by landing (a|an) (\w+) and (a|an) (\w+)\.$
action var TACTICDEPTH 3 when by landing (a|an) (\w+), (a|an) (\w+) and (a|an) (\w+)\.$
action var TACTICDEPTH 4 when by landing (a|an) (\w+), (a|an) (\w+), (a|an) (\w+) and (a|an) (\w+)\.$
action var TACTICDEPTH ON when ^You can no longer see openings
action var COMBAT 1 when ^\[You\'re (.*) balanced (and|with)
action var COMBAT 0 when ^(balance|balanced)\]$
action var PICKUP 1 when ^All of your items lying at your feet\:
action var SWAP_TYPE $1 when as a (.*) weapon\.$

action var STARS 0 when is (dawn|morning|midday|afternoon|dusk)\.$
action var STARS 1 when is (sunset|evening|night|sunrise)\.$

var COMMANDS
if_1 then var COMMANDS %1 
if_2 then var COMMANDS %COMMANDS|%2
if_3 then var COMMANDS %COMMANDS|%3
if_4 then var COMMANDS %COMMANDS|%4
if_5 then var COMMANDS %COMMANDS|%5
#
# Commands list:
# noskin -- turn off kill looting
# stealthoff -- turn off hiding
# home -- use the .home script to return home after the hunt is complete
# quit -- log out when the hunt is complete
# empath -- skip attacks and only do TM/Debil/bobbing for tactics, until armors are mindlocked
# 

#### #### #### ### ### ### ## ## ## - USER VARIABLES - ## ## ## ### ### ### #### #### ####
# 
#    var GUILD [MoonMage|Thief|Barbarian|Empath|Bard|Ranger|etc]
#    var SPELLPREP [Your basic spell prep messaging; can be several, seperated by a | ]
#    var CAMBRINTH [0 = none, or can't use while worn yet; else, the noun of what you want to use]
#    var STONEPACK [the noun of the container where you want to store gweth stones]
#    var ARRANGE_ALL [0 for normal 5 arranges, 1 if you have the crafting technique for arrange all]
#    var REFILL_RATE [1-33]-- when a skill drains to this level, the script will train it again before ending
#    var START_RATE [1-33]-- when a skill is ABOVE this level on startup, the skill will NOT be trained
#    var DUAL_LOAD [0 if you cannot dual load, 1 if you can]
#    
#    var STANCE [60 60 60 100]--basic stance to return to after ranged training]
#    var EMPATH_STANCE [83 100 0 100]--stance to use when using the "empath" command 
#
#    var TRAINING_MAX_DEPTH [1-13]--the amount of weapon types to train
#    var TRAINING_LIST [Large_Edged|Twohanded_Edged|Heavy_Thrown|Brawling]-- weapon type name list, use name from vars listed below
#    var SWAPPABLES [Small_Edged|Twohanded_Edged]--weapon types that can swap 
#
#    var Small_Edged [short of the weapon for this weapon type]
#    var Large_Edged [can leave blank if not used]
#    var Twohanded_Edged [short of the weapon for this weapon type]
#    var Small_Blunt [short of the weapon for this weapon type]
#    var Large_Blunt [short of the weapon for this weapon type]
#    var Twohanded_Blunt [short of the weapon for this weapon type]
#    var Polearms [short of the weapon for this weapon type]
#    var Staves [short of the weapon for this weapon type]
#    
#    var Light_Thrown [short of the weapon for this weapon type]
#    var Heavy_Thrown [short of the weapon for this weapon type]
#    var Slings [short of the weapon for this weapon type]
#    var Slings_Ammo [short of the ammo used for this weapon type]
#    var Bow [short of the weapon for this weapon type]
#    var Bow_Ammo [short of the ammo used for this weapon type]
#    var Crossbow [short of the weapon for this weapon type]
#    var Crossbow_Ammo [short of the ammo used for this weapon type]
#
#    var ARMOR_MAX_DEPTH [1-5]--amount of skills to mindlock when using "empath" command
#    var ARMORS [Light_Armor|Chain_Armor|Plate_Armor|Brigandine|Shield_Usage]-- skill names for the above
#
#    var BUFFS [0-##]--amount of buff spells to keep active; one can be cyclic, debilitation spells can be used too
#    var BUFF_FULL [Shadows|Seer's Sense|Cage of Light|Shadow Web|Pyschic Shield]--proper long list of spell names, for $preparedspell 
#    var BUFF_SHORT [Shadows|SeersSense|CageofLight|ShadowWeb|PsychicShield]--compact list of spell names, for $SpellTimer variables
#    var BUFF_ABBREV [Shadows|Seer|COL|SHW|Psy]--spell name abbreviations for the parser to use
#    var BUFF_RELEASE [0|0|0|1|0]--0 normal, 1 to release the spell after the hunt is over to avoid criminal charges
#    var BUFF_CAST [0|0|moon|creature|0]--0 normal, moon will convert to Katamba/Yavash/Xibar, creature/area/all for AOE options
#    var BUFF_MANA [5|15|15|15|5]--base mana for each spell
#    var BUFF_CHARGE [32|32|32|0|32]--amount of mana to put into cambrinth, 0 skips cambrinth use
#
#    var TM_SPELLS [1]--see BUFFS
#    var TM_FULL [Dinazen Olkar]--see BUFF_FULL
#    var TM_SHORT [DO]--see BUFF_ABBREV
#    var TM_CAST [0]--see BUFF_CAST
#    var TM_MANA [7]--see BUFF_MANA
#    var DEBIL_SPELLS [2]--see BUFFS
#    var DEBIL_FULL [Sleep|Dazzle]--see BUFF_FULL
#    var DEBIL_SHORT [Sleep|Dazzle]--see BUFF_ABBREV
#    var DEBIL_CAST [0|0]--see BUFF_CAST
#    var DEBIL_MANA [9|9]--see BUFF_MANA
#
#    var APPRAISE [ON|OFF]--appraise each enemy after facing them
#    var OFFHAND [ON|OFF]--use small weapons in lefthand until $Offhand.LearningRate is full
#    var BACKSTAB [ON|OFF]--backstab for thieves
#    var STEALTH [ON|OFF]--hiding before attacking
#    var TARGETEDMAGIC [ON|OFF]--using targeted magic
#    var DEBILITATION [ON|OFF]--using debilitation magic
#
#    var AMBUSH [0|ambush stun|ambush slash]--ambush attack to use with thieves; 0 for no special ambush
#    var TACTICAL_KHRI_MAX [5]--amount of khri to use for normal hunting
#    var STEALTH_KHRI_MAX [5]--amount of khri to use when hiding/backstabbing
#    var RANGED_KHRI_MAX [3]--amount of khri to use when using a ranged weapon    
#    
#    var TACTICAL_KHRI [Prowess|Sagacity|Avoidance|Terrify|Harrier]--khri to use normally
#    var STEALTH_KHRI [Prowess|Sagacity|Shadowstep|Dampen|Darken]--khri to use when hiding/backstabbing
#    var RANGED_KHRI [Prowess|Sagacity|Steady]--khri to use when training ranged
#    (note that all Khri not listed in the active category will be disabled)
#
#    var BUFF_RELEASE_MESSAGING [the messages that show when you release your cyclics]
#

var BUFF_RELEASE_MESSAGING You cease your shadow weaving|The final tones of your enchante end with an abrupt flourish

if $charactername = Cleyra then
    {
    var GUILD MoonMage
    var SPELLPREP You raise your head skyward, chanting the equation of
    var CAMBRINTH armband
    var STONEPACK satchel
    var ARRANGE_ALL 1
    var REFILL_RATE 17
    var START_RATE 30
    var DUAL_LOAD 0
    
    var STANCE 60 60 60 100

    var TRAINING_MAX_DEPTH 4
    var TRAINING_LIST Small_Edged|Polearms|Heavy_Thrown|Brawling
    var SWAPPABLES 0

    var Small_Edged darkstone foil
    var Large_Edged 0
    var Twohanded_Edged 0
    var Small_Blunt 0
    var Large_Blunt 0
    var Twohanded_Blunt 0
    var Polearms predator's spear
    var Staves 0
    
    var Light_Thrown 0
    var Heavy_Thrown predator's spear
    var Slings 0
    var Slings_Ammo 0
    var Bow 0
    var Bow_Ammo 0
    var Crossbow 0
    var Crossbow_Ammo 0

    var ARMOR_MAX_DEPTH 1
    var ARMORS Light_Armor

    var BUFFS 4
    var BUFF_FULL Shadows|Seer's Sense|Cage of Light|Shadow Web|Pyschic Shield
    var BUFF_SHORT Shadows|SeersSense|CageofLight|ShadowWeb|PsychicShield
    var BUFF_ABBREV Shadows|Seer|COL|SHW|Psy 
    var BUFF_RELEASE 0|0|0|1|0
    var BUFF_CAST 0|0|moon|creature|0
    var BUFF_MANA 5|15|15|15|5
    var BUFF_CHARGE 32|32|32|0|32

    var TM_SPELLS 1
    var TM_FULL Dinazen Olkar
    var TM_SHORT DO
    var TM_CAST 0
    var TM_MANA 7
    var DEBIL_SPELLS 0
    var DEBIL_FULL Sleep|Dazzle
    var DEBIL_SHORT Sleep|Dazzle
    var DEBIL_CAST 0|0
    var DEBIL_MANA 9|9

    var APPRAISE ON
    var OFFHAND ON
    var BACKSTAB OFF
    var STEALTH ON
    var TARGETEDMAGIC ON
    var DEBILITATION ON
    }
    
if $charactername = Korya then
    {
    var GUILD Empath
    var SPELLPREP ^With meditative movements you prepare your body 
    var CAMBRINTH bracer
    var STONEPACK fox
    var ARRANGE_ALL 1
    var REFILL_RATE 30
    var START_RATE 30
    var DUAL_LOAD 0

    var STANCE 60 60 60 100
    var EMPATH_STANCE 83 100 0 100
    
    var TRAINING_MAX_DEPTH 4
    var TRAINING_LIST Staves|Crossbow|Large_Blunt|Brawling
    var SWAPPABLES 0

    var Small_Edged 0
    var Large_Edged 0
    var Twohanded_Edged 0
    var Small_Blunt 0
    var Large_Blunt haledroth greathammer
    var Twohanded_Blunt 0
    var Polearms 0
    var Staves finivire quarterstaff
    
    var Light_Thrown 0
    var Heavy_Thrown 0
    var Slings 0
    var Slings_Ammo 0
    var Bow 0
    var Bow_Ammo 0
    var Crossbow crossbow
    var Crossbow_Ammo bolt

    var ARMOR_MAX_DEPTH 4
    var ARMORS Light_Armor|Chain_Armor|Plate_Armor|Brigandine

    var BUFFS 2
    var BUFF_FULL Regenerate|Iron Constitution
    var BUFF_SHORT Regenerate|IronConstitution
    var BUFF_ABBREV Regen|IC
    var BUFF_RELEASE 0|0
    var BUFF_CAST 0|0
    var BUFF_MANA 9|32
    var BUFF_CHARGE 0|32

    var TM_SPELLS 1
    var TM_FULL Paralysis
    var TM_SHORT Paralysis
    var TM_CAST 0
    var TM_MANA 10
    var DEBIL_SPELLS 1
    var DEBIL_FULL Lethargy
    var DEBIL_SHORT Lethargy
    var DEBIL_CAST 0
    var DEBIL_MANA 10

    var APPRAISE ON
    var OFFHAND ON
    var BACKSTAB OFF
    var STEALTH OFF
    var TARGETEDMAGIC ON
    var DEBILITATION ON
    }


#### #### #### ### ### ### ## ## ## - RE-ORDER TRAINING - ## ## ## ### ### ### #### #### ####

put #gag {^.*}
EXP:
put exp all
matchre EXP ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre UNGAG ^EXP HELP
matchwait 1
UNGAG:
put #ungag {^.*}

var NUMBER 0
eval SKILL_NAME element("%TRAINING_LIST","%NUMBER")
var Do_%SKILL_NAME ON
var SKILLS %SKILL_NAME
var RANKS $%SKILL_NAME.Ranks

NEWLIST:
math NUMBER add 1
pause 0.0001
if %NUMBER = %TRAINING_MAX_DEPTH then goto CONTINUE
eval SKILL_NAME element("%TRAINING_LIST","%NUMBER")
var Do_%SKILL_NAME ON
var SKILLS %SKILLS|%SKILL_NAME
var RANKS %RANKS|$%SKILL_NAME.Ranks
goto NEWLIST

CONTINUE:
var TRAINING_LIST nothing
var RANK_LIST nothing
var LOOP_COUNTER %TRAINING_MAX_DEPTH

NEW_LOOP:
var COMPARE 9999

OUTER_LOOP:
var NUMBER 0
var TEMPLIST nothing

INNER_LOOP:
eval SKILL element("%SKILLS","%NUMBER")
eval RANK element("%RANKS","%NUMBER")
if matchre ("%TRAINING_LIST","%SKILL") then goto NEXT_RANK

if %RANK < %COMPARE then goto LOWER
# else, its equal or higher

NEXT_RANK:
math NUMBER add 1
if %NUMBER = %TRAINING_MAX_DEPTH then goto FOUND_LOWEST
if %NUMBER < %TRAINING_MAX_DEPTH then goto INNER_LOOP

LOWER:
var SAVERANK %RANK
var SAVESKILL %SKILL
var COMPARE %RANK
goto OUTER_LOOP

FOUND_LOWEST:
var RANK_LIST %RANK_LIST|%SAVERANK
var TRAINING_LIST %TRAINING_LIST|%SAVESKILL
math LOOP_COUNTER subtract 1
if %LOOP_COUNTER = 0 then goto END_SORT
goto NEW_LOOP

END_SORT:
eval TRAINING_LIST replacere("%TRAINING_LIST","nothing\|","")
eval ECHO_LIST replacere("%TRAINING_LIST","\|",", ")
eval RANK_LIST replacere("%RANK_LIST","nothing\|","")
eval RANK_LIST replacere("%RANK_LIST","\.\d\d","")
eval RANK_LIST replacere("%RANK_LIST","\|",", ")
put #echo
put #echo Going to train: %ECHO_LIST
put #echo Lowest to Highest: %RANK_LIST
put #echo


#### #### #### ### ### ### ## ## ## - RESET VARIABLES - ## ## ## ### ### ### #### #### ####


if $Brawling.LearningRate        >= %START_RATE then var Do_Brawling OFF
if $Small_Edged.LearningRate     >= %START_RATE then var Do_Small_Edged OFF
if $Large_Edged.LearningRate     >= %START_RATE then var Do_Large_Edged OFF
if $Twohanded_Edged.LearningRate >= %START_RATE then var Do_Twohanded_Edged OFF
if $Small_Blunt.LearningRate     >= %START_RATE then var Do_Small_Blunt OFF
if $Large_Blunt.LearningRate     >= %START_RATE then var Do_Large_Blunt OFF
if $Twohanded_Blunt.LearningRate >= %START_RATE then var Do_TwoHanded_Blunt OFF
if $Polearms.LearningRate        >= %START_RATE then var Do_Polearms OFF
if $Staves.LearningRate          >= %START_RATE then var Do_Staves OFF
if $Light_Thrown.LearningRate    >= %START_RATE then var Do_Light_Thrown OFF
if $Heavy_Thrown.LearningRate    >= %START_RATE then var Do_Heavy_Thrown OFF
if $Slings.LearningRate          >= %START_RATE then var Do_Slings OFF
if $Bow.LearningRate             >= %START_RATE then var Do_Bow OFF
if $Crossbow.LearningRate        >= %START_RATE then var Do_Crossbow OFF

var ALLKHRI Avoidance|Calm|Credence|Cunning|Dampen|Darken|Eliminate|Elusion|Endure|Evanescence|Flight|Focus|Guile|Harrier|Hasten|Intimidate|Muse|Plunder|Prowess|Safe|Sagacity|Sensing|Serenity|Shadowstep|Sight|Silence|Slight|Steady|Strike|Terrify|Vanish|0
var APPLIST blank|first|second|third|fourth|fifth|sixth|seventh|eighth|ninth|tenth|eleventh|twelfth
var MOONSPELLS Cage of Light|Whole Displacement|Burn|Moonblade|Dazzle
var STARSPELLS Starlight Sphere
var TRAINING_DEPTH 0
var KHRI_DEPTH 0
var BUFF_DEPTH 0
var DEBIL_CYCLE 0
var TM_CYCLE 0
var STARS 0
var LAST_FIGHT_TYPE none
var Brawling Brawling
var AMMO notusingammoyet
var DO_SPELL_TYPE DEBIL
var STEALTH_OVERRIDE %STEALTH
if $Appraisal.Ranks <= 76 then var APPRAISE OFF
var APPRAISE_OVERRIDE %APPRAISE
var APPRESET 0
if matchre("%GUILD","Bard|Barbarian") then var VOICE 1

var DEBIL_CYCLE_MAX %DEBIL_SPELLS
var TM_CYCLE_MAX %TM_SPELLS
var MONSTERSHORT nothing
var KILLS 0
var LAST_ATTACK 0
put /timers start HUNT
put /timers start LOOT
put /timers start APPRAISE
if !matchre ("%GUILD", "Thief|Barbarian") then put /timers start MANA
if %GUILD = Barbarian then put /timers start MANEUVER
if %GUILD = Barbarian then put /timers start ROAR%ROAR
if %GUILD = Empath then put /timers start HEALTH
if %GUILD = Bard then put /timers start SCREAM
if %GUILD = MoonMage then gosub MOONCHECK
if matchre ("%COMMANDS","empath") then gosub EMPATH_STANCE
goto ASSESS

MOONCHECK:
gosub RETREAT
pause 0.5
put observe sky
matchre MOONCHECK ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^Roundtime\:|^That's a bit hard to do while inside\.
matchwait




#### #### #### ### ### ### ## ## ## - FIGHT - SKILL SELECT - ## ## ## ### ### ### #### #### ####



FIGHT:
gosub APPRAISE
math LAST_ATTACK set 0

if $Offhand_Weapon.LearningRate  <= %REFILL_RATE then var OFFHAND ON
if %STEALTH_OVERRIDE = ON then
	{
	if $Stealth.LearningRate <= %REFILL_RATE then var STEALTH ON
	}
if $Targeted_Magic.LearningRate  <= %REFILL_RATE then var TARGETEDMAGIC ON
if $Debilitation.LearningRate    <= %REFILL_RATE then var DEBILITATION ON
if %GUILD = Thief then
    {
    if $Backstab.LearningRate    <= %REFILL_RATE then var BACKSTAB ON
    }
if $Brawling.LearningRate        <= %REFILL_RATE then var Do_Brawling ON
if $Small_Edged.LearningRate     <= %REFILL_RATE then var Do_Small_Edged ON
if $Large_Edged.LearningRate     <= %REFILL_RATE then var Do_Large_Edged ON
if $Twohanded_Edged.LearningRate <= %REFILL_RATE then var Do_Twohanded_Edged ON
if $Small_Blunt.LearningRate     <= %REFILL_RATE then var Do_Small_Blunt ON
if $Large_Blunt.LearningRate     <= %REFILL_RATE then var Do_Large_Blunt ON
if $Twohanded_Blunt.LearningRate <= %REFILL_RATE then var Do_TwoHanded_Blunt ON
if $Polearms.LearningRate        <= %REFILL_RATE then var Do_Polearms ON
if $Staves.LearningRate          <= %REFILL_RATE then var Do_Staves ON
if $Light_Thrown.LearningRate    <= %REFILL_RATE then var Do_Light_Thrown ON
if $Heavy_Thrown.LearningRate    <= %REFILL_RATE then var Do_Heavy_Thrown ON
if $Slings.LearningRate          <= %REFILL_RATE then var Do_Slings ON
if $Bow.LearningRate             <= %REFILL_RATE then var Do_Bow ON
if $Crossbow.LearningRate        <= %REFILL_RATE then var Do_Crossbow ON

# when skills are locked:

if $Offhand_Weapon.LearningRate  >= 34 then var OFFHAND OFF
if $Stealth.LearningRate         >= 34 then var STEALTH OFF
if $Targeted_Magic.LearningRate  >= 34 then var TARGETEDMAGIC OFF
if $Debilitation.LearningRate    >= 34 then var DEBILITATION OFF
if %GUILD = Thief then
    {
    if $Backstab.LearningRate    >= 34 then var BACKSTAB OFF
    }
if $Brawling.LearningRate        >= 34 then var Do_Brawling OFF
if $Small_Edged.LearningRate     >= 34 then var Do_Small_Edged OFF
if $Large_Edged.LearningRate     >= 34 then var Do_Large_Edged OFF
if $Twohanded_Edged.LearningRate >= 34 then var Do_Twohanded_Edged OFF
if $Small_Blunt.LearningRate     >= 34 then var Do_Small_Blunt OFF
if $Large_Blunt.LearningRate     >= 34 then var Do_Large_Blunt OFF
if $Twohanded_Blunt.LearningRate >= 34 then var Do_TwoHanded_Blunt OFF
if $Polearms.LearningRate        >= 34 then var Do_Polearms OFF
if $Staves.LearningRate          >= 34 then var Do_Staves OFF
if $Light_Thrown.LearningRate    >= 34 then var Do_Light_Thrown OFF
if $Heavy_Thrown.LearningRate    >= 34 then var Do_Heavy_Thrown OFF
if $Slings.LearningRate          >= 34 then var Do_Slings OFF
if $Bow.LearningRate             >= 34 then var Do_Bow OFF
if $Crossbow.LearningRate        >= 34 then var Do_Crossbow OFF

pause
echo
echo %KILLS kills so far.
echo Facing %MONSTERFULL
echo

TRAINING:
if matchre ("%COMMANDS","empath") then goto DANCING
var WEAPON %%TRAINING
if %WEAPON != Brawling then gosub WIELD
if matchre ("%TRAINING", "Brawling|Large_Edged|Twohanded_Edged|Large_Blunt|Twohanded_Blunt|Polearms|Light_Thrown|Heavy_Thrown|Bow|Crossbow|Slings|Staves") then var OFFHAND OFF
goto %FIGHT_TYPE

TRAINING_DONE:
if %WEAPON != Brawling then gosub SHEATHE



#### #### #### ### ### ### ## ## ## - ASSESS + SUPPORT ROUTINES - ## ## ## ### ### ### #### #### ####



ASSESS:
if %TRAINING_DEPTH = %TRAINING_MAX_DEPTH then goto END
eval TRAINING element("%TRAINING_LIST","%TRAINING_DEPTH")

if matchre ("%TRAINING", "Small_Edged|Small_Blunt") then var FIGHT_TYPE STEALTH
if matchre ("%TRAINING", "Brawling|Large_Edged|Twohanded_Edged|Large_Blunt|Twohanded_Blunt|Polearms|Staves") then var FIGHT_TYPE TACTICAL
if matchre ("%TRAINING", "Light_Thrown|Heavy_Thrown") then var FIGHT_TYPE THROWN
if matchre ("%TRAINING", "Bow|Crossbow|Slings") then var FIGHT_TYPE RANGED

if %FIGHT_TYPE != %LAST_FIGHT_TYPE then var KHRICHANGE 1
var LAST_FIGHT_TYPE %FIGHT_TYPE

if %Do_%TRAINING = OFF then
    {
    math TRAINING_DEPTH add 1
    goto ASSESS
    }

if $preparedspell = None then var TMREADY 0
gosub CHECKSTANCE
gosub BUFFCHECK
gosub CHECKTIMERS
pause 0.5

DO_ASSESS:
put assess combat
matchre DO_ASSESS ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre FIGHT ^You are (behind|facing|flanking) a|^You (.*) are (behind|facing|flanking) a
matchre FACE ^(\w+) is facing a|is behind you|is flanking you
matchre LOOT ^What\'s the point in facing a dead
matchwait 5
echo
echo * * * WAITING %LAST_ATTACK SECONDS FOR BEASTIES... * * *
echo
matchre ASSESS begins to advance on you\!$|^You begin to advance on|closes to pole weapon range on you\!$|closes to melee range on you!
matchwait 15
math LAST_ATTACK add 20
goto DO_ASSESS


ASSESS_QUICK:
put assess combat
matchre ASSESS_QUICK ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^You are (behind|facing|flanking) a|^You (.*) are (behind|facing|flanking) a
matchwait 1
return

APPRAISE:
if %APPRAISE_OVERRIDE = ON then
	{
	if $Appraisal.LearningRate <= 30 then var APPRAISE ON
	}
if $Appraisal.LearningRate >= 34 then var APPRAISE OFF
if %APPRAISE = OFF then return
if %APPRESET = 1 then gosub ASSESS_QUICK
eval APPNUMBER element("%APPLIST", "%MONSTERAPP")

APPRAISE_ACTION:
var APPRESET 0
pause 0.5
put appraise %APPNUMBER %MONSTERSHORT quick
matchre APPRAISE_ACTION ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^You cannot appraise that when you are in combat\!|^\[Roundtime\:|^Taking stock|^Appraise what\?
matchwait



CHECKTIMERS:
if $Timers.HUNT.Elapsed >= 80 then gosub HUNT
if !matchre ("%GUILD", "Thief|Barbarian") then 
    {
    if $Timers.MANA.Elapsed >= 200 then gosub PERCMANA
    }
if %GUILD = Empath then
    {
    if $Timers.HEALTH.Elapsed >= 200 then gosub HEALTH
    }
if %GUILD = Bard then
    {
    if $Timers.SCREAM.Elapsed >= 30 then gosub SCREAM
    }
if %GUILD = Barbarian then
    {
    if $Timers.ROAR%ROAR.Elapsed >= 190 then gosub ROAR
    }
RETURN

FACE_RETREAT:
gosub RETREAT

FACE:
gosub CHECKSTANCE
math ATTACKEND set 0
put face next
matchre FACE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre FACE_RETREAT ^You are too closely engaged and will have to retreat first\.$
matchre LOOT ^What\'s the point in facing a dead
matchre ASSESS ^There is nothing else to face\!|^Face what?
matchre FIGHT ^You turn to face a|^You are already facing
matchwait

RETREAT:
gosub CHECKSTANCE
pause 0.5
put retreat
matchre RETREAT ^\.\.\.wait|^You are still stunned|^Sorry\,|^You retreat back to pole range.
matchre RETURN ^You retreat from combat\.|^You are already as far away as you can get\!
matchwait

HUNT:
if $Perception.LearningRate >= 31 then goto HUNTSUCCESS
pause 0.5
put hunt
matchre HUNT ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre HUNTSUCCESS ^You take note of all the tracks|^You find yourself unable
matchwait 1

HUNTSUCCESS: 
put /timers start HUNT
return

SCREAM:
if $Timers.SCREAM.Elapsed >= 400 then var VOICE 1
if %VOICE = 0 then return
if %COMBAT = 0 then return
pause 0.5
put scream havoc
matchre SCREAM ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre SCREAMSUCCESS Opening yourself as the conduit to the rage of every innocent slain
matchre NOVOICE ^You open your mouth\, then close it suddenly\, looking somewhat like a fish\.$
matchwait 1

SCREAMSUCCESS:
put /timers start SCREAM
return

NOVOICE:
var VOICE 0
if %GUILD = Bard then goto SCREAMSUCCESS
if %GUILD = Barbarian then goto ROARSUCCESS

ROAR:
if $Timers.ROAR%ROAR.Elapsed >= 400 then var VOICE 1
if %ROAR = 0 then return
if %COMBAT = 0 then return
if %VOICE = 0 then return
if $hidden = 1 then return
pause 0.5
put roar %ROARQUIET %ROAR
matchre ROAR ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre ROARSUCCESS ^Roundtime\:|^\[Roundtime
matchre NOVOICE ^Strain though you might\,
matchwait 1

ROARSUCCESS:
put /timers start ROAR%ROAR
return

HEALTH:
pause 0.5
put perc health
matchre HEALTH ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre HEALTHSUCCESS ^You close your eyes, drawing all your thoughts
matchwait 1

HEALTHSUCCESS: 
pause 2
if $stunned = 1 then gosub STUN_WAIT
put /timers start HEALTH
return

PERCMANA:
if $Attunement.LearningRate => 30 then goto PERCMANASUCCESS
pause 0.5
put perc mana
matchre PERCMANA ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre PERCMANASUCCESS ^Roundtime:
matchwait 1

PERCMANASUCCESS: 
put /timers start MANA
return

CHECKSTANCE:
if $standing = 0 then gosub STAND
if $stunned = 1 then gosub STUN_WAIT
if $preparedspell = None then var TMREADY 0
return

STUN_WAIT:
pause 0.5
if $stunned = 1 then goto STUN_WAIT
return

STAND:
pause 0.5
put stand
matchre STAND ^\.\.\.wait|^You are still stunned|^Sorry\,|^The weight of
matchre RETURN ^You stand|^You are already standing\.$
matchwait 1
goto STAND

RETURN:
return



#### #### #### ### ### ### ## ## ## - BUFFS - ## ## ## ### ### ### #### #### ####



BUFFCHECK:
if %GUILD = Thief then goto KHRICHECK
if %GUILD = Barbarian then goto FORMCHECK
if %BUFFS = 0 then return

if matchre ("$preparedspell","%BUFF_FULL") then
    {
    if %SPELLREADY = 0 then return
    goto BUFF_WAIT
    }
if $preparedspell != None then return

var BUFFCHECK 0

BUFFCHECK_LOOP:
eval BUFFSPELL_FULL element("%BUFF_FULL","%BUFFCHECK")
eval BUFFSPELL_SHORT element("%BUFF_SHORT","%BUFFCHECK")
eval BUFFSPELL_ABBREV element("%BUFF_ABBREV","%BUFFCHECK")
eval BUFFSPELL_MANA element("%BUFF_MANA","%BUFFCHECK")
eval BUFFSPELL_CHARGE element("%BUFF_CHARGE","%BUFFCHECK")
eval DO_SPELL_CAST element ("%BUFF_CAST","%BUFFCHECK")
if $SpellTimer.%BUFFSPELL_SHORT.active = 0 then gosub PREP_BUFF
math BUFFCHECK add 1
if %BUFFCHECK >= %BUFFS then return
goto BUFFCHECK_LOOP

PREP_BUFF:
if matchre ("%BUFFSPELL_FULL","%MOONSPELLS") then
	{
	var MOONS 0
	if matchre ("$moonKatamba|$moonYavash|$moonXibar","Up") then var MOONS 1
	if %MOONS = 0 then return
	}
if matchre ("%BUFFSPELL_FULL","%STARSSPELLS") then
	{
	gosub STARCHECK
	if %MOONS = 0 then return
	}
var SPELLREADY 0
gosub CHECKSTANCE
pause 0.5
put prep %BUFFSPELL_ABBREV %BUFFSPELL_MANA
matchre PREP_BUFF ^\.\.\.wait|^You are still stunned|^Sorry\,|^\[Enter your command again
matchre RETURN ^You are already preparing|^But you\'re already preparing
matchre BUFF_CHARGE %SPELLPREP
matchwait 

BUFF_CHARGE:
if %BUFFSPELL_CHARGE = 0 then goto BUFF_WAIT
gosub CHECKSTANCE
pause 0.5
put charge my %CAMBRINTH %BUFFSPELL_CHARGE
matchre BUFF_CHARGE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre BUFF_INVOKE ^The (.*) resists, only|^You are able to channel|absorbs all of the energy\.$
matchre MANA_WAIT ^You strain\, but lack the mental stamina
matchwait 

BUFF_INVOKE:
gosub CHECKSTANCE
pause 0.5
put invoke my %CAMBRINTH
matchre BUFF_INVOKE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre BUFF_WAIT ^The (.*) pulses|^Your link to (.*) is intact\. 
matchwait 

MANA_WAIT:
gosub CHECKSTANCE
pause 0.5
if $monstercount >= 1 then put bob
pause 5
if $mana >= 35 then goto BUFF_CHARGE
goto MANA_WAIT

BUFF_WAIT:
gosub CHECKSTANCE
pause 0.5
if $monstercount >= 1 then put bob
pause 5
if %SPELLREADY = 1 then goto CAST
goto BUFF_WAIT

STARCHECK:
pause 0.1
put time
matchre STARCHECK ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN since the Victory of Lanival the Redeemer\.$
matchwait


RELEASE_BUFFS:
var BUFFS_RELEASED 0

RELEASE_BUFFS_LOOP:
if %BUFFS_RELEASED = %BUFFS then return
eval BUFFSPELL_SHORT element("%BUFF_SHORT","%BUFFS_RELEASED")
eval BUFFSPELL_ABBREV element("%BUFF_ABBREV","%BUFFS_RELEASED")
eval BUFFSPELL_RELEASE element("%BUFF_RELEASE","%BUFFS_RELEASED")
math BUFFS_RELEASED add 1
if %BUFFSPELL_RELEASE = 1 then 
	{
	if $SpellTimer.%BUFFSPELL_SHORT.active = 1 then goto DO_RELEASE_BUFFS
	}
goto RELEASE_BUFFS_LOOP

DO_RELEASE_BUFFS:
pause 0.1
put release %BUFFSPELL_ABBREV
matchre DO_RELEASE_BUFFS ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RELEASE_BUFFS_LOOP ^%BUFF_RELEASE_MESSAGING
matchwait


#### #### #### ### ### ### ## ## ## - TARGETED, DEBILITATION MAGIC - ## ## ## ### ### ### #### #### ####



MAGIC_PREP:
if matchre ("%GUILD", "Thief|Barbarian") then return
if $preparedspell != None then return
if %DEBILITATION = OFF then
    {
    if %TARGETEDMAGIC = OFF then return
    }
if !matchre ("%DO_SPELL_TYPE","TM") then
	{
	if !matchre ("%TM_SPELLS","0") then goto MAGIC_PREP_TM
	}
    
MAGIC_PREP_DEBIL:
var SPELLREADY 0
if %DEBIL_SPELLS = 0 then goto MAGIC_PREP_TM
if %DEBIL_CYCLE >= %DEBIL_CYCLE_MAX then var DEBIL_CYCLE 0 
eval DO_SPELL element("%DEBIL_FULL","%DEBIL_CYCLE")
eval DO_SPELL_MANA element("%DEBIL_MANA","%DEBIL_CYCLE")
eval DO_SPELL_CAST element ("%DEBIL_CAST","%DEBIL_CYCLE")
math DEBIL_CYCLE add 1
var DO_SPELL_TYPE DEBIL
goto MAGIC_PREP_REAL    
    
MAGIC_PREP_TM:    
if %TM_SPELLS = 0 then return
var TMREADY 0
var SPELLREADY 0
if %TM_CYCLE >= %TM_CYCLE_MAX then var TM_CYCLE 0 
eval DO_SPELL element("%TM_SHORT","%TM_CYCLE")
eval DO_SPELL_MANA element("%TM_MANA","%TM_CYCLE")
eval DO_SPELL_CAST element ("%TM_CAST","%TM_CYCLE")
math TM_CYCLE add 1
var DO_SPELL_TYPE TM
    
MAGIC_PREP_REAL:
if matchre ("%DO_SPELL","%MOONSPELLS") then
	{
	var MOONS 0
	if matchre ("$moonKatamba|$moonYavash|$moonXibar","Up") then var MOONS 1
	if %MOONS = 0 then return
	}
var SPELLREADY 0
pause 0.5
if %DO_SPELL_TYPE = DEBIL then put prep %DO_SPELL %DO_SPELL_MANA
if %DO_SPELL_TYPE = TM then put target %DO_SPELL %DO_SPELL_MANA
matchre MAGIC_PREP_REAL ^\.\.\.wait|^You are still stunned|^Sorry\,|^\[Enter your command again
matchre RETURN %SPELLPREP|^You begin to weave mana lines into a target pattern|^You are already preparing|^But you\'re already preparing
matchre CAST ^You have already fully prepared 
matchwait

RE_TARGET:
pause 0.5
put target
matchre RE_TARGET ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^Your target pattern is already around|^You begin to weave mana lines into a target pattern|^This spell cannot be targeted\.|^There is nothing else to face\!
matchwait

MAGIC_CAST:
if matchre ("%GUILD", "Thief|Barbarian") then return
gosub MAGIC_PREP
if $preparedspell = None then return
if matchre ("$preparedspell", "%TM_FULL") then
    {
    if %TMREADY = 0 then return
    if %TMREADY = 1 then goto CAST
    }
if %SPELLREADY = 0 then return

CAST:
if %DO_SPELL_CAST = 0 then var DO_SPELL_CAST 
pause 0.5
if matchre ("%DO_SPELL_CAST","moon") then
	{
	if $moonKatamba = Up then var DO_SPELL_CAST Katamba
	if $moonYavash = Up then var DO_SPELL_CAST Yavash
	if $moonXibar = Up then var DO_SPELL_CAST Xibar
	if %DO_SPELL_CAST = moon then goto RELEASE
	}
put cast %DO_SPELL_CAST
matchre CAST ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre MAGIC_PREP ^Maintaining two cyclic spells at once|^Your concentration slips for|backfire|backfires|^Currently lacking the skill to complete the pattern
matchre RETURN ^Roundtime\:|^You gesture\.|^You place your hands on your temples.|^You release an accompaniment of elemental aether|^You don't have a spell
matchre RE_TARGET ^Your target pattern dissipates because ((.*) dead|you lose sight of)
matchre RE_TARGET ^You are not engaged to anything\, so you must specify a target to focus on\!$
matchre RE_TARGET ^You can\'t cast that at yourself\!$
matchwait

RELEASE:
pause 0.5
var TMREADY 0
var SPELLREADY 0
put release spell
matchre RELEASE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^You aren't preparing a spell\.|^You let your concentration lapse and feel the spell's energies dissipate\.
matchwait 



#### #### #### ### ### ### ## ## ## - FORMS/BERSERKS - ## ## ## ### ### ### #### #### ####



FORMCHECK:

BERSERKCHECK:
if %BERSERK = 0 then return
if %BERSERK = famine then 
    {
    if $vitality >= 85 then return
    }
if %BERSERK = avalanche then 
    {
    if $stamina >= 85 then return
    }

DO_BERSERK:
if %BERSERKED = 1 then return
pause 0.5
put berserk %BERSERK
matchre DO_BERSERK ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre BERSERKED ^The momentus rage of the avalanche replenishes your energy\!$|^But you are already enraged with that berserk\.$
matchwait

BERSERKED:
var BERSERKED 1
return



#### #### #### ### ### ### ## ## ## - KHRI - ## ## ## ### ### ### #### #### ####



KHRICHECK:
if %FIGHT_TYPE = THROWN then var KHRI_TYPE RANGED
if %FIGHT_TYPE = RANGED then var KHRI_TYPE RANGED
if %FIGHT_TYPE = TACTICAL then var KHRI_TYPE TACTICAL
if %FIGHT_TYPE = STEALTH then var KHRI_TYPE STEALTH

if %KHRICHANGE = 1 then gosub KHRI_DISABLE
var KHRICHANGE 0

var KHRI_ON 0

KHRI_LOOP:
if %KHRI_ON >= %%KHRI_TYPE_KHRI_MAX then return
eval USEKHRI element("%%KHRI_TYPE_KHRI","%KHRI_ON")
gosub IS_KHRI_ACTIVE
math KHRI_ON add 1
goto KHRI_LOOP

IS_KHRI_ACTIVE:
gosub CHECKSTANCE
if "$SpellTimer.Khri%USEKHRI.active" = "1" then return

KHRISTART:
if $concentration <= 10 then gosub CONCENTRATE
pause 0.5
put khri %USEKHRI
matchre KHRISTART ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre KNEEL \[Sitting\, kneeling\, or lying down can make starting this khri easier\.\]
matchre RETURN ^You calm your body|^Remembering the mantra|^With deep breaths|^Taking a deep|^Focusing your mind
matchre RETURN ^Purging yourself of all|^Knowing that a dose|^You carefully relax your mind|^With mental effort
matchre RETURN ^Letting your thoughts|^Centering your mind|^Willing your body|^Preparing your voice
matchre RETURN ^You have not recovered from your previous use|^Your body is willing, but|^You're already using
matchwait 

KHRI_DISABLE:
var KHRI_CYCLE 0

KHRI_DISABLE_LOOP:
eval USEKHRI element("%ALLKHRI","%KHRI_CYCLE")
if %USEKHRI = 0 then return
if matchre ("%USEKHRI", "%%KHRI_TYPE_KHRI") then
    {
    math KHRI_CYCLE add 1
    goto KHRI_DISABLE_LOOP
    }
if "$SpellTimer.Khri%USEKHRI.active" = "1" then gosub KHRISTOP
math KHRI_CYCLE add 1
goto KHRI_DISABLE_LOOP

KHRISTOP:
pause 0.5
put khri stop %USEKHRI
matchre KHRISTOP ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^You attempt to relax your mind from some of its meditative states\.$
matchwait

KNEEL:
pause 0.5
put kneel
matchre KNEEL ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre KHRISTART You kneel|(You are already kneeling.)
matchwait

CONCENTRATE:
gosub CHECKSTANCE
pause 5
if $concentration <= 15 then goto CONCENTRATE
return



#### #### #### ### ### ### ## ## ## - WIELD - ## ## ## ### ### ### #### #### ####



WIELD:
if %WEAPON = Brawling then return
var SHEATHE sheathe
var CONTAINER
var WIELD wield right
goto DO_WIELD

WIELD_EDDY:
var SHEATHE put
var CONTAINER in my portal
var WIELD get
goto DO_WIELD

REMOVE:
var SHEATHE wear
var WIELD remove

DO_WIELD:
pause 0.5
matchre DO_WIELD ^\.\.\.wait|^You are still stunned|^Sorry\,|^You are too exhausted to be able to pick that up\!
matchre SWAP_CHECK ^You draw|^You get|^You're already holding|^You remove|^You sling|^You deftly remove|^You aren't wearing that\.
matchre PICKUP_CERTAIN ^You find it difficult to wield (.*) as it is lying at your feet\!$|^You can't seem to find (.*) in your inventory\!
matchre REMOVE ^You'll need to remove it first\!$
matchre WIELD_EDDY ^Wield what\?
matchre SHEATHE_WHOOPS ^You need to have your right hand free to draw your
put %WIELD my %WEAPON %CONTAINER
matchwait 

SWAP_CHECK:
if %SWAPPABLES = 0 then return
if !matchre ("%TRAINING","%SWAPPABLES") then return

DO_SWAP:
pause 0.5
put swap my %WEAPON
matchre DO_SWAP ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre SWAP_DONE as a (.*) weapon\.$
matchwait 

SWAP_DONE:
pause 0.1
if matchre ("%SWAP_TYPE", "medium edged|light edged") then var SWAP_TYPE Small_Edged
if matchre ("%SWAP_TYPE", "heavy edged") then var SWAP_TYPE Large_Edged
if matchre ("%SWAP_TYPE", "two-handed edged") then var SWAP_TYPE Twohanded_Edged
if matchre ("%SWAP_TYPE", "medium blunt|light blunt") then var SWAP_TYPE Small_Blunt Small_Blunt
if matchre ("%SWAP_TYPE", "heavy blunt") then var SWAP_TYPE Large_Blunt
if matchre ("%SWAP_TYPE", "two-handed blunt") then var SWAP_TYPE Twohanded_Blunt
if matchre ("%SWAP_TYPE", "pike|halberd") then var SWAP_TYPE Polearms
if matchre ("%SWAP_TYPE", "short staff|quarter staff") then var SWAP_TYPE Staves
pause 0.1
if !matchre ("%SWAP_TYPE", "%TRAINING") then goto DO_SWAP
return

SHEATHE_STOW_WHOOPS:
var SHEATHE stow

SHEATHE_WHOOPS:
pause 0.5
put %SHEATHE my $righthand %CONTAINER
matchre SHEATHE_WHOOPS ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre WEAR ^Sheathe your .* where\?
matchre WIELD ^You sheathe|^You sling|^You attach|^You hang|^You put|^Sheathing|^You easily strap
matchre SHEATHE_STOW_WHOOPS ^You can't wear that\!
matchwait

SHEATHE_STOW:
var SHEATHE stow
goto SHEATHE

WEAR:
var SHEATHE wear
var WIELD remove

SHEATHE:
if %WEAPON = Brawling then return
pause 0.5
put %SHEATHE my %WEAPON %CONTAINER
matchre SHEATHE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^You sheathe|^You sling|^You attach|^You hang|^You put|^Sheathing|^You easily strap
matchre PICKUP_SHEATHE ^You need to be holding|^Shouldn\'t you be holding|^Sheathe what\?$
matchre WEAR ^Sheathe your .* where\?
matchre SHEATH_STOW_WHOOPS ^You can't wear that\!
matchwait

SHEATHE_LOOT:
gosub SHEATHE
gosub LOOT
goto ASSESS

SHEATHE_LOOK:
gosub SHEATHE
gosub LOOK
goto ASSESS

PICKUP_SHEATHE:
gosub PICKUP 
goto SHEATHE

PICKUP_WAIT:
pause 5
gosub CHECKSTANCE
pause 5

PICKUP:
gosub CHECKSTANCE
gosub PICKUP_CHECK
pause 0.1
if %PICKUP = 0 then return

PICKUP_CERTAIN:
pause 0.5
put get my %WEAPON
matchre PICKUP_CERTAIN ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^You pick up|^You are already holding that\.$
matchre PICKUP_WAIT ^You are too exhausted to be able to pick that up\!$
matchwait 

PICKUP_CHECK:
var PICKUP 0
pause 0.5
put inv atfeet
matchre PICKUP_CHECK ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^You aren\'t|^All of your items
matchwait 



#### #### #### ### ### ### ## ## ## - SWAPPING - ## ## ## ### ### ### #### #### ####



SWAP_LEFT:
if $lefthand != Empty then return
if %WEAPON = Brawling then goto RETURN
put swap
matchre SWAP_LEFT ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN to your left hand\.$
matchwait

SWAP_RIGHT:
if $righthand != Empty then return
if %WEAPON = Brawling then return
put swap
matchre SWAP_RIGHT ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN to your right hand\.$
matchwait


#### #### #### ### ### ### ## ## ## - EMPATH DANCING - ## ## ## ### ### ### #### #### ####

DANCING:
var DEFENSES 0
var LOCKED_DEFENSES 0

DANCING_NEXT: 
eval TRAINING element("%ARMORS","%DEFENSES")
if $%TRAINING.LearningRate >= 34 then math LOCKED_DEFENSES add 1
if %LOCKED_DEFENSES = %ARMOR_MAX_DEPTH then goto END
math DEFENSES add 1
if %DEFENSES < %ARMOR_MAX_DEPTH then goto DANCING_NEXT

gosub CHECKTIMERS
gosub BUFFCHECK
gosub MAGIC_CAST
gosub LOOK
if %APPRESET = 1 then gosub APPRAISE
gosub BOB_DANCE
var VH_MANA 0
var VH_SPELL Vitality Heal
if $health <= 90 then var VH_MANA 15
if $health <= 80 then var VH_MANA 20
if $health <= 70 then var VH_MANA 25
if $health <= 60 then var VH_MANA 30
if $health <= 50 then var VH_MANA 40
if $health <= 40 then 
	{
	var VH_MANA 5
	var VH_SPELL Innocence
	}
if %VH_MANA = 0 then goto DANCING
if %GUILD != Empath then goto DANCING
gosub RELEASE

VITALITY:
pause 0.2
put prep VH %VH_MANA
matchre VITALITY ^\.\.\.wait|^You are still stunned|^Sorry\,|^\[Enter your command again
matchre VITALITY_BOB %SPELLPREP|^You are already preparing|^But you\'re already preparing
matchwait

VITALITY_BOB:
if %MANA = 5 then 
	{
	pause 2
	gosub CAST
	goto GETOUT_END
	}
if %MANA = 15 then var BOB 1
if %MANA = 20 then var BOB 2
if %MANA = 25 then var BOB 2
if %MANA = 30 then var BOB 3
if %MANA = 40 then var BOB 4

BOB_LOOP:
gosub BOB_DANCE
math BOB subtract 1
if %BOB = 0 then gosub CAST
if matchre ("$preparedspell", "none") then goto DANCING
goto BOB_LOOP

BOB_DANCE:
gosub CHECKSTANCE
pause 0.5
put bob
matchre BOB_DANCE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^Roundtime\:
matchwait 

EMPATH_STANCE:
gosub CHECKSTANCE
pause 0.5
put stance set %EMPATH_STANCE
matchre EMPATH_STANCE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^Setting your Evasion stance
matchwait 


#### #### #### ### ### ### ## ## ## - NORMAL FIGHTING : TACTICS, OFFHAND - ## ## ## ### ### ### #### #### ####



ADVANCE: 
gosub CHECKSTANCE
pause 0.5
put advance %MONSTERSHORT
matchre ADVANCE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre ADVANCE_2 ^What do you want to advance towards\?$
matchre ANALYZE_START ^You close to melee weapon range|^You are already at melee
matchwait 5

ADVANCE_2:
gosub CHECKSTANCE
pause 0.5
put advance
matchre ADVANCE_2 ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre ASSESS ^What do you want to advance towards\?$
matchre ANALYZE_START ^You close to melee weapon range|^You are already at melee
matchwait 5

TACTICAL:
ANALYZE_START:
if %OFFHAND = ON then gosub SWAP_RIGHT
if $%TRAINING.LearningRate >= 34 then goto TRAINING_DONE
gosub CHECKTIMERS
gosub BUFFCHECK
gosub MAGIC_CAST
gosub LOOK

ANALYZE:
if $stamina <= 50 then goto PLAIN_ATTACK
gosub CHECKSTANCE
pause 0.5
if %GUILD = Barbarian then
    {
    gosub MANEUVER
    if $Expertise.LearningRate >= 30 then put analyze %ANALYZE
    if $Expertise.LearningRate <= 29 then put analyze
    }
if %GUILD != Barbarian then put analyze
match ADVANCE You must be closer to use tactical abilities
matchre ANALYZE \.\.\.wait|^You are still stunned|^Sorry\,|You fail to find any holes
matchre SHEATHE_LOOK (^There is nothing|^At what are you|^It's best you not do that to|^Wouldn't it be better if you used|^I could not find what you were|close enough|^Analyze what?|^What are you trying to attack?)
match COMBO Roundtime:
matchwait

PLAIN_ATTACK:
gosub CHECKTIMERS
if $%TRAINING.LearningRate >= 34 then goto TRAINING_DONE
gosub BUFFCHECK
gosub MAGIC_CAST
gosub LOOK
if %APPRESET = 1 then gosub APPRAISE
if %GUILD = Barbarian then gosub MANEUVER
if $stamina >= 75 then goto TACTICAL
gosub CHECKSTANCE
pause 0.5
if {"%OFFHAND" = "OFF" OR "%WEAPON" = "Brawling"} then put attack
if {"%OFFHAND" = "ON" AND "%WEAPON" != "Brawling"} then put attack left
matchre PLAIN_ATTACK ^\.\.\.wait|^You are still stunned|^Sorry\,|^You can not slam
matchre FACE ^Wouldn't it be better if you used
matchre ADVANCE ^You aren\'t close enough to attack\.$
matchre SHEATHE_LOOT ^You turn to face|^There is nothing else to face\!$|(balance|balanced)\]$
matchre BOB ^The (\w+) (lands|flares|flashes)|^Roundtime\:
matchwait 1
goto PLAIN_ATTACK

BOB:
gosub CHECKSTANCE
pause 0.5
put bob
matchre BOB ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre ANALYZE_START ^Roundtime\:
matchwait 

COMBO:
var TACTICBAD OFF
if %OFFHAND = ON then gosub SWAP_LEFT

COMBO1:
gosub CHECKSTANCE
if %APPRESET = 1 then gosub APPRAISE
gosub MAGIC_CAST
gosub LOOK
if %TACTICBAD = ON then goto ANALYZE_START
pause 0.5
if {"%OFFHAND" = "OFF" OR "%WEAPON" = "Brawling"} then put %TACTIC1
if {"%OFFHAND" = "ON" AND "%WEAPON" != "Brawling"} then put %TACTIC1 left
matchre COMBO1 ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre SHEATHE_LOOT ^You turn to face|^There is nothing else to face\!$|(balance|balanced)\]$
matchre FACE ^Wouldn't it be better if you used
matchre COMBO2 ^The (\w+) (lands|flares|flashes)
matchwait 2
goto COMBO1

COMBO2:
gosub CHECKSTANCE
gosub MAGIC_CAST
gosub LOOK
if %TACTICBAD = ON then goto ANALYZE_START
if %TACTICDEPTH = 1 then goto ANALYZE_START
pause 0.5
if {"%OFFHAND" = "OFF" OR "%WEAPON" = "Brawling"} then put %TACTIC2
if {"%OFFHAND" = "ON" AND "%WEAPON" != "Brawling"} then put %TACTIC2 left
matchre COMBO2 ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre SHEATHE_LOOT ^You turn to face|^There is nothing else to face\!$|(balance|balanced)\]$
matchre FACE ^Wouldn't it be better if you used
matchre COMBO3 ^The (\w+) (lands|flares|flashes)
matchre ANALYZE_START ^Please rephrase that command\.$
matchwait 2
goto COMBO2

COMBO3:
gosub CHECKSTANCE
gosub MAGIC_CAST
gosub LOOK
if %TACTICBAD = ON then goto ANALYZE_START
if %TACTICDEPTH = 2 then goto ANALYZE_START
pause 0.5
if {"%OFFHAND" = "OFF" OR "%WEAPON" = "Brawling"} then put %TACTIC3
if {"%OFFHAND" = "ON" AND "%WEAPON" != "Brawling"} then put %TACTIC3 left
matchre COMBO3 ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre SHEATHE_LOOT ^You turn to face|^There is nothing else to face\!$|(balance|balanced)\]$
matchre FACE ^Wouldn't it be better if you used
matchre COMBO4 ^The (\w+) (lands|flares|flashes)
matchre ANALYZE_START ^Please rephrase that command\.$
matchwait 2
goto COMBO3

COMBO4:
gosub CHECKSTANCE
gosub MAGIC_CAST
gosub LOOK
if %TACTICBAD = ON then goto ANALYZE_START
if %TACTICDEPTH = 3 then goto ANALYZE_START
pause 0.5
if {"%OFFHAND" = "OFF" OR "%WEAPON" = "Brawling"} then put %TACTIC4
if {"%OFFHAND" = "ON" AND "%WEAPON" != "Brawling"} then put %TACTIC4 left
matchre COMBO4 ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre SHEATHE_LOOT ^You turn to face|^There is nothing else to face\!$|(balance|balanced)\]$
matchre FACE ^Wouldn't it be better if you used
matchre ANALYZE_START ^The (\w+) (lands|flares|flashes)|^Please rephrase that command\.$
matchwait 2
goto COMBO4



#### #### #### ### ### ### ## ## ## - MANUEVERS - ## ## ## ### ### ### #### #### ####



MANEUVER:
if $Expertise.LearningRate >= 34 then return
if $Timers.MANEUVER.Elapsed <= 30 then return
if matchre ("%TRAINING", "Brawling") then var MANEUVER palmstrike
if matchre ("%TRAINING", "Small_Edged|Large_Edged|Twohanded_Edged") then var MANEUVER cleave
if matchre ("%TRAINING", "Polearms") then var MANEUVER impale
if matchre ("%TRAINING", "Staves") then var MANEUVER twirl
if matchre ("%TRAINING", "Small_Blunt|Large_Blunt|Twohanded_Blunt") then var MANEUVER crash
if matchre ("%TRAINING", "Bow|Crossbow|Slings") then var MANEUVER powershot

DO_MANEUVER:
#gosub CHECKSTANCE
pause 0.5
put maneuver %MANEUVER
matchre DO_MANEUVER ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre MANEUVER_WAIT ^You take a step back|^Taking a full step back|^You lower your shoulders and|^You square up your feet|^You brace your shoulder against
matchre MANEUVER_FAIL ^With your fist\?|^You must rest a bit longer before|^This works best when|^You prepare the shot, but stop|^Your hands must be empty
matchwait

MANEUVER_WAIT:
waitforre ^Roundtime\:|^With a loud twang, you let fly|^There is nothing else to face\!

MANEUVER_SUCCESS:
MANEUVER_FAIL:
put /timers start MANEUVER
goto CHECKSTANCE






#### #### #### ### ### ### ## ## ## - HIDING - ## ## ## ### ### ### #### #### ####



HIDE:
if matchre ("%COMMANDS","stealthoff") then return

if $Stealth.LearningRate >= 34 then var STEALTH OFF
if %GUILD = Thief then
    {
    if %BACKSTAB = ON then var STEALTH ON
    }
if %STEALTH = OFF then return
if $hidden = 1 then return

DO_HIDE:
gosub CHECKSTANCE
pause 0.5
put hide
matchre HIDE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^You melt|^You blend|already hidden\!$
matchre STEALTH_OFF ^You can't hide in all this armor\!
matchwait 3
return

STEALTH_OFF:
var STEALTH OFF
var STEALTH_OVERRIDE OFF
return

#### #### #### ### ### ### ## ## ## - STEALTH ATTACK - ## ## ## ### ### ### #### #### ####



STEALTH_ADVANCE: 
gosub CHECKSTANCE
pause 0.5
put advance %MONSTERSHORT
matchre STEALTH_ADVANCE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre STEALTH_ADVANCE_2 ^What do you want to advance towards\?$
matchre STEALTH ^You close to melee weapon range|^You are already at melee
matchwait 5

STEALTH_ADVANCE_2:
gosub CHECKSTANCE
pause 0.5
put advance
matchre STEALTH_ADVANCE_2 ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre ASSESS ^What do you want to advance towards\?$
matchre STEALTH ^You close to melee weapon range|^You are already at melee
matchwait 5

STEALTH:
if $hidden = 1 then goto STEALTH_ATTACK_HIDDEN
var SPECIAL_CYCLE 1
if %GUILD = Thief then var SPECIAL_CYCLE 0

STEALTH_ATTACK:
if $%TRAINING.LearningRate >= 34 then goto TRAINING_DONE
var SPECIAL attack
if %GUILD = Thief then
    {
    var SPECIAL blindside
    if $Backstab.LearningRate >= 34 then var SPECIAL attack
    if %SPECIAL_CYCLE = 0 then 
        {
        if %AMBUSH != 0 then 
            {
            var SPECIAL %AMBUSH
            gosub SWAP_RIGHT    
            }
	if %AMBUSH = 0 then var SPECIAL_CYCLE 1
        }
    }
if %SPECIAL_CYCLE != 0 then
    {
    if %OFFHAND = ON then gosub SWAP_LEFT
    }
gosub CHECKSTANCE
gosub CHECKTIMERS
gosub BUFFCHECK
if %APPRESET = 1 then gosub APPRAISE
gosub MAGIC_CAST
gosub LOOK
gosub HIDE

STEALTH_ATTACK_HIDDEN:
pause 0.5
if {"%OFFHAND" = "ON" AND "%SPECIAL_CYCLE" != "0"} then
    {
    if $hidden = 0 then put attack left
    if $hidden = 1 then put %SPECIAL left
    }
if {"%OFFHAND" = "OFF" OR "%SPECIAL_CYCLE" = "0"} then
    {
    if $hidden = 0 then put attack 
    if $hidden = 1 then put %SPECIAL
    }
matchre STEALTH_ATTACK_HIDDEN ^\.\.\.wait|^You are still stunned|^Sorry\,|^You can not slam
matchre SHEATHE_LOOT (balance|balanced)\]$|^There is nothing else to face\!$
matchre STEALTH_ADVANCE ^It would help if you were closer|^You aren't close enough to attack\.$|^What are you trying to attack\?
matchre STEALTH_CYCLE_UP ^Roundtime\:|^\[Roundtime|^You don't think you have enough focus to do that\.$
matchwait 

STEALTH_CYCLE_UP:
math SPECIAL_CYCLE add 1
if %GUILD = Barbarian then gosub MANEUVER
goto STEALTH_ATTACK



#### #### #### ### ### ### ## ## ## - THROWING - ## ## ## ### ### ### #### #### ####



THROWN:
if matchre ("%TRAINING", "Light") then
    {
    if OFFHAND = ON then gosub SWAP_LEFT
    }

LOB:
if $%TRAINING.LearningRate >= 34 then goto TRAINING_DONE
gosub CHECKSTANCE
gosub CHECKTIMERS
gosub BUFFCHECK
if %APPRESET = 1 then gosub APPRAISE
gosub MAGIC_CAST
gosub LOOK
pause 0.5
if matchre ("$righthand", "%WEAPON") then put lob
if matchre ("$lefthand", "%WEAPON") then put lob left
matchre LOB ^\.\.\.wait|^You are still stunned|^Sorry\,|^What are you trying to attack\?$
matchre PICKUP_LOOT (balance|balanced)\]$
matchre THROW_PICKUP_CERTAIN ^\[Roundtime
matchre THROW_PICKUP ^What are you trying to lob\?$
matchre SHEATHE_LOOK ^There is nothing else to face\!$
matchwait

THROW_PICKUP_CERTAIN:
if matchre ("$righthand|$lefthand", "%WEAPON") then goto LOB
gosub PICKUP_CERTAIN
goto LOB

THROW_PICKUP:
gosub PICKUP
goto LOB

PICKUP_LOOT:
gosub PICKUP_SHEATHE
gosub LOOT
goto ASSESS



#### #### #### ### ### ### ## ## ## - RANGED - ## ## ## ### ### ### #### #### ####



RANGED:
var AMMO %%TRAINING_Ammo
pause 0.5
put stance set 80 0 100 100
matchre RANGED ^\.\.\.wait|^You are still stunned|^Sorry\,
match RANGED_LOAD Setting your Evasion stance
matchwait 

RANGED_LOAD:
gosub CHECKTIMERS
gosub BUFFCHECK
gosub CHECKSTANCE
if %APPRESET = 1 then gosub APPRAISE
gosub MAGIC_CAST
gosub LOOK
if $%TRAINING.LearningRate >= 34 then
    {
    gosub RANGED_STOP
    goto TRAINING_DONE
    }
pause 0.5
if {"%DUAL_LOAD" = "1" AND "%WEAPON" = "Bow"} then put load my %WEAPON with my %AMMOs
if "%DUAL_LOAD" = "0" then put load my %WEAPON with my %AMMO
matchre RANGED_LOAD ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RANGED_AIM ^Roundtime|is already loaded
matchre AMMO_COLLECT ^You don\'t have the proper ammunition
matchwait 2
goto RANGED_LOAD

RANGED_AIM:
gosub CHECKSTANCE
if %GUILD = Barbarian then 
    {
    gosub MANEUVER
    goto AMMO_COLLECT
    }
var AIM 0
pause 0.5
put aim
matchre RANGED_AIM ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RANGED_LOAD isn't loaded\!$
matchre RANGED_BOB ^You begin to target|^You are already targetting
matchre RANGED_STOP ^There is nothing else to face!|^I could not find what you were referring to.
matchwait

RANGED_BOB:
if %AIM = 1 then goto RANGED_FIRE
gosub CHECKSTANCE
gosub MAGIC_CAST
pause 1
if %AIM = 1 then goto RANGED_FIRE
put bob
matchre RANGED_BOB ^\.\.\.wait|^You are still stunned|^Sorry\,|^You bob
matchwait

RANGED_FIRE:
gosub CHECKSTANCE
pause 0.5
put fire 
matchre RANGED_AIM ^I could not find what you were referring to\.$
matchre RANGED_FIRE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RANGED_END ^There is nothing else to face\!$
matchre AMMO_COLLECT hits a wall|(arrow|bolt|dart|pulzone) falls|lands nearby\!
matchre RANGED_LOAD ^\[Roundtime
matchwait

AMMO_COLLECT:
gosub CHECKSTANCE
pause 0.5
put stow %AMMO
matchre AMMO_COLLECT ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre AMMO_COLLECT ^You put your
matchre RANGED_LOAD ^Stow what\?
matchwait

RANGED_END:
gosub RANGED_STOP
gosub LOOK
goto ASSESS

RANGED_STOP:
gosub CHECKSTANCE
pause 0.5
put unload my %WEAPON
matchre RANGED_STOP ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre AMMO_STOW ^You unload|isn't loaded\!$
matchwait 

AMMO_STOW:
gosub CHECKSTANCE
pause 0.5
put stow %AMMO
matchre AMMO_STOW ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RANGED_STANCE_END ^You put your
matchwait 1

RANGED_STANCE_END:
gosub CHECKSTANCE
pause 0.5
put stance set %STANCE
matchre RANGED_STANCE_END ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre PICKUP_LOOT ^Setting your Evasion stance
matchwait 



#### #### #### ### ### ### ## ## ## - LOOTING, SKINNING - ## ## ## ### ### ### #### #### ####



LOOK:
gosub CHECKSTANCE
if $Timers.LOOT.Elapsed <= 30 then return
pause 0.5
if %MONSTERSHORT = nothing then goto SKIP_THIS_ONE_THING
if matchre ("$roomobjs", "(%MONSTERSHORT (which|that) appears dead|%MONSTERSHORT \(dead\))") then gosub LOOT
SKIP_THIS_ONE_THING:
return

LOOT:
if $Timers.LOOT.Elapsed <= 30 then return
math KILLS add 1
math LOOTSKIN set 0

ARRANGE:
if matchre ("%COMMANDS","noskin") then goto ROOMLOOT_FILL
#if matchre ("$righthand|$lefthand", "%WEAPON") then gosub SHEATHE
if %ARRANGE_ALL = 1 then goto ARRANGEALL
pause 0.5
if $Skinning.LearningRate >= 32 then goto SKIN
put arrange
match SKIN You complete arranging
matchre ARRANGE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre LOOTDEAD ^Arrange what?|you can't arrange it either\.$
matchre LOOT_UNDO ^You move over to (.*) and get ready to search it\!$
matchwait 1
math LOOTSKIN add 1
if %LOOTSKIN < 5 then goto ARRANGE
if %LOOTSKIN = 5 then goto SKIN
goto ARRANGE

LOOT_UNDO:
math KILLS subtract 1
return

ARRANGEALL:
pause 0.5
put arrange all
matchre ARRANGEALL ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre LOOTDEAD ^Arrange what?|you can't arrange it either\.$
matchwait 1

SKIN:
pause 0.5
put skin
match LOOTDEAD Roundtime: 
matchre SKIN ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre LOOT_UNDO ^You move over to (.*) and get ready to search it\!$
matchwait 2

LOOTDEAD:
pause 0.5
put loot
matchre LOOTDEAD ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre LOOT_UNDO ^You move over to (.*) and get ready to search it\!$
matchre ROOMLOOT_FILL ^You search
matchwait 3

ROOMLOOT_FILL:
var APPRESET 1
put /timers start LOOT
if matchre ("%COMMANDS","noskin") then RETURN
pause 2

ROOMLOOT:
pause 0.1
var STOW none
var STONE_GRAB 0
if matchre ("$roomobjs", "%AMMO") then var STOW %AMMO
if matchre ("$roomobjs", "fragment|hhr'lav'geluhh bark|ostracon|package|papyrus roll|scroll|sheiska leaf|smudged parchment|tablet|vellum|\bmap\b") then var STOW $0
if matchre ("$roomobjs", "coin|coins") then var STOW coin
if matchre ("$roomobjs", "\bbox\b|caddy|casket|\bchest\b|coffer|crate|skippet|strongbox|trunk") then var STOW box
if matchre ("$roomobjs", "waermodi (stone|stones)") then goto STONE_WAERMODI
if matchre ("$roomobjs", "kyanite (stone|stones)") then goto STONE_KYANITE
if matchre ("$roomobjs", "jadeite (stone|stones)") then goto STONE_JADEITE
if %STOW = none then goto GEM

STOW:
pause 0.5
put stow %STOW
matchre STOW ^\.\.\.wait|^You are still stunned|^Sorry\,|^You pick up
matchre ROOMLOOT ^Stow what\?|^What were you referring to\?$
matchre LOOTEND ^You just can't get|^There isn\'t any more room
matchwait 2
goto ROOMLOOT

GEM:
pause 0.5
put stow gem
matchre GEM ^\.\.\.wait|^You are still stunned|^Sorry\,|^You pick up
matchre RETURN ^Stow what\?|^What were you referring to\?$
matchre LOOTEND ^You just can't get|^There isn\'t any more room
matchwait 2
return

STONE_WAERMODI:
var STOW waermodi stone
goto STONE_GET

STONE_KYANITE:
var STOW kyanite stone
goto STONE_GET

STONE_JADEITEI:
var STOW jadeite stone
goto STONE_GET

STONE_GET:
pause 0.5
put get %STOW
matchre STONE_GET ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre STONE_STOW ^You pick up
matchre STONE_NAME ^That can\'t be picked up\.$
matchre ROOMLOOT_FILL What were you referring to?
matchwait 5
put #echo >Log red ERROR STOWING GWETH STONES!
put #flash

STONE_STOW:
pause 0.5
put put my %STOW in my %STONEPACK
matchre STONE_STOW ^\.\.\.wait|^You are still stunned|^Sorry\,|^You pick up
matchre STOW ^What were you
matchre ROOMLOOT ^You put
matchre LOOTEND ^You just can't get|^There isn\'t any more room
matchwait



#### #### #### ### ### ### ## ## ## - END - ## ## ## ### ### ### #### #### ####



LOOTEND:
if %BUFFS > 0 then gosub RELEASE_BUFFS
put #echo
put #echo 
put #echo
put #echo yellow * * * OOPS! TOO MUCH LOOT! * * *
put #echo
put #echo
put #echo yellow * * * PICK UP YOUR MESS! * * *
put #echo
put #echo
put #echo
put #flash
exit

GETOUT_END:
put #echo
put #echo 
put #echo
put #echo red * * * YOU'RE GETTING TOO HURT! LEAVE NOW! * * *
put #echo
put #echo
put #echo
put #flash
put .healthcheck
# this script is one you can make on your own:
# CHECK:
# pause 
# if $stunned = 1 then put quit
# if $health <= 40 then put quit
# goto CHECK
# ^ may be against rules if you're PVP Open and were stunned by another player.
# Otherwise, at this point in the script, you should have Innocence up, and therefore be done hunting, so I don't see how its a problem.
goto END_COMMANDS

END:
if %BUFFS > 0 then gosub RELEASE_BUFFS
put #echo
put #echo
put #echo
put #echo lime * * * ALL DONE HERE! * * *
put #echo
put #echo
put #echo
put #flash

END_COMMANDS:
if matchre ("%COMMANDS","quit") then
	{
	put stow box
	pause
	put stow box
	pause
	put stow box
	pause
	put quit
	}
if matchre ("%COMMANDS","home") then
	{
	pause 2
	put .healthcheck
	goto END_HOME
	}
EXIT:
exit

END_HOME:
put .home
matchre EXIT ^SAFE\!
matchwait 60
goto END_HOME
