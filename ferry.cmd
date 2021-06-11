#debug 10

var MOVE 0

var ONBOARD \"Kertigen\'s Honor\"|\"Hodierna\'s Grace\"|\"Her Opulence\"|\"His Daring Exploit\"|A Birch Skiff|A Highly Polished Skiff|\"Northern Pride\"\, Main Deck|\"Theren's Star\"\, Deck|\"The Riverhawk\"|\"Imperial Glory\"|The Evening Star|Damaris\' Kiss|Gondola\, Cab North|Gondola\, Cab South
var AIRSHIPBOARD Aboard the Dirigible\, Gondola|The Bardess\' Fete\, Deck\|Aboard the Balloon\, Gondola

if $zoneid = 90 then var MAMMOTH sea
if $zoneid = 58 then var MAMMOTH tall
if $zoneid = 150 then
	{
	if_1 then
		{
		if matchre ("1%","ratha|rath|rat|ra") then 
			{
			var MAMMOTH sea
			goto LOOK
			}
		if matchre ("1%","crossing|cross|leth|ace|acen|acena|acenamacra|zoluren|mainland") then 
			{
			var MAMMOTH tall
			goto LOOK
			}
		}
	put #echo
	put #echo red You must specify a destination! .ferry Ratha, or .ferry Leth
	put #echo
	exit
	}

if !matchre ("$scriptlist","automapper") then goto LOOK
put #echo >Log Waiting for automapper to end...

WAIT:
pause 1.5
if matchre ("$scriptlist","automapper") then goto WAIT

LOOK:
put look
matchre LOOK ^\.\.\wait|^Sorry|^You are still stunned

