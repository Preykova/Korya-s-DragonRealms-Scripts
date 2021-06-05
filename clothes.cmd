#
# debug 10
#
# .clothes on to get dressed
# .clothes off to get nekky
# .clothes [on/off] 2 to get dressed/nekky with your second set
# .clothes [on/off] slip to force attempting to slip items on/off
# .clothes [on/off] 2 slip to force attempt to slip items with your second set!
# .clothes [on/off] [anything not a number or "slip"] to force removing/getting items even if omnihider support is set!
# 
# SLIP - 0 for normal, 1 to always do it
# HIDER - 0 for normal, 1 for omnihider support. Will "show [item] normal" to hide instead of removing it
# CLOTHES - list of clothing items, always start and end with 0
# BAGS - list of bags those items go into/come from, always start and end with 0
#
# For clothes that turn into fabric when not worn, use "[adjective] fabric-[noun]" to show that it is both fabric and the item it turns into.
#
# Omnihider support works by taking the noun of the item and dropping all adjectives, which may cause problems with some items, depending on what you wear.
#
# See examples below!
#

var CLOTHES none
if $charactername = Korya then
	{
	var SLIP = 0
	var HIDER = 1
	var CLOTHES 0|steelsilk pants|fighting shirt|moccasins|armband|wristwrap|0
	var BAGS 0|shadows|shadows|shadows|shadows|shadows|0
	}
if $charactername = Cleyra then
	{
	var HIDER = 1
	var SLIP = 0
	var CLOTHES 0|crimson skirt|blouse|cavalier boots|whip|belt|baldric|longcoat|scarf|cavalier hat|open spectacles|0
	var BAGS 0|swordsman pack|swordsman pack|swordsman pack|swordsman pack|swordsman pack|swordsman pack|swordsman pack|swordsman pack|swordsman pack|swordsman pack|0
	var CLOTHES2 0|skirt|surcoat|forest boots|broad hat|thin spectacles|0
	var BAGS2 0|portal|portal|portal|portal|portal|portal|0
	var CLOTHES3 0|green fabric-sarong|green fabric-bandeau|sandals|broad hat|thin spectacles|0
	var BAGS3 0|portal|portal|portal|portal|portal|portal|0
	}

if %CLOTHES = none then
	{
	put #echo
	put #echo red This character isn't set up yet!
	put #echo
	exit
	}
var SHOW %HIDER
var SET
if_2 then 
	{
	if matchre ("%2","1|2|3|4|5|6|7|8|9") then var SET %2
	else 
		{
		eval 2 tolower(%2)
		if matchre ("%2","sl|sli|slip") then var SLIP 1
		var HIDER 0	
		}
	}
if_3 then 
	{
	eval 3 tolower(%3)
	if matchre ("%3","sl|sli|slip") then var SLIP 1
	var HIDER 0
	}
var CLOTHES %CLOTHES%SET
var BAGS %BAGS%SET

START:
if matchre ("%SET","0|1") then var SET
if matchre ("%SET","2|3|4|5|6|7|8|9") then
	{
	if matchre ("%CLOTHES","0%SET") then
		{
		put #echo
		put #echo red That clothing set does not exist for this character!
		put #echo
		exit
		}
	}
var NUMBER 1
if matchre ("%1","on") then goto ON

SORT_TO_END:
eval ITEM element("%CLOTHES","%NUMBER")
if %ITEM = 0 then goto OFF_START
math NUMBER add 1
goto SORT_TO_END

OFF_START:
math NUMBER subtract 1

OFF:
eval ITEM element("%CLOTHES","%NUMBER")
eval THING replacere("%ITEM","(^.*\s)","")
var FABRIC 0
if matchre ("%ITEM","fabric-") then
	{
	eval THING replacere("%THING","(fabric\-)","")
	eval FABRIC replacere("%ITEM","(\-.*)","")
	eval ITEM replacere("%ITEM","(fabric\-)","")
	}
eval PACK element("%BAGS","%NUMBER")
math NUMBER subtract 1
if %ITEM = 0 then goto END
goto REMOVE

ON:
eval ITEM element("%CLOTHES","%NUMBER")
eval THING replacere("%ITEM","(^.*\s)","")
if matchre ("%ITEM","fabric-") then
	{
	eval THING replacere("%THING","(fabric\-)","")
	eval ITEM replacere("%ITEM","(\-.*)","")
	}
eval PACK element("%BAGS","%NUMBER")
math NUMBER add 1
if %ITEM = 0 then goto END
goto GET

GET:
if %HIDER = 1 then goto SHOW
pause 0.1
if %SLIP = 0 then put get my %ITEM from my %PACK
if %SLIP = 1 then put slip my %ITEM from my %PACK
matchre GET ^\.\.\.wait|^Sorry|^You are still
matchre WEAR ^You (get|are already|remove|silently)
matchre SHOW ^But that is already in your inventory\.$
matchre GET2 ^What were you referring to\?$
matchwait

GET2:
pause 0.1
if %SLIP = 0 then put get my %ITEM
if %SLIP = 1 then put slip my %ITEM from my %PACK
matchre GET2 ^\.\.\.wait|^Sorry|^You are still
matchre WEAR ^You (get|are already|remove|silently)
matchre SHOW ^But that is already in your inventory\.$|^What were you referring to\?$
matchwait

SHOW:
if %SHOW = 0 then goto ON
pause 0.1
put show my %THING always
matchre WEAR ^\.\.\.wait|^Sorry|^You are still
matchre GET2 ^You need to be wearing that first.|^You need to specify one of your own objects for that.
matchre ON will always show when people LOOK at you\, regardless of any hider items you may be wearing\.$
matchwait

WEAR:
pause 0.1
if %SLIP = 0 then put wear %ITEM
if %SLIP = 1 then put slip %ITEM
matchre WEAR ^\.\.\.wait|^Sorry|^You are still
matchre SHOW ^You (slip|slide|strap|work|attach|put|place|sling|drape|pull|hang|tie|carefully|set|silently|step|wrap)|^You can't wear any more items like that\.
matchre GET2 ^You need to be wearing that first\.
matchwait

REMOVE:
pause 0.1
if %HIDER = 1 then put show my %THING normal
if %HIDER = 0 then 
	{
	if %SLIP = 0 then put remove my %ITEM
	if %SLIP = 1 then put slip my %ITEM
	}
matchre REMOVE ^\.\.\.wait|^Sorry|^You are still
matchre STOW ^You (remove|toss|loosen|pull|take|work|slide|aren't wearing|carefully|detach|sling|untie|slip|yank|deftly|quickly|silently)|^Untying its strings
matchre OFF can now be hidden|^You need to be wearing|^You need to specify|^What were you referring to\?$|^Remove what\?$
matchwait

STOW:
if %FABRIC != 0 then var ITEM %FABRIC
pause 0.1
if %SLIP = 0 then put put my %ITEM in my %PACK
if %SLIP = 1 then put slip my %ITEM in my %PACK
matchre STOW ^\.\.\.wait|^Sorry|^You are still
matchre OFF ^You put your|^Stow what?|^You silently slip
matchwait

END:
put #echo
if matchre ("%1","on") then 
	{
	put #echo aqua All dressed up!
	put #echo
	put .sort
	exit
	}
put #echo aqua All naked now!
put #echo
exit

ERROR:
put #echo
put #echo red You appear to be missing an item!
put #echo
exit
