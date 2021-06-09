# debug 10
#
# can be used with .climb by starting it with any argument: .research climb, .research noodles...
# also uses the .crystal script for training Arcana!
#
# Set BEGIN to 0 to skip auto sorting skills
#
#	GAFMANA = Amount of mana to put into Gauge Flow
#	SPELLPREP = Message of preparing a basic spell
#	CAMBRINTH = noun of worn cambrinth (only worn)
#	CAMBMANA = mana to put into cambrinth--is subtracted from GAFMANA. If GAFMANA is 75, and CAMBMANA is 50, then you will prepare Gauge Flow with 25 mana to start.
#	CRYSTAL = 0 to skip Arcana training, 1 to use the .crystal script
#

var BEGIN 1
var MAGIC Utility|Augmentation|Warding|Attunement|Primary_Magic

action put #var SpellTimer.GaugeFlow.active 0 when ^You require some special means of analyzing the mana streams in order to begin research\.$
action goto START when ^You require some special means of analyzing the mana streams in order to begin research\.$
action goto START when ^Your eyes briefly darken\.  When you regain sight\, the graphs and sigils previously impressed upon your vision have disappeared\.$
action var RESEARCH $3 when ^You have completed (.*) of a project (about|about Mana) (Augmentation|Utility|Warding|Stream|Fundamental)
action var CASTREADY 1 when ^You feel fully prepared to cast your spell\.$

START:
if $charactername = Cleyra then
 	{
	var GAFMANA 99
	var SPELLPREP You raise your head skyward, chanting
	var CAMBRINTH armband
	var CAMBMANA 50
	var CRYSTAL 1
	}
if $charactername = Korya then
 	{
	var GAFMANA 99
	var SPELLPREP With meditative movements you prepare
	var CAMBRINTH chain
	var CAMBMANA 50
	var CRYSTAL 1
	}


if %BEGIN = 0 then goto START_2
gosub AUTO_SORT
var BEGIN 0

START_2:
var CASTREADY 0
if $SpellTimer.GaugeFlow.active = 0 then goto PREPARE_MANA
if $SpellTimer.GaugeFlow.duration <= 6 then goto PREPARE_MANA
if $SpellTimer.GaugeFlow.active = 1 then goto RESEARCH_CHOOSE

PREPARE_MANA:
put #script abort crystal

PREPARE_MANA_WAIT:
if $concentration >= 98 then goto SPELLPREP_SUBTRACT
pause 5
goto PREPARE_MANA_WAIT

SPELLPREP_SUBTRACT:
if_1 then put #script pause all except research
if %CAMBRINTH != no then math GAFMANA subtract %CAMBMANA

SPELLPREP:
pause 0.3
put prep gaf %GAFMANA
matchre CASTPREP %SPELLPREP|^You are already
matchre SPELLPREP ^\.\.\.wait|^Sorry\,|^You are still stunned|your spell is lost\.$
matchwait
 
CASTPREP:
if %CAMBRINTH != 0 then goto CHARGE

CASTWAIT:
pause
if %CASTREADY = 1 then goto CAST
goto CASTWAIT

CHARGE:
pause 0.5
put charge my %CAMBRINTH %CAMBMANA
matchre INVOKE ^The (.*) resists, only|^You are able to channel
matchre CHARGE ^\.\.\.wait|^Sorry\,|^You are still stunned|You strain, but lack
matchwait

INVOKE:
pause 0.5
put invoke my %CAMBRINTH
matchre CASTWAIT ^The (.*) pulses|^Your link to (.*) is intact\.
matchre INVOKE ^\.\.\.wait|^Sorry\,|^You are still stunned
matchwait

CAST:
pause 0.5
put cast
matchre CAST ^\.\.\.wait|^Sorry\,|^You are still stunned
matchre START ^Your concentration slips for a moment\, and your spell is lost\.
matchre START backfire|backfires
matchre RESEARCH_CHOOSE ^You gesture.
matchwait 

RESEARCH_CHOOSE:
# give some time for SpellTimer to update...
pause 2
if $SpellTimer.GaugeFlow.active = 0 then goto START

if $invisible = 1 then goto RESEARCH_CHOOSE_START
if $Arcana.LearningRate <= 17 then
	{
	if %CRYSTAL = 1 then put .crystal
	}

RESEARCH_CHOOSE_START:
var NUMBER 0