START:
matchre DONE ^\[(Aboard the Dirigible\, Gondola|The Bardess\' Fete\, Deck\|Aboard the Balloon\, Gondola|)\]
matchre BOARDED ^\[(%ONBOARD)\]
matchre GONDOLA_ON ^The gondola stops on the platform and the door silently swings open.|^You also see .* wooden gondola
matchre JOIN_AIRSHIP ^\[JOIN AIRSHIP|^You also see .* teak airship
matchre JOIN_DIRIGIBLE ^\[JOIN CHARCOAL DIRIGIBLE|^You also see .* charcoal dirigible
matchre JOIN_BALLOON ^\[JOIN GNOMISH BALLOON|^You also see .* Gnomish balloon
matchre JOIN_MAMMOTH ^\[JOIN (TALL|SEA) MAMMOTH|^You also see .* (tall|massive) sea mammoth
matchre FERRY ^The ferry .* pulls (up to|into) the dock\.$|^The .* comes to an easy landing at the dock|^You also see .* (Hodierna's Grace|Kertigen's Honor|His Daring Exploit|Her Opulence|Evening Star|Damaris' Kiss)
matchre BARGE ^The barge (Northern Pride|Theren's Star) pulls into the dock.|^You also see .* (Northern Pride|Theren's Star)
matchre SKIFF ^The long River Elf skiff pulls into the dock.|^You also see .* (birch|polished) skiff
matchre RIVERHAWK ^You also see .* barge Riverhawk
matchre GLORY ^You also see .* barge Imperial Glory
matchre THRONE_CITY ^A barge pulls into the dock
matchre WHARF ^You also see .* Langenfirth wharf
matchre PIER ^You also see .* Riverhaven pier
matchre DOCK ^You come to a very soft stop as the ferry reaches the dock.
matchwait

BOARDED:
var MOVE 0
var ONBOARD we did it!
matchre DOCK ^The ferry (.*) reaches the dock and its crew ties the ferry off.|^You come to a very soft stop as the ferry reaches the dock.|^The barge pulls into dock|^The skiff lightly taps the dock
matchre LOOK ^The barge .* reaches its dock and its crew ties the barge off.
matchre GONDOLA_OFF ^With a soft bump, the gondola comes to a stop at its destination.
matchwait

GONDOLA_MOVEN:
move north
goto GONDOLA_OFF

GONDOLA_MOVES:
move south

GONDOLA_OFF:
if matchre ("$roomname","South") then
	{
	put out
	match FRAME The greying wooden boards of the platform have been replaced by paving stones.
	match GONDOLA_MOVEN You can't go there.
	matchwait
	}
if matchre ("$roomname","North") then
	{
	put out
	match RIDGE Two side-by-side granite beams rise up from the edge of the ridge
	match GONDOLA_MOVES You can't go there.
	matchwait
	}

JOIN_MAMMOTH:
if matchre ("$roomobjs","massive sea mammoth") then
	{
	if %MAMMOTH = sea then 
		{
		var MOVE join sea mammoth
		goto DO_MOVE
		}
	#else, MAMMOTH = tall, so see if the tall mammoth is there...
	}
if matchre ("$roomobjs","tall sea mammoth") then
	{
	if %MAMMOTH = tall then 
		{
		var MOVE join tall mammoth
		goto DO_MOVE
		}
	#in this case, the massive mammoth was not there, and that's the one to wait for...
	}
goto START

ON_MAMMOTH:
if matchre ("%1","fang|fang cove") then exit
match BEACH [Shore Walk, Rocky Path]
match BEACH [Acenamacra Pier]
match NEXT_MAMMOTH [Fang Cove, Dock]
matchwait

NEXT_MAMMOTH:
if matchre ("%MAMMOTH","sea") then
	{
	var MAMMOTH tall
	goto LOOK
	}
var MAMMOTH sea
goto LOOK

THRONE_CITY:
RIVERHAWK:
if matchre ("$roomobjs","Riverhawk") then var MOVE go Riverhawk
GLORY:
if matchre ("$roomobjs","Imperial Glory") then var MOVE go Glory
goto DO_MOVE

WHARF:
if %MOVE = 0 then var MOVE go wharf
PIER:
if %MOVE = 0 then var MOVE go pier
DOCK:
if %MOVE = 0 then var MOVE go dock
FERRY:
if %MOVE = 0 then var MOVE go ferry
BARGE:
if %MOVE = 0 then var MOVE go barge
SKIFF:
if %MOVE = 0 then var MOVE go skiff
GONDOLA_ON:
if %MOVE = 0 then var MOVE go gondola
JOIN_AIRSHIP:
if %MOVE = 0 then var MOVE join airship
JOIN_DIRIGIBLE:
if %MOVE = 0 then var MOVE join dirigible
JOIN_BALLOON:
if %MOVE = 0 then var MOVE join balloon

DO_MOVE:
pause 0.5
put %MOVE
matchre DO_MOVE ^\.\.\.wait|^Sorry\, you|still stunned|^The (Gnomish operator|Elothean aeromancer) says\, \"Woah there
matchre START ^There is no ferry here|^The ferry has just pulled away|stuck here until the next one arrives\.$|^I could not find|^The ferrymaster says\, \"Sorry
matchre DONE ^\[(%AIRSHIPBOARD)\]
matchre NEXT_MAMMOTH ^\[Aboard the Mammoth\, Platform\]
matchre BOARDED ^\[(%ONBOARD)\]
matchre MONEY Come back when you can afford the fare\.\"$|You reach (for your|your) funds\, but realize you\'re short\.$
match NORTH [Salt Yard, Barge Dock]
match NORTH [Ain Ghazal, Ferry Dock]
match SOUTH [Southern Trade Route, Segoltha South Bank]
match SOUTH [North Road, Ferry]
match SOUTH [Stone Docks, Covered Shore]
match EAST [Riverhaven, Pier]
match WEST [Ain Ghazal, East Pier]
match WEST [Haalikshal Highway, Ferry Dock]
match WEST [Langenfirth, Wharf]
match DOOR [Ilaya Taipa, Baso Dock]
match RAMP [Riverhaven, Ferry Dock]
match SQUARE [The Crossing, Alfren's Ferry]
match ERROR_UNKNOWN What were you referring to?
matchwait

NORTH:
pause 0.5
move north
exit

EAST:
pause 0.5
move east
exit

WEST:
pause 0.5
move west
exit

SOUTH:
pause 0.5
move south
if $zoneid = 7 then put #parse ONNTRNOW
exit

FRAME:
pause 0.5
put go frame
exit

RIDGE:
pause 0.5
put go ridge
exit

SQUARE:
pause 0.5
put go square
pause 0.5
put #parse INCROSSINGNOW
exit

RAMP:
pause 0.5
put go ramp
put #parse INRIVERHAVEN
exit

BEACH:
pause 0.5
put go beach
exit

DOOR:
pause 0.5
put go door
exit

ERROR_UNKNOWN:
put #echo
put #echo red Not sure what went wrong there!
put #echo
put #flash
exit

MONEY:
put #echo
put #echo red You don't have enough money!
put #echo
put #flash
put #parse NO MONEY

DONE:
exit
