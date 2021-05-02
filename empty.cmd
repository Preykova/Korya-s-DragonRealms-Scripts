#debug 10

action var LIST $2 when ^In the (.*) you see (.*)$
var VERB put my
var THING in
var TRASH 0
if matchre ("$roomobjs","\bgelapod\b") then var TRASH gelapod
if matchre ("$roomobjs","\bgelapod\b") then var VERB give my
if matchre ("$roomobjs","\bgelapod\b") then var THING to
if matchre ("$roomobjs","\burn\b") then var TRASH urn
if matchre ("$roomobjs","\bbucket\b") then var TRASH bucket
if matchre ("$roomobjs","\bcauldron\b") then var TRASH cauldron
if matchre ("$roomobjs","\bbin\b") then var TRASH bin
if matchre ("$roomobjs","\bbarrel\b") then var TRASH barrel
if_2 then
	{
	if matchre("%2","drop|ground|dump|empty") then
		{
		var VERB drop my
		var THING
		var TRASH
		}
	}
if %TRASH = 0 then
	{
	put #echo
	put #echo red No trash container in here!
	put #echo
	exit
	}
if_1 then goto SEARCH
put #echo
put #echo aqua Use ".empty [container]" to start!
put #echo
exit

SEARCHPAUSE:
pause 

SEARCH:
pause 0.001
put look in my %1
matchre SEARCHPAUSE ^\.\.\.wait|^Sorry|^System|^You are still stunned
matchre DOLIST ^In the (.*) you see
matchwait 

DOLIST:
pause 0.001
eval FIXLIST replacere("%LIST", "\,\s", "|")
pause 0.001
eval TOTAL count("%FIXLIST","|")
math TOTAL add 1
var FINISHED %TOTAL
math FINISHED add 1
var COUNT 0
var COUNT_ECHO 0

LOOP:
if %COUNT = %FINISHED then goto DONE
pause 0.001
eval ITEM element("%FIXLIST","%COUNT")
math COUNT add 1
if matchre ("%ITEM", "\band\b") then 
	{
	if %COUNT = %TOTAL then 
		{
		eval NEXTITEM replacere("%ITEM","\band\b\s(.*)","")
		eval LASTITEM replacere("%ITEM","(.*)\s\band\b\s","")
		var ITEM %NEXTITEM
		}
	}
if %COUNT = %FINISHED then var ITEM %LASTITEM
eval ITEM replacere("%ITEM","(^(a|an|some).*\s)","")

DROP:
pause 0.01
put get my %ITEM from my %1
matchre DROP ^\.\.\.wait|^Sorry|^System|^You are still stunned
matchre TRASH ^You get
matchwait

TRASH:
pause 0.01
put %VERB %ITEM %THING %TRASH
matchre TRASH ^\.\.\.wait|^Sorry|^System|^You are still stunned
matchre LOOP ^You put|^You drop
matchwait 

DONE:
exit
