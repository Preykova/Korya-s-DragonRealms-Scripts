#debug 10

action var ITEM $1 when ^VERB_SELECT (.*)$
var LIST 0
var COUNT 0
var LAST 0
var ROW 0

######################
### USER VARIABLES ### 
######################

#ODD LINES
var MAIN_COLOR WhiteSmoke

#EVEN LINES - can use hex colors like so: var ALT_COLOR #B7B7B7 (Hex is 00 to 99, then A0 to FF. Each value is Red, Green, Blue.)
var ALT_COLOR #E0B0B0

#OUTPUT WINDOW
var WINDOW Verbs

#FONT - use "var STYLE mono" for fixed-width
var STYLE

# ITEM LISTS - use underscore for spaces
if $charactername = Cleyra then var LIST HAT_WORN|HAT_HELD|SCARF|SKIRT|BOOTS
if $charactername = Korya then var LIST PANTS|PANTS_SITTING|SHIRT|SHIRT_SITTING
goto START

##################
### VERB LISTS ### 
##################
#
# Every list should start with your character name capitalized, underscore, name of verby item capitalized, colon.
# Followed by "var NAME", and the title of your verby item.
# Then a list of the verbs capitalized, with pipes | <-these things-> | separating them
# Then for every verb, "var [VERB] - " followed by the messaging you want to reference.
# Always follow up the list with "goto DISPLAY"!
#

KORYA_PANTS:
var NAME Fighting Pants (Standing):
var VERBS PUSH|PULL|NOD|GAZE|CLEAN|LEAN|TURN|RAISE|EAT|TAP|SLAP|NUDGE|POKE|THUMP|WEAR|REMOVE
var PUSH       - Korya springs forward, her weight on her toes and ready for a fight. / Korya shuffles forward and ends up flatfooted. [fail]
var PULL       - Korya suddenly slides backward, her weight on her toes and ready for a fight. / Korya clumsily shuffles backward, and almost lands on her duff. [fail]
var NOD        - Korya raises her knee toward her chest and slams her foot down into an aggressive stance. / Korya shifts her feet, though obviously not with the hoped for effect. [fail]
var GAZE       - Korya steps into a defensive stance, her gaze surveying the area. / Korya plants her foot down, though obviously not with the hoped for effect. [fail]
var CLEAN      - Korya casually beats the dust of battle from her steel-blue pants. / Korya cleans an imaginary mote of dust from her steel-blue pants. [fail]
var LEAN       - Korya leans from side to side, adjusting the fit of her steel-blue pants. / Korya leans to one side and stares at her steel-blue pants with a puzzled look. [fail]
var TURN       - Korya suddenly pivots right, clearly ready for anything. / Korya shuffles her feet to the right for some reason. [fail]
var RAISE      - Korya suddenly pivots left, clearly ready for anything. / Korya shuffles her feet to the left for some reason. [fail]
var EAT        - Korya ducks her head down, looking toward her steel-blue pants.
var TAP        - Korya drums her fingers on her thigh.
var SLAP       - Korya leaps into a solid fighting stance. / Korya nearly trips over her own feet. [fail]
var NUDGE      - Korya adjusts her footing, she looks ready to strike at any moment. / Korya moves her feet around, but appears no better off for it. [fail]
var POKE       - With a blinding switch-step and pivot, Korya is suddenly facing what was behind her. / Korya pokes tentatively at her steel-blue pants. [fail]
var THUMP      - Korya nods slightly and momentarily lowers her gaze. / Korya starts to thump her steel-blue pants, but thinks better of it. [fail]
var WEAR       - Korya steps into her steel-blue pants and with a sharp yank to the waist deftly secures them for combat. / Korya steps into her steel-blue pants, stumbling a bit. [fail]
var REMOVE     - Korya deftly works the fasteners and waist of her steel-blue pants and steps out of them. / Korya fumbles with the fasteners of her steel-blue pants and after considerable effort manages to step out of them, nearly falling in the process. [fail]
goto DISPLAY

