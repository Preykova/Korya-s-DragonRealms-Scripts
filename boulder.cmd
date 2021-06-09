if !matchre ("$roomobjs","massive granite boulder") then exit

var COMBAT 0
action var COMBAT 1 when ^(closes to melee range on you\!$|leaps to melee with you\!$|^\[You\'re .* balanced)
action goto PUSH when ^The ground trembles slightly\, causing a massive granite boulder to rock back and forth

PUSH:
pause 0.01
put push boulder
matchre PUSH ^\.\.\.wait|^Sorry\.|^You are still stunned|^You stop pushing
matchre KNEEL ^At the bottom of the hollow\, a low tunnel is revealed\!
matchwait

KNEEL:
if %COMBAT = 1 then gosub RETREAT
pause 0.01
put kneel
matchre KNEEL ^\.\.\.wait|^Sorry\.|^You are still stunned
matchre TUNNEL ^You kneel
matchwait

TUNNEL:
if %COMBAT = 1 then gosub RETREAT
pause 0.01
put go tunnel
matchre TUNNEL ^\.\.\.wait|^Sorry\.|^You are still stunned|^You are engaged
matchre DONE ^Wriggling on your stomach\, you crawl into a low tunnel\.
matchwait

STAND:
pause 0.01
put stand
matchre STAND ^\.\.\.wait|^Sorry\.|^You are still stunned|^The weight of|^You are so over
matchre RETURN ^You stand|^You are already standing\.$
matchwait 

STAND_FIX_RETREAT:
gosub STAND

RETREAT:
pause 0.01
put retreat
matchre RETREAT ^\.\.\.wait|^You are still stunned|^Sorry\,|^You retreat back to pole range.
matchre STAND_FIX_RETREAT ^You must stand first.
matchre NO_COMBAT ^You retreat from combat\.|^You are already as far away as you can get\!
matchwait

NO_COMBAT:
var COMBAT 0

RETURN:
return

DONE:
waitforre ^\[Before the Gate of Souls\]
gosub STAND
