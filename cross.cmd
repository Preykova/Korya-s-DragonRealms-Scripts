if "$zonename" = "The Crossing" then
	{
	var TUNNEL 650
	var EXIT 23
	goto START
	}
if "$zonename" = "Southern Trade Road Part 1 (Ferry to Leth Deriel)" then
	{
	var TUNNEL 107
	var EXIT 6
	goto START
	}

put #echo
put #echo red Not in Crossing or STR1!
put #echo
exit

START:
put #goto %TUNNEL
matchre NEXT  ^YOU HAVE ARRIVED
matchwait 40
put #script abort automapper
pause
goto START

NEXT:
put #goto %EXIT
matchre CHECK ^YOU HAVE ARRIVED
matchwait 40
put #script abort automapper
pause
goto NEXT

CHECK:
if "$zonename" = "Southern Trade Road Part 1 (Ferry to Leth Deriel)" then exit
put #goto 46
matchre DONE ^YOU HAVE ARRIVED
matchwait 10
put #script abort automapper
pause
goto CHECK

DONE:
put #parse INCROSSINGNOW