KORYA_PANTS_SITTING:
var NAME Fighting Pants (Sitting):
var VERBS PUSH|PULL|NOD|GAZE|CLEAN|LEAN|TURN|RAISE|EAT|TAP|SLAP|NUDGE|POKE|THUMP|WEAR|REMOVE
var PUSH       - Korya deftly rolls up the cuffs of her steel-blue pants, quickly lashing them fast. / Korya rolls up the cuffs of her steel-blue pants. [fail]
var PULL       - Korya unlashes the cuffs of her steel-blue pants, and rolls them down. / Korya rolls down the cuff of her steel-blue pants. [fail]
var NOD        - Korya rests her forehead on her knees. / Korya knocks her forehead against her knees. [fail]
var GAZE       - Korya gazes at her steel-blue pants in a searching manner. / Korya stares at her steel-blue pants with a puzzled look. [fail]
var CLEAN      - Korya casually beats the dust of battle from her steel-blue pants. / Korya cleans an imaginary mote of dust from her steel-blue pants. [fail]
var LEAN       - Korya pulls her knees up to her chest. / Korya leans to one side and stares at her steel-blue pants with a puzzled look. [fail]
var TURN       - Korya turns down the waistband of her steel-blue pants. / Korya fiddles with the waistband of her steel-blue pants. [fail]
var RAISE      - Korya turns up the waistband of her steel-blue pants. / Korya fiddles with the waistband of her steel-blue pants.  [fail]
var EAT        - Korya ducks her head down, looking toward her steel-blue pants.
var TAP        - Korya drums her fingers on her steel-blue pants.
var SLAP       - Korya hammers her thighs with her fists. / Korya winces as she slaps her thighs. [fail]
var NUDGE      - Korya pushes her palms into her thighs. / Korya presses the heels of her hands into her thighs, stretching. [fail]
var POKE       - Korya pokes tentatively at her steel-blue pants. / Korya tugs on her steel-blue pants, shifting until she appears more comfortable. [fail]
var THUMP      - Korya nods slightly and momentarily lowers her gaze. / Korya starts to thump her steel-blue pants, but thinks better of it. [fail]
var WEAR       - Korya pulls on her steel-blue pants, tugging on each side of the waist and fastening them for combat. / Korya pulls on her steel-blue pants, fumbling over the various fasteners. [fail]
var REMOVE     - Korya deftly works the fasteners and waist of her steel-blue pants and pulls them off. / Korya fumbles with the fasteners of her steel-blue pants and finally manages to pull them off. [fail]
goto DISPLAY

KORYA_SHIRT:
var NAME Fighting Shirt (Standing):
var VERBS PUSH|PULL|NOD|GAZE|CLEAN|LEAN|TURN|RAISE|EAT|TAP|SLAP|NUDGE|POKE|THUMP|WEAR|REMOVE
var CLEAN         - Korya casually beats the dust of battle from her fighting shirt. / Korya cleans an imaginary mote of dust from her fighting shirt. [fail]
var EAT           - Korya ducks her head down and gnaws on her fighting shirt.
var GAZE          - Korya raises her arms defensively, her gaze surveying the area. / Korya shifts her arms, obviously not certain what she is trying to accomplish. [fail]
var LEAN          - Korya rolls her shoulders, adjusting the fit of her fighting shirt. / Korya stretches out one arm and stares at her fighting shirt with a puzzled look. [fail]
var NOD           - Korya positions her fists outside her chin, elbows out to the sides. / Korya hits her chin with a fist as she moves her hands up to guard. [fail]
var NUDGE         - Korya adjusts her arms as she peers between her fists. / Korya moves her arms around, but appears no better off for it. [fail]
var POKE          - Korya ducks her shoulder and switches her lead arm. / Korya pokes tentatively at her fighting shirt. [fail]
var PULL          - Korya quickly slips her head to one side. / Korya moves her head to the side in a clumsy fashion. [fail]
var PUSH          - Korya raises her hands in front of her, ready for a fight. / Korya raises her hands in front of her face, but leaves an obvious opening. [fail]
var RAISE         - Korya suddenly twists to the left, clearly ready for anything. / Korya turns to the left and winces a little. [fail]
var SLAP          - Korya moves her arms into position to strike. / Korya quickly moves her hands and seems surprised when she strikes her own face. [fail]
var TAP           - Korya drums her fingers on her arm.
var THUMP         - Korya nods slightly, gazing at her fighting shirt. / Korya starts to thump her fighting shirt, but thinks better of it. [fail]
var TURN          - Korya suddenly twists to the right, clearly ready for anything. / Korya turns to the right and winces a little. [fail]
var WEAR          - Korya pulls on her fighting shirt and pushes her arms into the sleeves, deftly securing it for combat. / Korya pulls on her fighting shirt, getting a bit tangled. [fail]
var REMOVE        - Korya deftly works the fasteners of her fighting shirt and shrugs out of it. / Korya fumbles with the fasteners of her fighting shirt and after considerable effort manages to remove it, nearly falling in the process. [fail]
goto DISPLAY

