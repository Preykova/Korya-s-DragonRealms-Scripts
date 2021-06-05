#debug 10
var GUILD none
if matchre ("$charactername", "Cleyra") then var GUILD moonmage
if matchre ("$charactername", "xxx") then var GUILD thief
if matchre ("$charactername", "xxx") then var GUILD ranger

if_1 then
	{
	eval 1 tolower(%1)
	if matchre ("%1","ore|orev|oreva|ayl|ayli|aylian|ayliana|end|endar|endari|endaria") then var DESTINATION Oreva
	if matchre ("%1","vi|viy|viya|viyal|viyalo|rhatt") then var DESTINATION Viyalo
	if matchre ("%1","cl|cle|cley|cleyr|cleyra") then var DESTINATION Cleyra
	if matchre ("%1","ke|kei|kein|keinr|keinru|keinruf|ket|keth|kethr|kethra|keithrai") then var DESTINATION Keinruf
	if matchre ("%1","ko|kor|kory|korya") then var DESTINATION Korya
	if matchre ("%1","nat|nati|natip|natipo|natipoh|natipoha|natipohak|natipohaka") then var DESTINATION Natipohaka
	}
else var DESTINATION $charactername

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
if "$zonename" = "Riverhaven West Gate" then goto RIVERHAVEN_WESTGATE
if "$zonename" = "Faldesu River" then goto SWIM_RIVERHAVEN_S
if "$zonename" = "Mistwood Forest" then goto MISTWOOD
if "$zonename" = "Road to Therenborough" then goto MISTWOOD_SOUTH
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
	var HOME hut
	goto ENTER_HOME

FANG_COVE:
	gosub AUTOMAPPER portal
	pause 0.5
	put go portal
	pause

CROSSING:
if matchre ("%DESTINATION","Cleyra") then goto HOME_CLEYRA
if matchre ("%1","burgle") then 
	{
	gosub AUTOMAPPER xxx
	pause 0.5
	put #parse BURGLE!
	exit
	}
if matchre ("%DESTINATION","Korya") then
	{
	gosub AUTOMAPPER ne gate
	pause 0.5
	goto NEGATE
	}
put #echo
put #echo
put #echo Defaulting to Cleyra's home.
put #echo
put #echo
goto HOME_CLEYRA

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
if matchre ("%DESTINATION","Korya") then 
	{
	gosub AUTOMAPPER 98	
	goto NEGATE
	}
gosub AUTOMAPPER 23
pause 0.5
goto CROSSING

NEGATE_FROM_EGATE:
gosub AUTOMAPPER 53
pause 0.5

NEGATE:
if matchre ("%1","burgle") then goto EGATE_DETOUR
if matchre ("%DESTINATION","Korya") then goto FALDESU
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
if matchre ("%DESTINATION","Korya") then goto NEGATE_FROM_EGATE

EGATE_REAL:
gosub AUTOMAPPER crossing
pause 0.5
goto CROSSING

FALDESU:
gosub AUTOMAPPER 197
pause 0.5

SWIM_RIVERHAVEN_N:
gosub AUTOMAPPER 22
pause 0.5
goto RIVERHAVEN_EASTGATE

RIVERHAVEN:
if matchre ("%DESTINATION","Korya") then goto HOME_KORYA
gosub AUTOMAPPER e gate
pause 0.5

RIVERHAVEN_EASTGATE:
if matchre ("%DESTINATION","Korya") then
	{
	gosub AUTOMAPPER riverhaven
	goto RIVERHAVEN
	}
put dive river
pause

SWIM_RIVERHAVEN_S:
if matchre ("%DESTINATION","Korya") then goto SWIM_RIVERHAVEN_N
gosub AUTOMAPPER 21
pause 0.5
goto NEGATE

MISTWOOD:
gosub AUTOMAPPER riverhaven
pause 0.5

MISTWOOD_SOUTH:
gosub AUTOMAPPER riverhaven
pause 0.5

RIVERHAVEN_WESTGATE:
gosub AUTOMAPPER riverhaven
pause 0.5
goto RIVERHAVEN

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
var ROOM $1 $2
if $roomid = %ROOM then return
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
