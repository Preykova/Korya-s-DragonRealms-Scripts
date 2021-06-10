# debug 10
#
# Example usages: 
# .climb embrasure
# .climb wall hide
# .climb pear tree
# .climb pear tree hidden
# .climb hide pear tree
#
# Hiding while climbing may be buggy!
# It will not try to hide or use Khri if someone is in the room at the start of climbing.
# If you're a thief, learn Silence
# If you're a moon mage, learn to cast Refractive Field at 15 mana with half prep time, or adjust the hiding logic to taste, or for Steps of Vuan
#
# This script is set up to handle Gauge Flow research breaks.
# Useful trigger: #trigger {^You should stop practicing your Athletics skill before you do that.} {#send stop climb;#send $lastcommand}
# Script will wait 8 seconds before resuming the climb.
#

var GUILD 0
if $charactername = xxx then var GUILD Thief
if $charactername = Cleyra then var GUILD MoonMage

action goto STOP_CLIMB when ^Breakthrough!
action goto STOP_CLIMB when ^You make definite progress
action put #flash when ^You are engaged in combat\, so you cease to practice your climbing skills\.$

var CLIMB 0
var HIDE 0

if_1 then
	{
	if matchre ("%1","hidden|hide") then 
		{
		var HIDE 1
		if_2 then 
			{
			var CLIMB %2
			if_3 then var CLIMB %CLIMB %3
			goto START
			}
		goto ERROR
		}
	var CLIMB %1
	}
if_2 then
	{
	if matchre ("%2","hidden|hide") then 
		{
		var HIDE 1
		goto START
		}
	var CLIMB %CLIMB %2
	goto START
	}
if_3 then
	{
	if matchre ("%3","hidden|hide") then 
		{
		var HIDE 1
		goto START
		}
	}
if !matchre ("%CLIMB","0") then goto START

ERROR:
put #echo
put #echo
put #echo aqua Usage is .climb [thing] [thing's second word] [hide (optional)]
put #echo aqua Or else  .climb [hidden] [thing] [thing's second word]
put #echo
put #echo
exit

STOP_CLIMB:
#
# Comment out everything but this label if you use the trigger included in the comments at the top!
#
pause 0.1
put stop climb
matchre STOP_CLIMB ^\.\.\.wait|^Sorry|^You are still stunned
matchre WAIT ^You stop practicing your climbing skills\.
matchwait

WAIT:
pause 8

START:
if $Athletics.LearningRate >= 34 then goto END
if %HIDE = 1 then gosub TRY_HIDE
pause 0.5
put climb practice %CLIMB
matchre START ^\.\.\.wait|^Sorry|^You are still stunned
matchre CHECK ^You begin to practice
matchwait

CHECK:
matchre WAIT ^You stop practicing your climbing skills.
matchre START ^You finish practicing your climbing skill and take a well-earned break.
matchwait

END:
put #echo
put #echo lime Sure climbed that %CLIMB!
put #echo
pause
put #flash
put #parse BOOP!
exit

TRY_HIDE:
if matchre ("$hidden|$invisible","1") then return
if %GUILD = Thief then
	{
	if $SpellTimer.KhriSilence.active = 0 then 
		{
		if matchre ("$roomplayers","^Also here\:") then return
		put khri silence
		pause 9
		}
	}
if %GUILD = MoonMage then
	{
	if $SpellTimer.RefractiveField.active = 0 then
		{
		put prep rf 15
		pause 10
		put cast
		pause
		}
	}
if !matchre ("$roomplayers","^Also here\:") then gosub HIDE

RETURN:
return

HIDE:
pause 0.5
put hide
matchre HIDE ^\.\.\.wait|^Sorry\,|^You are still stunned
matchre RETURN ^Are you sure you want to do that/?|^You (melt|blend|can't hide)|already hidden\!$
matchwait
