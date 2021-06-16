#
# TIE = 1 to tie your bundle off after selling it (for F2P item management), 0 to leave it
# Usage: .bundle [item]
# Will (try to) pull that item from your bundle, sell the bundle, then re-bundle the rope.
#

var TIE 0
if $charactername = Cleyra then var TIE 0
if $charactername = Korya then var TIE 0

if ("$zonename" = "The Crossing") then
	{
	if $roomid = 220 then goto BUNDLE
	put #goto 220
	waitforre ^YOU HAVE ARRIVED
	}

BUNDLE:
var FROM in my bundle
if_1 then gosub ACTION get my %1 %FROM
if matchre ("$lefthand|$righthand","rope") then 
	{
	gosub ACTION bundle
	gosub ACTION wear bundle
	put #echo
	put #echo red Not enough things to sell!
	put #echo
	goto DONE
	}
gosub ACTION remove bundle
gosub ACTION sell bundle
if matchre ("$lefthand|$righthand","%1") then 
	{
	gosub ACTION bundle
	gosub ACTION wear bundle
	if %TIE = 1 then
		{
		gosub ACTION tie bundle
		gosub ACTION tie bundle
		gosub ACTION adjust bundle
		}
	}
if matchre ("$lefthand|$righthand","rope") then gosub ACTION stow rope

DONE:
put #parse BOOP!
exit

ELSEWHERE:
var FROM

ACTION:
pause 0.1
put $0
matchre ACTION ^\.\.\.wait|^You are still stunned|^Sorry, you may only
matchre ELSEWHERE ^What were you
matchre RETURN ^That's not going to work|^You (take|sling|put|remove|bundle|carefully|are already)|^But that is already|And there's your rope back again\.\"$
matchwait

RETURN:
return
