
var SKILLS Shield_Usage|Light_Armor|Chain_Armor|Brigandine|Plate_Armor|Defending|Parry_Ability|Small_Edged|Large_Edged|Twohanded_Edged|Small_Blunt|Large_Blunt|Twohanded_Blunt|Slings|Bow|Crossbow|Staves|Polearms|Light_Thrown|Heavy_Thrown|Brawling|Offhand_Weapon|Melee_Mastery|Missile_Mastery|Life_Magic|Lunar_Magic|Elemental_Magic|Inner_Magic|Arcane_Magic|Inner_Fire|Holy_Magic|Attunement|Arcana|Targeted_Magic|Augmentation|Debilitation|Utility|Warding|Sorcery|Evasion|Athletics|Perception|Stealth|Locksmithing|Thievery|First_Aid|Outdoorsmanship|Skinning|Forging|Engineering|Outfitting|Alchemy|Enchanting|Scholarship|Appraisal|Performance|Tactics|Empathy|Thanatology|Backstab|Trading|Bardic_Lore|Expertise|Scouting|Conviction|Thuergy|Astrology|Summoning|nothing
var COUNT 0
if_1 then var DRAIN %1
if_2 then var DRAIN %1_%2
eval DRAIN tolower("%DRAIN")

FIND:
eval SKILL element("%SKILLS","%COUNT")
if %SKILL = nothing then goto ERROR
eval SKILL_LOW tolower("%SKILL")
if matchre ("%SKILL_LOW","%DRAIN") then goto FOUND
math COUNT add 1
goto FIND

ERROR:
put #echo
put #echo red Could not find that skill!
put #echo
exit

FOUND:
put #echo
put #echo aqua Set to quit when %SKILL is drained!
put #echo

LOOP:
pause 60
if $%SKILL.LearningRate = 0 then goto END
goto LOOP

END:
pause 0.1
put quit
pause 0.1
put #echo
put #echo aqua Sleepy time!
put #echo
put #script stop all