RESEARCH_CHOOSE_LOOP:
eval RESEARCH element("%MAGIC","%NUMBER")
if $%RESEARCH.LearningRate <= 10 then goto RESEARCH
math NUMBER add 1
if %NUMBER = 5 then goto WAIT
goto RESEARCH_CHOOSE_LOOP

WAIT:
if_1 then put #script resume all
pause 90
if_1 then put #script pause all except research
goto RESEARCH_CHOOSE

CLIMBWAIT:
pause 2

RESEARCH:
if %RESEARCH = Primary_Magic then var RESEARCH Fundamental
if %RESEARCH = Attunement then var RESEARCH Stream
if_1 then put #script pause all except research
pause 0.5
if $SpellTimer.GaugeFlow.active = 0 then goto START
if $SpellTimer.GaugeFlow.duration <= 2 then goto START
put research %RESEARCH 300
matchre RESEARCHWAIT ^You confidently begin to bend the mana streams|^You focus your magical perception|^You tentatively reach out and begin manipulating|^You are already busy at research!
matchre CHECK ^You cannot begin a new project until your current one is either completed or cancelled.
matchre RESEARCH ^\.\.\.wait|^Sorry\, you|^You are still stunned
matchre CLIMBWAIT ^You should stop practicing your Athletics skill before you do that.
matchre START ^You require some special means of analyzing the mana streams in order to begin research.
matchwait

RESEARCHWAIT:
if_1 then put #script resume all
matchre CHECK ^You make definite progress
matchre RESEARCH_CHOOSE ^Breakthrough!
matchwait

CHECK:
if_1 then put #script pause all except research
pause 0.5
put research status
matchre CHECK ^\.\.\.wait|^Sorry\, you|^You are still stunned
matchre RESEARCH_CHOOSE ^You\'re not researching anything\!$
matchre RESEARCH ^You have completed (.*) of a project (about|about Mana) (Utility|Augmentation|Warding|Fundamental|Stream)
matchwait


AUTO_SORT:
put #gag {^.*}
EXP:
put exp all
matchre EXP ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre UNGAG ^EXP HELP
matchwait 1
UNGAG:
put #ungag {^.*}

var NUMBER 0
eval SKILL_NAME element("%MAGIC","%NUMBER")
var SKILLS %SKILL_NAME
var RANKS $%SKILL_NAME.Ranks

NEWLIST:
math NUMBER add 1
pause 0.0001
if %NUMBER = 5 then goto CONTINUE
eval SKILL_NAME element("%MAGIC","%NUMBER")
var Do_%SKILL_NAME ON
var SKILLS %SKILLS|%SKILL_NAME
var RANKS %RANKS|$%SKILL_NAME.Ranks
goto NEWLIST

CONTINUE:
var MAGIC nothing
var RANK_LIST nothing
var LOOP_COUNTER 5

NEW_LOOP:
var COMPARE 9999

OUTER_LOOP:
var NUMBER 0
var TEMPLIST nothing

INNER_LOOP:
eval SKILL element("%SKILLS","%NUMBER")
eval RANK element("%RANKS","%NUMBER")
if matchre ("%MAGIC","%SKILL") then goto NEXT_RANK

if %RANK < %COMPARE then goto LOWER
# else, its equal or higher

NEXT_RANK:
math NUMBER add 1
if %NUMBER = 5 then goto FOUND_LOWEST
if %NUMBER < 5 then goto INNER_LOOP

LOWER:
var SAVERANK %RANK
var SAVESKILL %SKILL
var COMPARE %RANK
goto OUTER_LOOP

FOUND_LOWEST:
var RANK_LIST %RANK_LIST|%SAVERANK
var MAGIC %MAGIC|%SAVESKILL
math LOOP_COUNTER subtract 1
if %LOOP_COUNTER = 0 then goto END_SORT
goto NEW_LOOP

END_SORT:
eval MAGIC replacere("%MAGIC","nothing\|","")
eval ECHO_LIST replacere("%MAGIC","\|",", ")
eval RANK_LIST replacere("%RANK_LIST","nothing\|","")
eval RANK_LIST replacere("%RANK_LIST","\.\d\d","")
eval RANK_LIST replacere("%RANK_LIST","\|",", ")
put #echo
put #echo aqua Going to train: %ECHO_LIST
put #echo aqua Lowest to Highest: %RANK_LIST
put #echo
return
