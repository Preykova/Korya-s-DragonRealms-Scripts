# debug 10
# Copy the following line to the command input before using this script!
# #trigger {^SIGN\: (\w+) (.*)} {#var SIGN_MESSAGE $2}
#
# Usage is: .sign [player] [message] or .sign group [message]
#
# Please use proper ending punctuation.
#

var TARGET %1
if %TARGET = group then goto SIGN
eval NAME1 replacere ("%TARGET","(?!^[a-z]|^[A-Z])(.*)","$1")
eval NAME2 replacere ("%TARGET","(^[a-z]|^[A-Z])","$1")
eval NAME1 toupper(%NAME1)
var TARGET %NAME1%NAME2
if matchre ("$roomplayers","%TARGET") then goto SIGN

ERROR:
put #echo
put #echo red That person is not here!
put #echo
exit

SIGN:
put #parse SIGN: %0
pause 0.001
#
# HEY! YOU SHOULD CHANGE THE ACT LINE TO CUSTOMIZE YOUR SIGNING!
#
if %TARGET = group then put act makes a flurry of complicated hand signals towards everyone in her group.
else put act :%TARGET makes a flurry of complicated hand signals towards \@.
pause 0.02
put #gag ^You whisper
put whisper %TARGET $SIGN_MESSAGE
pause 0.7
put #ungag ^You whisper
if %TARGET = group then var TARGET the group
put #echo >Log You sign to %TARGET: $SIGN_MESSAGE
put #echo You sign to %TARGET: "$SIGN_MESSAGE"
