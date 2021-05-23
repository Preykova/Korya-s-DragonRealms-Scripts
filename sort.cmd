START:
put sort auto head
pause 0.5
if $charactername = Korya then 
	{
	put sort goggles
	put #gag {^A Field Medic \"(Off|On)\-duty\" button}
	gosub SORT down button 7
	put #ungag {^A Field Medic \"(Off|On)\-duty\" button}
	}
if $charactername = Cleyra then 
	{
	put #gag {^A stylish crimson}
	gosub SORT up longcoat 7
	put #ungag {^A stylish crimson}
	}
exit

SORT:
math SORTED set $3
var SORT_OBJECT $2
var SORT_DIR $1
goto DO_SORT

SORT_SUBTRACT:
math SORTED subtract 1
if %SORTED = 0 then goto RETURN

DO_SORT:
pause 0.1
put sort %SORT_DIR my %SORT_OBJECT
matchre DO_SORT ^\.\.\.wait|^You are still stunned|^Sorry\, you may only
matchre RETURN it cannot be moved (up|down)\.$
matchre RETURN has been moved (up|down) in (a|some)
matchre EXIT ^You may only sort items in your inventory.
matchre SORT_SUBTRACT has been moved (up|down) in your inventory\.$
matchwait

RETURN:
return

EXIT:
var SORTED 1
return
