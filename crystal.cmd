#debug 10
#
# PACK = 0 for worn sanowrets, or container noun for where its stored
# THIEF = set to 1 if you need to stop Khri to regain Concentration
# GAZE = 0 to exhale, 1 to gaze
# 
# This script pairs with my .research script! 

var PACK 1

if $charactername = Cleyra then 
	{
	var PACK 0
	var THIEF 0
	var GAZE 1
	}
if $charactername = Korya then
	{
	var PACK 0
	var THIEF 0
	var GAZE 0
	}

if %PACK = 1 then exit

if matchre ("$lefthand|$righthand","sanowret crystal") then goto GAZE

START:
if %PACK = 0 then goto GAZE
pause 0.2
put get my sanowret crystal from my %PACK
matchre START ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre GAZE ^You get a .* crystal from inside|^You are already holding that
matchwait

GAZE:
if $concentration <= 90 then 
	{
	if %THIEF = 1 then goto KHRISTOP
	}
if $concentration != 100 then goto CONCENTRATION
if %GAZE = 0 then put exhale my sanowret crystal 
if %GAZE = 1 then put gaze my sanowret crystal
matchre GAZE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre CONCENTRATION ^You exhale softly on your sanowret crystal\, and scintillating sparks of light dance across its surface\.
matchre WAIT ^Knowledge from your
matchre KHRISTOP ^However\, nothing much else happens\, as you lack the concentration to focus\.
matchwait

WAIT:
pause 65

DONE:
if %PACK = 0 then goto EXIT
put put my sanowret crystal in my %PACK
matchre DONE ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre EXIT ^You put your crystal in
matchwait

EXIT:
put #parse BOOP!
exit

CONCENTRATION:
if $Arcana.LearningRate >= 30 then goto DONE
pause 5
if $concentration = 100 then goto GAZE
goto CONCENTRATION

KHRISTOP:
pause 0.2
put khri stop
matchre KHRISTOP ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre CONCENTRATION ^You attempt to relax your mind from all of its meditative states.|^Please rephrase that command.
matchwait
