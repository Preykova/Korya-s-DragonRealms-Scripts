#debug 10
var GUILD none
if matchre ("$charactername", "Cleyra") then var GUILD moonmage
if matchre ("$charactername", "xxx") then var GUILD thief
if matchre ("$charactername", "xxx") then var GUILD ranger

if "$zonename" = "The Crossing" then goto CROSSING
if "$zonename" = "Crossing Temple" then goto TEMPLE
if "$zonename" = "Sorrow's Reach" then goto REACH
if "$zonename" = "Crossing West Gate" then goto WGATE
if (("$zonename" = "Crossing North Gate and the Brambles") && ("$roomid" = "113")) then goto GROVE
if "$zonename" = "Crossing North Gate and the Brambles" then goto NGATE
if "$zonename" = "Northern Trade Road" then goto NEGATE
if "$zonename" = "Crossing East Gate" then goto EGATE
if "$zonename" = "Leucros, Vipers and Rock Guardians" then goto GUARDIANS
if "$zonename" = "Southern Trade Route Part 2 (Leth to Gondola)" then goto STR2
if "$zonename" = "Leth Deriel" then goto LETH
if "$zonename" = "Dirge" then goto DIRGE
if "$zonename" = "Fang Cove" then goto FANG_COVE
if "$zonename" = "Southern Trade Road Part 1 (Ferry to Leth Deriel)" then goto SILVERCLAW
if "$zonename" = "Riverhaven" then goto RIVERHAVEN
if "$zonename" = "Riverhaven East Gate" then goto RIVERHAVEN_EASTGATE
if "$zonename" = "Faldesu River" then goto SWIM_RIVERHAVEN_S
put #echo
put #echo
put #echo red You can't find the way home from here!
put #echo
put #echo
exit

#
# Enter your room ID and house type here!
#
# The rest of the script would also need to be updated to branch off if your house is in another map.
#

HOME_CLEYRA:
	gosub AUTOMAPPER xxx
	var HOME home
	goto ENTER_HOME

HOME_KORYA:
	gosub AUTOMAPPER xxx
	var HOME residence
	goto ENTER_HOME

FANG_COVE:
	gosub AUTOMAPPER portal
	pause 0.5
	put go portal
	pause

CROSSING:
if matchre ("%1","cl|cle|cley|cleyr|cleyra") then goto HOME_CLEYRA
if matchre ("%1","ko|kor|kory|korya") then goto HOME_KORYA
if matchre ("%1","burgle") then 
	{
	gosub AUTOMAPPER xxx
	pause 0.5
	put #parse BURGLE!
	exit
	}
if $charactername = Cleyra then goto HOME_CLEYRA
if $charactername = Korya then goto HOME_KORYA
put #echo
put #echo
put #echo Defaulting to Korya's home.
put #echo
put #echo
goto HOME_KORYA

TEMPLE:
gosub AUTOMAPPER crossing
pause 0.5
goto CROSSING

GROVE:
move west
pause 

WGATE:
gosub AUTOMAPPER 14
pause 0.5
goto CROSSING

NGATE:
gosub AUTOMAPPER 23
pause 0.5
goto CROSSING

NEGATE:
if $invisible = 1 then goto EGATE_DETOUR

NEGATE_REAL:
gosub AUTOMAPPER 349
pause 0.5
goto CROSSING

EGATE_DETOUR:
gosub AUTOMAPPER e gate
pause 0.5

EGATE:
if matchre ("%1","burgle") then goto EGATE_REAL
if matchre ("%1","ko|kor|kory|korya") then goto EGATE_REAL
if matchre ("%1","cl|cle|cley|cleyr|cleyra") then goto EGATE_REAL
if $charactername = Natipohaka then goto HOME_NATIPOHAKA

EGATE_REAL:
gosub AUTOMAPPER crossing
pause 0.5
goto CROSSING

RIVERHAVEN:
gosub AUTOMAPPER e gate
pause 0.5

RIVERHAVEN_EASTGATE:
put dive river
pause

SWIM_RIVERHAVEN_S:
gosub AUTOMAPPER 21
pause 0.5
goto NEGATE

GUARDIANS:
gosub AUTOMAPPER 2
pause 0.5
goto NEGATE

REACH:
gosub AUTOMAPPER 9
pause 0.5
goto NEGATE

DIRGE:
gosub AUTOMAPPER 71
pause 0.5
goto NEGATE

STR2: 
gosub AUTOMAPPER 100
pause 0.5

LETHSHORTCUT:
gosub AUTOMAPPER 3
pause 0.5

LETH2:
gosub AUTOMAPPER 115
pause 0.5
goto SILVERCLAW

LETH:
if matchre ("$roomid","179|128|129") then goto LETHSHORTCUT
goto LETH2

SILVERCLAW:
if_1 then
	{
	if %GUILD = thief then
		{
		gosub AUTOMAPPER 107
		pause 0.5
		gosub AUTOMAPPER 6
		pause 0.5
		goto CROSSING
		}
	put #goto ferry
	waitforre ^YOU HAVE ARRIVED
	put .ferry
	waitforre ^INCROSSINGNOW
	pause 0.5
	goto CROSSING
	}
put #echo
put #echo
put #echo Defaulting to Silverclaw Hub, Sleeping Hut
put #echo
put #echo
gosub AUTOMAPPER 142
exit

AUTOMAPPER:
if matchre ("$1 $2","$roomid") then return
put #goto $1 $2
matchre RETURN ^YOU HAVE ARRIVED
matchwait 60
goto AUTOMAPPER

RETURN:
return

ENTER_HOME:
put #parse SAFE!
if $invisible = 1 then
	{
	if %GUILD = thief then
		{
		put khri stop vanish silence
		pause 0.3
		}
	if %GUILD = moonmage then
		{
		put release rf
		pause 0.3
		put release sov
		pause 0.3
 		}
	if %GUILD = ranger then
		{
		put release blend
		pause 0.3
 		}
	}
if $hidden = 1 then put unhide
var ATTEMPT none

NEXT_ATTEMPT:
if %ATTEMPT = fourth then goto ENTER_HOME_ERROR
if %ATTEMPT = third then var ATTEMPT fourth
if %ATTEMPT = second then var ATTEMPT third
if %ATTEMPT = first then var ATTEMPT second
if %ATTEMPT = none then var ATTEMPT first

TRY_ENTER:
put move %ATTEMPT %HOME
matchre NEXT_ATTEMPT ^You don\'t have a key\.$
matchre ENTER_HOME_ERROR ^\[Type MOVE HELP for more information\.\]$
matchre ENTER_HOME_SUCCESS ^You walk (in|through)
matchwait

ENTER_HOME_ERROR:
put #echo
put #echo
put #echo Must wait for someone to open the door!
put #echo
put #echo
waitforre suddenly opens\!$
var ATTEMPT none
goto NEXT_ATTEMPT

ENTER_HOME_SUCCESS:
put #parse INSIDE!
exit
