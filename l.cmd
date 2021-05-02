action var LIST $1 when ^You rummage .* and see (.*)\.$
 
if matchre ("%1","u|un|und|unde|under") then var VERB under
if matchre ("%1","i|in") then var VERB in
if matchre ("%1","o|on") then var VERB on
if matchre ("%1","b|be|beh|behi|behin|behind") then var VERB behind
var NOUN %2
if_2 then goto SEARCH

ERROR:
put #echo
put #echo
put #echo aqua Usage: .l on, in, behind, under [object]
put #echo
put #echo
exit

SEARCHPAUSE:
pause 

SEARCH:
pause 0.001
put rummage %VERB %NOUN
matchre SEARCHPAUSE ^\.\.\.wait|^Sorry|^System|^You are still stunned
matchre DOLIST ^You rummage .* (in|on|behind|under)
matchre DONE ^You can't rummage
matchwait 5
goto ERROR

DOLIST:
put #clear Rummage
put #window show Rummage
pause 0.001
eval FIXLIST replacere("%LIST", "\,\s", "|")
pause 0.001
eval TOTAL count("%FIXLIST","|")
math TOTAL add 1
var COUNT 0
var COUNT_ECHO 0

LOOP:
pause 0.001
eval ITEM element("%FIXLIST","%COUNT")
math COUNT add 1
if matchre ("%ITEM", "\band\b") then 
	{
	if %COUNT = %TOTAL then goto FIXITEM
	}
put #echo >Rummage %COUNT: %ITEM
if %COUNT = %TOTAL then goto DONE
goto LOOP

DONE:
exit

FIXITEM:
eval NEXTITEM replacere("%ITEM","\band\b\s(.*)","")
eval LASTITEM replacere("%ITEM","(.*)\s\band\b\s","")
put #echo >Rummage %COUNT: %NEXTITEM
math COUNT add 1
put #echo >Rummage %COUNT: %LASTITEM
