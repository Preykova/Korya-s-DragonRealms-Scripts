#debug 10

var ESP general|trade|guild|race|local|private|personal|0
if $charactername = Korya then var ESP general|trade|guild|race|local|private|personal|0
if $charactername = Cleyra then var ESP general|trade|guild|race|local|private|personal|0

var COUNT 0

END_THOUGHTCAST:
if $SpellTimer.Thoughtcast.active = 1 then
	{
	put release thoughtcast
	matchre END_THOUGHTCAST ^\.\.\.wait|^Sorry|^You are still stunned
	matchre GWETHSTART ^The melodic whispers recede as your mind goes quiet.|^Release what\?
	matchwait
	} 

GWETHSTART:
put rub my gweth
matchre GWETHSTART ^\.\.\.wait|^Sorry|^You are still stunned
matchre CHANNELS ^Since you already have telepathy|^A chorus of foreign thoughts
matchwait

CHANNELS:
eval CHANNEL element("%ESP","%COUNT")
if %CHANNEL = 0 then goto END
math COUNT add 1

SET_CHANNEL:
pause 0.1
put esp listen %CHANNEL 
matchre SET_CHANNEL ^\.\.\.wait|^Sorry|^You are still stunned|^With a moment of focus you close
matchre CHANNELS ^With a moment of focus, you open
matchwait

END:
put #echo
put #echo aqua All approved ESP channels are on!
put #echo