KORYA_SHIRT_SITTING:
var NAME Fighting Shirt (Sitting):
var VERBS PUSH|PULL|NOD|GAZE|CLEAN|LEAN|TURN|RAISE|EAT|TAP|SLAP|NUDGE|POKE|THUMP|WEAR|REMOVE
var CLEAN         - Korya casually beats the dust of battle from her fighting shirt. / Korya cleans an imaginary mote of dust from her fighting shirt. [fail]
var EAT           - Korya ducks her head down and gnaws on her fighting shirt.
var GAZE          - Korya gazes at her fighting shirt in a searching manner. / Korya stares at her fighting shirt with a puzzled look. [fail]
var LEAN          - Korya crosses her elbows in front of herself. / Korya stretches out one arm and stares at her fighting shirt with a puzzled look. [fail]
var NOD           - Korya rests her chin on her fist. / Korya knocks her forehead with her fist. [fail]
var NUDGE         - Korya presses the heels of her hands against her neck. / Korya pushes her hands against her arms. [fail]
var POKE          - Korya tugs on her fighting shirt. /  Korya pokes tentatively at her fighting shirt. [fail]
var PULL          - Korya deftly rolls up the cuffs of her fighting shirt, quickly lashing them fast. / Korya rolls down the sleeves of her fighting shirt. [fail]
var PUSH          - Korya unlashes the cuffed sleeves of her fighting shirt and rolls them down. /  Korya rolls up the sleeves of her fighting shirt. [fail]
var RAISE         - Korya buttons up her fighting shirt. /  Korya fiddles with the waistband of her fighting shirt. [fail]
var SLAP          - Korya hammers her chest with her fists. / Korya winces as she slaps her chest. [fail]
var TAP           - Korya drums her fingers on her arm. 
var THUMP         - Korya nods slightly, gazing at her fighting shirt. / Korya starts to thump her fighting shirt, but thinks better of it. [fail]
var TURN          - Korya opens a button of her fighting shirt. / Korya fiddles with the buttons of her fighting shirt. [fail]
var WEAR          - Korya pulls on her fighting shirt, tugging on each sleeve and fastening it for combat. / Korya pulls on her fighting shirt, fumbling over the various fasteners. [fail]
var REMOVE        - Korya deftly works the fasteners of her fighting shirt and pulls it off. / Korya fumbles with the fasteners of her fighting shirt and finally manages to pull it off. [fail]
goto DISPLAY


