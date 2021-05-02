action put #echo yellow >Log PICKED UP ITEM AT FEET: $1 when ^You pick up the (\w+) lying at your feet

#
# Apply this trigger to use this script.
# #trigger {^You notice (.*) do not wish to leave it behind.} {#send .stowfeet}
#
# BACKUP_BAG is for a large container with usually lots of room.
# BACKUP_POUCH is for 10-of-any-item war belts and hip pouches.
#

var COMMAND $lastcommand

if $charactername = Cleyra then
	{
	var BACKUP_BAG eddy
	var BACKUP_POUCH none
	}
if $charactername = Korya then
	{
	var BACKUP_BAG eddy
	var BACKUP_POUCH none
	}

ATFEET:
put stow feet
matchre ATFEET ^\.\.\.wait|^Sorry|^You are still stunned|^System is|^You pick up the
matchre DONE ^Stow what\?
matchre ALERT ^You need a free hand to pick that up.
matchwait

ALERT:
put #flash
put #echo
put #echo
put #echo red ** HANDS ARE FULL! ** CANNOT STOW ITEM AT FEET! **
put #echo red >Log ** HANDS ARE FULL! ** CANNOT STOW ITEM AT FEET! **
put #echo
put #echo

var RESOLVED 0
var LEFT %BACKUP_BAG
var RIGHT %BACKUP_BAG

BACKUPPLAN_LEFT:
pause 0.01
var ITEM $lefthandnoun
put put my $lefthandnoun in my %LEFT
matchre BACKUPPLAN_LEFT ^\.\.\.wait|^Sorry|^You are still stunned|^System is
matchre RESOLVED_LEFT ^You put
matchre FAILED_LEFT ^There's no room in the|^\[Containers can't be placed
matchre CHANGEPLAN_LEFT ^The .* is too long to fit|^No matter how
matchwait

RESOLVED_LEFT:
put #echo
put #echo lime ** STORED LEFT HAND [%ITEM] IN %LEFT! **
put #echo lime >Log ** STORED LEFT HAND [%ITEM] IN %LEFT! **
put #echo
var RESOLVED 1
goto BACKUPPLAN_RIGHT

FAILED_LEFT:
if %LEFT = %BACKUP_BAG then goto CHANGEPLAN_LEFT

BACKUPPLAN_RIGHT:
var ITEM $righthandnoun
pause 0.01
put put my $righthandnoun in my %RIGHT
matchre BACKUPPLAN_RIGHT ^\.\.\.wait|^Sorry|^You are still stunned|^System is
matchre RESOLVED_RIGHT ^You put
matchre FAILED_RIGHT ^There's no room in the|^\[Containers can't be placed
matchre CHANGEPLAN ^The .* is too long to fit|^No matter how
matchwait

RESOLVED_RIGHT:
put #echo
put #echo lime ** STORED RIGHT HAND [%ITEM] IN %RIGHT! **
put #echo lime >Log ** STORED RIGHT HAND [%ITEM] IN %RIGHT! **
put #echo
goto ATFEET

CHANGEPLAN_LEFT:
var LEFT %BACKUP_POUCH
if %BACKUP_POUCH = none then goto FAILED_LEFT
goto BACKUPPLAN_LEFT

CHANGEPLAN_RIGHT:
var RIGHT %BACKUP_POUCH
if %BACKUP_POUCH = none then goto FAILED_RIGHT
goto BACKUPPLAN_RIGHT

FAILED_RIGHT:
if %RIGHT = %BACKUP_BAG then goto CHANGEPLAN_RIGHT
if %RESOLVED = 1 then goto ATFEET

DIE_I_GUESS:
put #echo red >Log These items may or may not be worth more than your field exp and favors.
put #echo red >Log Nevertheless, you're doomed by them, so sort it yourself or die!

DONE:
put %COMMAND
