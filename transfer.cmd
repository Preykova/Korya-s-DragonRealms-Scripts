#debug 10
 
var LIST box|trunk|coffer|strongbox|skippet|caddy|casket|chest|crate|0
var COUNT 0

if_1 then var ORIGIN %1
if_2 then var DESTINATION %2
if_2 then goto START

ERROR:
put #echo
put #echo aqua Start script with ".transfer container1 container2"!
put #echo aqua Or ".transfer container dump/drop"!
put #echo
exit

START:
eval ITEM element("%LIST","%COUNT")
math COUNT add 1
if %ITEM = 0 then goto END

GET:
pause 0.01
put get %ITEM in my %ORIGIN
matchre GET ^\.\.\.wait|^Sorry|^You are still stunned
matchre STOW ^You get
matchre START ^What were you
matchwait

STOW:
pause 0.01
if matchre ("%DESTINATION","my drop") then put drop my %ITEM
else put put my %ITEM in my %DESTINATION
matchre STOW ^\.\.\.wait|^Sorry|^You are still stunned
matchre GET ^You put|^You drop
matchre END_ERROR ^There is no room|^You just can't get|^No matter|^There isn't any more room
matchwait

END_ERROR:
put #echo
put #echo red Destination container %DESTINATION is full!
put #echo

END:
exit