CLEYRA_SKIRT:
var NAME Crimson Skirt:
var VERBS ADJUST|CLEAN|CURTSY|TIE|DANCE|PAT|RUB|SHAKE|CLUTCH|FLIP|PINCH|STRUT
var ADJUST - Cleyra carefully adjusts the fit of her crimson skirt, making sure the fabric falls perfectly into place.
var CLEAN  - Cleyra flicks a bit of lint off her crimson skirt, ensuring that the garment is suitable for presentation.
var CURTSY - Grasping the sides of her crimson skirt carefully, Cleyra sinks into a deep curtsy as the fabric pools elegantly around her.
var TIE    - Cleyra fiddles with the fastenings of her crimson skirt, ensuring the garment is properly secured.
var DANCE  - Cleyra dances about the area with a series of twirls, making the crimson skirt flare elegantly around her.
var PAT    - Cleyra gently pats her crimson skirt in nervous anticipation.
var RUB    - Cleyra smoothes out the fabric of her crimson skirt.
var SHAKE  - Cleyra shakes her crimson skirt angrily, stomping about the area.
var CLUTCH - Clutching the side of her crimson skirt tightly, Cleyra fans herself rapidly as her face flushes into a deep blush.
var FLIP   - With a flirtatious wink, Cleyra flips the bottom edge of her crimson skirt up briefly.
var PINCH  - Whispering quietly to herself, Cleyra pinches her crimson skirt, crushing the fabric between her fingers.
var STRUT  - Raising her head slightly, Cleyra strides around the area, her crimson skirt flouncing around her.
goto DISPLAY

CLEYRA_BOOTS:
var NAME Cavalier Boots:
var VERBS ADJUST|BOUNCE|CLEAN|FIDGET|KICK|PAT|PROD|ROLL|RUB
var ADJUST - Cleyra tugs and yanks at her cavalier boots, clearly not satisfied with how they fit.
var BOUNCE - Cleyra bounces up and down on the balls of her feet, clearly too full of energy.
var CLEAN  - Cleyra removes some dirt off her cavalier boots, a frown creasing her face.
var FIDGET - Cleyra taps the toe of one of her cavalier boots, in time to music only she can hear.
var KICK   - Cleyra stomps on the ground, grinding the heels of her crimson boots hard into the ground.
var PAT    - Cleyra pats her cavalier boots as if assuring herself that she is still wearing them.
var PROD   - Cleyra digs inside her cavalier boots, and finally pulls out a stray stone and tosses it aside.
var ROLL   - Cleyra meditatively rocks back and forth on the soles of her crimson boots.
var RUB    - Cleyra rubs one of her cavalier boots against the other, staring into the distance.
goto DISPLAY

CLEYRA_HAT_WORN:
var NAME Cavalier Hat (Worn):
var VERBS TAP|HUG|PULL|CLEAN|SHAKE|NUDGE|PUSH|WAVE|KISS|EAT|TIP
var TAP   - Cleyra nods and tips her hat slightly.
var HUG   - Cleyra flicks her hat with the edges of her fingers, tipping it back slightly.
var PULL  - Cleyra pulls a wide-brimmed crimson cavalier hat sporting a floofy white feather down over her ears.
var CLEAN - Cleyra reaches up and flicks a speck of dust off of her cavalier hat.
var SHAKE - Cleyra gently smoothes the brim of her cavalier hat.
var NUDGE - Cleyra settles her cavalier hat more firmly on her head.
var PUSH  - Cleyra takes off her hat a moment and fans herself with it, then places it back on her head.
var WAVE  - Cleyra reaches up a hand to wave, but it hits her hat instead and knocks it to the ground.
var KISS  - You see Cleyra unobtrusively take off her hat and wipe her mouth on its brim, then quickly replace it.  She glances around, looking slightly guilty.
var EAT   - Cleyra takes off her hat and gnaws on its brim.
var TIP   - Cleyra tips the edge of her cavalier hat down to shade her eyes.
goto DISPLAY

