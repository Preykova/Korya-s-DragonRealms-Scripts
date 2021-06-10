#
# Usage: .knit [1-20]
# Where the number is the page for the item you wish to make.
#
# This script assumes your needles, yarn, and tailoring book are all in the same container.
#

action var FINISHED 1 when ^Applying the final touches
action var PAGE 7 when ^Which page do you wish to turn
action var ITEM $2 when crafting (a|an|some) knitted (.*)\.$
action var USE push when ^Next the needles must be pushed to add in some purl stitches.|^The needles are ready to be pushed for the addition of some purl stitching.
action var USE turn when ^Some ribbing should be added next to the garment, by turning the needles.|^Now the needles must be turned to add some ribbing to the piece.
action var USE cast when ^The garment is nearly complete and now must be cast off the needles.

if $charactername = xxx then var TOOLBOX haversack

var CHAPTER 5
var PAGE %1
counter set 0

START:
var FINISHED 0
if !matchre ("$lefthand|$righthand", "knitting needles") then goto BOOK
pause 0.2
put look my knitting needles
matchre START ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre KNIT ^The knitting needles are in the process of knitting
matchre BOOK ^The knitting needles are not in the process of knitting
matchwait

BOOK:
gosub ACTION get my tailoring book

TURNCHAPTER:
pause 0.2
put turn my book to chapter %CHAPTER
matchre TURNCHAPTER ^\.\.\.wait|still stunned|^Sorry, you
matchre NEWITEM ^The book is already turned|^You turn your book to chapter (.*)\, entitled \"Knitted Clothing\"\.$
matchwait 5
put #echo
put #echo yellow The chapter is messed up!
put #echo
math counter add 1
var CHAPTER %counter
goto TURNCHAPTER

NEWITEM:
gosub ACTION turn my book to page %PAGE
gosub ACTION study my book
gosub ACTION put my book in my %TOOLBOX
gosub ACTION get my knitting needles
gosub ACTION get my yarn in my %TOOLBOX
gosub ACTION knit my yarn with my knitting needles
gosub ACTION put my yarn in my %TOOLBOX

KNIT:
var USE knit

KNITTING:
if %FINISHED = 1 then goto FINISHED
gosub ACTION %USE my knitting needles
if %FINISHED = 1 then goto FINISHED
if %USE != knit then gosub ACTION %USE my knitting needles
if %FINISHED = 1 then goto FINISHED
if %USE = cast then gosub ACTION %USE my knitting needles
goto KNIT

FINISHED:
gosub ACTION put my knitting needles in my %TOOLBOX
gosub ACTION stow my %ITEM

DONE:
if $Outfitting.LearningRate <= 30 then goto START
put #echo
put #echo lime All done knitting!
put #echo
#parse BOOP!
exit

ACTION:
var DO $0

DO_ACTION:
pause 0.2
put %DO
matchre DO_ACTION ^\.\.\.wait|^You are still stunned|^Sorry\,
matchre RETURN ^You (get|are already|put|now feel ready|turn)|^Roundtime\:|^What were you|^You need a free hand
matchwait

RETURN:
return
