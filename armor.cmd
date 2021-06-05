#
# .armor on for wearing stuff
#
# .armor off for taking it all off
#
# ARMOR: list of all your armor and combat gear, separated with |, and always end with 0 
# BAGS: If you put everything in one bag, then only list one bag. If the items go into different bags, list each bag for each item!
# FLUFF: If you start the script with an item in your hands, this item will be stowed and retrieved after the script is done.
# 
# If you have in your hands a "large sack" from a repairman, it will lower the sack to your feet, then equip things in your list from the sack.
#
# To replace an item, list both with a comma; armor first, then the item to replace. Example: "hauberk, kelp dress"
# Do the same with the bags. Example: "shadows, portal" will put/get the hauberk in the shadows, and put/get the kelp dress in the portal.
#

# debug 10
var ARMOR none

if $charactername = Keinruf then
if $charactername = Cleyra then
	{
	var ARMOR longcoat|buckler|parry stick|greaves|cowl, hat|swordsman's gloves|tail knife|0
	var BAGS swordsman's pack
	var FLUFF portal
	}
if $charactername = Korya then
	{
	var ARMOR odaj|shield|armguard|plate mask|gauntlets|vambraces|lamellar helm|tail knife|0
	var BAGS shadows
	var FLUFF portal
	}

if %ARMOR = none then
	{
	put #echo
	put #echo red This character isn't set up yet!
	put #echo
	exit
	}

var NUMBER 0
var RIGHTHAND 0
var LEFTHAND 0
var SACK 0
var SLIP 0
if matchre ("%2","s|sl|sli|slip") then var SLIP 1
if matchre ("$righthand|$lefthand","large sack") then gosub SACK
if !matchre ("$righthand","Empty") then 
	{
	var RIGHTHAND $righthand
	var ITEM %RIGHTHAND
	var PACK %FLUFF
	gosub STOW 
	}
if !matchre ("$lefthand","Empty") then 
	{
	var LEFTHAND $lefthand
	var ITEM %LEFTHAND
	var PACK %FLUFF
	gosub STOW 
	}

LIST:
eval ITEM element("%ARMOR","%NUMBER")
eval PACK element("%BAGS","%NUMBER")
if %ITEM = 0 then goto DONE
if matchre ("%ITEM",",") then
	{
	if matchre ("%1","of|off") then
		{	
		eval BACKUP replacere("%ITEM","^(.*)\, ","")
		eval ITEM replacere("%ITEM","(\, .*)","")
		eval PACKUP replacere("%PACK","^(.*)\, ","")
		eval PACK replacere("%PACK","(\, .*)","")
		}
	else 
		{
		eval BACKUP replacere("%ITEM","(\, .*)","")
		eval ITEM replacere("%ITEM","^(.*)\, ","")
		eval PACKUP replacere("%PACK","^(.*)\, ","")
		eval PACK replacere("%PACK","(\, .*)","")
		}
	goto SWAP
	}
if matchre ("%1","of|off") then gosub REMOVE
else 
	{
	if %SACK = 1 then var PACK large sack
	gosub GET
	gosub WEAR
	}
math NUMBER add 1
goto LIST

SWAP:
gosub REMOVE 
var ITEM %BACKUP
var PACK %PACKUP
if %SACK = 1 then var PACK large sack
gosub GET
gosub WEAR
math NUMBER add 1
goto LIST

SACK:
var SACK 1
pause 0.1
put lower my sack to ground
matchre SACK ^\.\.\.wait|^Sorry\,|^You are still stunned
matchre RETURN ^You lower the
matchwait

GET:
pause 0.1
if %SLIP = 1 then put slip my %ITEM from my %PACK
if %SLIP = 0 then put get my %ITEM from my %PACK
matchre GET ^\.\.\.wait|^Sorry\,|^You are still stunned
matchre RETURN ^You (get|are already|remove|silently|pick up)|^But that is already in your inventory\.
matchre GET2 ^What were you referring to\?
matchwait

GET2:
pause 0.1
if %SLIP = 1 then put slip my %ITEM
if %SLIP = 0 then put get my %ITEM
matchre GET2 ^\.\.\.wait|^Sorry\,|^You are still stunned
matchre RETURN ^You (get|are already|remove|silently|pick up)|^But that is already in your inventory\.
matchre ERROR ^What were you referring to\?
matchwait

WEAR:
pause 0.1
if %SLIP = 1 then put slip my %ITEM
if %SLIP = 0 then put wear my %ITEM
matchre WEAR ^\.\.\.wait|^Sorry\,|^You are still stunned
matchre RETURN ^You (slip|slide|strap|work|attach|put|place|sling|drape|pull|hang|tie|carefully|set|silently|step|wrap)|^You can't wear any more items like that\.|^You are already wearing|^Wear what\?
matchwait

REMOVE:
pause 0.1
if %SLIP = 1 then put slip my %ITEM
if %SLIP = 0 then put remove my %ITEM
matchre REMOVE ^\.\.\.wait|^Sorry\,|^You are still stunned
matchre STOW ^You (remove|toss|loosen|pull|take|work|slide|aren't wearing|carefully|detach|sling|untie|slip|yank|deftly|quickly|silently)|^Untying its strings|^You need to be wearing
matchre ERROR ^What were you referring to\?|^Remove what\?
matchwait

STOW:
pause 0.1
if %SLIP = 1 then put slip my %ITEM in my %PACK
if %SLIP = 0 then put put my %ITEM in my %PACK
matchre STOW ^\.\.\.wait|^Sorry\,|^You are still stunned
matchre RETURN ^You (put your|silently slip)
matchre ERROR ^Stow what\?
matchwait

DONE:
if %RIGHTHAND != 0 then 
	{
	var ITEM %RIGHTHAND 
	var PACK %FLUFF
	gosub GET
	}
if %LEFTHAND != 0 then
	{
	var ITEM %LEFTHAND
	var PACK %FLUFF
	gosub GET
	}
if %SACK = 1 then 
	{
	var ITEM large sack
	gosub GET2
	}
put #echo
if matchre ("%1","on") then put #echo lime Hurray! All armored up!
if matchre ("%1","off") then put #echo pink Hurray! All defenseless now!
put #echo
put #parse ARMORCHANGED
if %SACK = 1 then put inv my large sack
exit

ERROR:
put #echo
put #echo red Missing %ITEM!
put #echo

RETURN:
return