CLEYRA_HAT_HELD:
var NAME Cavalier Hat (Held):
var VERBS HUG|PULL|CLEAN|SHAKE|NUDGE|PUSH|WAVE|KISS|EAT|TIP|BEG
var HUG   - Cleyra hugs her hat, crumpling it as she clutches it to her chest.
var PULL  - Blushing, Cleyra hides her face behind a wide-brimmed crimson cavalier hat sporting a floofy white feather, coyly peeking over the edge.
var CLEAN - Cleyra slaps a wide-brimmed crimson cavalier hat sporting a floofy white feather against her thigh, sending a small cloud of dust swirling into the air.
var SHAKE - With several violent jerks that threaten to send it flying out of her hand, Cleyra tries her best to shake some of the dents out of her cavalier hat.
var NUDGE - Cleyra waves her cavalier hat briskly through the air, producing a crisp *thwap* as air catches in the hat's crown!  You notice the hat looks much neater now.
var PUSH  - Cleyra crumples her hat in one fist.
var WAVE  - You notice Cleyra holding up her cavalier hat and waving it in the air.
var KISS  - Cleyra taps her cavalier hat against her lips, a thoughtful expression on her face.
var EAT   - Cleyra gnaws on the brim of her hat.
var TIP   - Cleyra absently taps her hat against her thigh.
var BEG   - TIP HAT AT [name] - Cleyra shows you her hat, giving a pointed glance to the hat's interior and a wink.
goto DISPLAY

CLEYRA_SCARF:
var NAME Cashmere Scarf:
var VERBS PULL|PUSH|TIE|TURN|THROW|CRUSH|BRUSH
var PULL    - Cleyra adjusts her cashmere scarf, looping it around her neck and pulling it up over her head. [draped over the head and around the neck]
var PUSH    - Cleyra moves her cashmere scarf, adjusting it so the lower half of her face is covered. [loosely wrapped about the lower face and neck] [hides features]
var TIE     - Cleyra ties her cashmere scarf into a knot. [knotted neatly at the throat] 
var TURN    - Cleyra winds her cashmere scarf around her neck. [looped casually around the throat]
var THROW   - Cleyra flips one end of her cashmere scarf casually over one shoulder. [flipped over the shoulder with one end hanging down the back]
var CRUSH   - Cleyra sloppily arranges her cashmere scarf, wrinkling it in the process. [hanging in utter disarray]
var BRUSH   - Cleyra adjusts the fit of her cashmere scarf, smoothing it nicely. [draped elegantly around the neck]
goto DISPLAY

####################
### SCRIPT START ###
####################

START:
if %LIST = 0 then goto ERROR
var LINE1 #echo >%WINDOW %MAIN_COLOR %STYLE
var LINE0 #echo >%WINDOW %ALT_COLOR %STYLE
eval GOTO toupper("$charactername")
if_1 then
	{
	var INPUT %1
	if_2 then var INPUT %INPUT_%2
	if_3 then var INPUT %INPUT_%3
	eval INPUT toupper("%INPUT")
	if matchre ("%LIST","%INPUT") then goto MANUAL_LIST
	goto ERROR_2
	}
put #window show %WINDOW
put #clear %WINDOW
put #echo >%WINDOW aqua %STYLE $charactername's items are:
put #echo >%WINDOW
goto CREATE_LIST

MANUAL_LIST:
eval ITEM element ("%LIST","%COUNT")
if matchre ("%ITEM","%INPUT") then
	{
	put #window show %WINDOW
	put #clear %WINDOW
	goto %GOTO_%ITEM
	}
math COUNT add 1
goto MANUAL_LIST

ERROR:
put #echo
put #echo red This character has no unique verb items!
put #echo
exit

ERROR_2:
put #echo
put #echo red This character does not have that item!
put #echo
exit

CREATE_LIST:
eval LINK element("%LIST","%COUNT")
if %LINK = %LAST then goto WAIT
var LAST %LINK
math COUNT add 1
put #echo >%WINDOW %STYLE %COUNT: 
put #link >%WINDOW %LINK #parse VERB_SELECT %LINK
goto CREATE_LIST

DISPLAY:
var COUNT 0
put #echo >%WINDOW %STYLE aqua %NAME
DISPLAY_LOOP:
eval DISPLAY element("%VERBS","%COUNT")
if %DISPLAY = %LAST then exit
var LAST %DISPLAY
if %ROW = 0 then var ROW 1
else var ROW 0
math COUNT add 1
put %LINE%ROW "%COUNT: %DISPLAY %%DISPLAY"
goto DISPLAY_LOOP

WAIT:
var COUNT 0
waitforre ^VERB_SELECT
put #clear %WINDOW
goto %GOTO_%ITEM
