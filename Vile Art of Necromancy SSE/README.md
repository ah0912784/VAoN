VILE ART OF NECROMANCY 2.0
By Aghnaar Mareth
Ported to SSE by cbgreely

*SKSE 1.05.09+ IS REQUIRED TO RUN THIS MOD*

DESCRIPTION
In Vanilla Skyrim I was enthralled by the Ritual Stone ability and I've tried to use its power to storm a Thalmor prison with the undead...but Necromancy isn't that good in the original game, so, after the Creation Kit came out, 
I begun to work upon this mod, which attempts to empower Necromancy and other dark arts. This mod will add the following features to your Skyrim experience:

- All vanilla necromantic spells and abilities (including Ritual Stone) have enhanced duration and power. They still cannot be used on summoned creatures and dragons, but you can have any other kind of creature as thrall for an undefinite amount of time!
- New ingredients (soul gem powder, human fat, etc..) are added to the game.
- You will be able to grind bones into bonemeal.
- A powerful necromantic grimoire (Necronomicon) is added to the game*. If you find it and study it, you'll unlock the "advanced" features of this game.
- All Daedric artifacts added by this mod (including the Necronomicon) are forbidden by the Empire and by most other governments, so they'll be confiscated by guards if you're found with them...and the Vigil of Stendarr won't take it kindly if finds them in your backpack!
- (Advanced) You will be able to dissect any NPC with your dagger to get all kinds of ghastly ingredient and body part (skulls, hearts, fat, etc...).
- (Advanced) You will be able to "rebuke" undead creatures (including your zombies and thralls) to gain control over them (if hostile), equip them,  improve them (with special Daedric artifacts), force them to wait or follow you and even destroy them!
- (Advanced) You will learn how to produce powerful Daedric artifacts to improve your undead minions, turning them into unstoppable killing machines!
- (Advanced) Reanimate a huge army of undead minions with the Army of Darkness spell.
- (Advanced) Sell the souls of your enemies to the Daedra Lords for Daedric Coins (...but do it at your risk!!) with the Daedric Bargain spell.
- (Advanced) Reanimate back to life your enemies at the risk of losing your own lifeforce with the Blasphemous Resurrection spell.
- (Advanced) Craft the Akaviri Spirit Bottles and collect dragon souls with them...and, may be, turn them into powerful artifacts or into useful (filled) Black Soul Gems!
- (Advanced) Craft the Distiller and equip it, if you want to produce Distilled Human Blood or to produce very powerful and useful potions and poisons.
- (Advanced) Craft the Mimir, equip it and use the knowledge of the dead to produce mighty magical artifacts with many different enchantments (implemented, but not tested). 

And...apart from the above, I have also made craftable useful vanilla ingredients like Dwarven Oil and Spriggan Sap and shadier substances, like Skooma and Double-Distilled Skooma.

In order to support those who had problems in finding the Necronomicon or are too far into the game to get it from its original location, I have added the option to craft an Apocryphal Copy of the Necronomicon.

This is a non-original copy which is supposed to be written by the player on dictation from Daedra Lords and from the souls of passed necromancers.

The book could be crafted at the Tanning Rack and requires the player to have the following (just to be available):

- Enchanting 50+
- Conjuration 50+
- Conjure Dremora Lord spell

The book itself will require 1 ruined book, 1 daedra heart and 13 filled black soulgems.


* = The Necronomicon could be found in Helgen Keep or in a location near Riverwood (where there is a witch...), but still it's probably the best if you start a new game to fully experience this mod.

CHANGELOG
1.0		Original version.
1.1		Added Craftable Apocryphal Copy of the Necronomicon.
1.2		Increased the Necronomicon font by two steps (now it's 10...I hope won't be messed up, but I am not willing to increase more because fonts seems to behave strangely in Skyrim, shrinking and growing in impredictable ways *even* after you tell them what's the size!). Now I hope will be more readable.
		I've dumped the whole Quest thing and I've changed the letter in Anise cabin accordingly. Now the original Necronomicon will be found in the Captain's chest AND you'll find an Apocryphal Copy in Anise cabin. Both the book and the letter will be enabled at the beginning, so I hope they'll be easier to find.
		Army of Darkness now should take in account Line of Sight. No more "reanimation surprises" and I've added a check on whether the target is dead or not [I hope this solves the "unanimation" issue and the weird behaviour after multiple casting. Consider that the original Dead Thrall spell doesn't have this condition...but I hope it works!]
		The Subjugate option now should make turn a non-reanimate undead into a teammate. 
		Quick and dirty solution for "Come" and "Wait" commands. Now the AI of the undead is disabled by the Wait command and enabled by the Come command. It's not perfect, but it's the easiest solution without having to resort to Quests...now it won't follow you when it's not supposed to! :)
		Now when dissecting a corpse, all the harvested body parts are left on the ground, allowing you to pickup whatever you want (instead of dumping it in your inventory).
		I am moving all the Bonemeal recipes to the Cooking pot in order to keep it in line with what was done for JK Crafting Breakdown (which is the "still kicking" version of Valsosa's mod).
		I've changed "Human Blood", "Human Skin", "Distilled Human Blood" into the more generic "Blood", "Skin" and "Distilled Blood". However, I'll not change other components as I'm not feeling comfortable with that (because vanilla ingredients have racial specifications [such as "troll fat"] or because I'd need to change vanilla ingredients [such as "human heart" or "human meat"]). 
		Improved the scripting...now you should not have some weird message or behaviour from Daedric Bargain and other effects.
1.3		The script for "Come" and "Wait" has been changed slightly. Now the undead should follow you as long as you've given a "come" command and should stay for a while (3 in-game days, 8.640 RL seconds) and then disappear if you've given it a "wait" command.
		The Mimir has been changed so now it enhance the power of enchantments and the power of soulgems used in incantation, but it no longer attempts to give extra effects.
1.4		Solved the issue with Skooma and other craftable which were set to the wrong Crafting Furniture (now they are at the CookingPot as intended).
		Changed the name of Vanilla Skooma to "Watered Skooma" and increased its price to 44 gold coins.
		Added two recipes for "Watered Skooma" for the would-be Skyrim drug-dealers out there. One is hard to make as Skooma, but more profitable. The other has easier to find ingredients and is easier to make.
		Added "Skooma" ("pure" Skooma) which will be crafted according to the recipe from Necronomicon and its price has been set to 500 gold coins.
		Changed the value of "Double Distilled Skooma" to 2.000 gold coins and doubled its effectiveness (note that Skooma and Watered Skooma are still the most profitable recipes).
		Attached a script to all in-game Buckets which allow both to "Fill" and to "Take" them when they are dropped to the ground. "Fill" will allow to fill them once or many times (at a stamina cost) and each "Fill" will bring 4 units of "Water".
		Added "Water" as a new food (mainly for use with watered skooma).
		Now vampires can drink blood to stave off their hunger.
		Added Elixir of Vampirism to become vampire with 100% certainty (but still take 3 days to change).
		The Mimir now is fixed and works as intended, adding +1 extra enchantment at specific skill levels (+1 below 25, +2 over 25, +3 over 75 and +4 over 100).
		Removed any reference to the "Horn of Death" (this was a botched attempt to call all your undead minions to a location, but was an utter failure, so I dropped it... :( )
1.5		Added the "Configure" button to the Rebuke menu.
		Within the "Configure" menu there are two submenu (Follow Delay and Putrefaction Timer), which allow to customize the amount of time before a minion catches up with the player when ordered to "Follow" and the amount of time before it is destroyed when ordered to "Wait".
1.6		Added the Blood Replicator, a specialized alchemical device which (when equipped) replicate a single unit of blood through the use of a special alchemical substance (nutrient solution); this device was conceived for the vampires which don't want to depend on murderous practice to survive.
		Note that the Blood Replicator is similar to the Distiller, in which it works by equipping it (as an armor), but it doesn't require the alchemical bench...just equipping will activate its script. However, I wasn't able to unequip it automatically (the script is there, but doesn't work!), so you'll have to unequip it manually.
		Added the Daedric Mystery Box, which is a new (craftable) daedric artefact which allows to "spend" one's daedric coins to gain Dragon Souls, gold coins and a special one-shot artefact ("Oblivion Tears") which supercharges your Enchanting skills (especially if paired with the Mimir and perks like Extra Effects!).
1.7		Added Bucket of Ever-Bountiful Water (which is a mod-specific bucket to avoid incompatibilities...so you'll have to use console "help" to find its code and add via console).
		Fixed the recipe for Daedric Mystery Box.
		Solved a little problem with Mimir, Blood Duplicator and Distiller meshes when using them with a female character (I've forgot to change that from the original duplication of Mutant Heart).
1.8		Added a recipe to extract salt from blood, a recipe to extract water from blood and a recipe to extract ectoplasm from blood (none of them is cost-efficient, since selling blood would be more profitable, but are a last-ditch method to get these ingredients).
		Added a Configure option to the Necronomicon menu, which allows you to switch between the Vanilla Anatomy (dagger in hand to dissect) and the Alternate Anatomy (scalpel in inventory to dissect). The Necronomicon will still grant you the vanilla Anatomy,
		so, if you want the alternate version, you'll have to take vanilla Anatomy and switch it with the Configure option. The Configuration option also allows you to choose between the Chaotic (default) dissection method, which drops all items around you as if you'd
		just finished butchering the corpse and the (less realistic) Orderly dissection method, which transfers all items to your backpack. Solved an issue with Necronomicon not showing properly.
		Added the new spell Imprison Soul Essence which allows you to create a special artefact (Skull of Enslaved Soul) which takes all the attributes and the skill of a corpse and could be thereafter used to improve them (as long as the victim had an higher score, its level isn't too much lower than yours and your Conjuration is high enough).
1.9		Improved the Imprison Soul Essence spell with elements from the aborted "Highlander" immortal script: Now even characters with character lower level and/or skill level will grant a one-shot potential for skill increase...the increase will be calculated as 1/100ths and the victim level will affect it (+1/100th for each 25% of caster level...up to 100 and +5)
		as will the skill rank level (+1/100th for each 25 skill levels, up to 100 and +5). This benefit will be one-shot, but any victim will grant it...so high level necromancers could just "harvest" any victim for memories, knowledge and power. Moreover some error in the script were patched up.
		Added a craftable Horn of the Dead which could be used to call the undead minions that you've ordered to "Come".
2.0		Imprison Soul Essence has been made more realistic by making impossible multiple uses on the same victim. A new spell called Extract Spirit Essence has been added, which allows to extract specific essences from non-NPC victims; while the requirements for this new spell are less strict, it is usable only once and for one type of essence.
		Nine elemental spirit essence (Corruption, Energy, Freedom, Honor, Integrity, Life, Sin, Thought, Wrath) have been added as ingredients and are linked to specific attributes and/or skills, which they greatly enhance. Moreover if you equip a Distiller and have at least 1 unit of spirit essence in your inventory, you'll find a significant number
		of Elixir which require a large quantity of spirit essence, skooma and an uncommon ingredient (which change for each elixir); there are a total of 21 elixir, each associated with an attribute or a skill, which allow you to permanently increase them by +1 just by imbibing it. In fact this is a variant of Imprison Soul Essence which has a different
		"flavour", because the original spell was more versatile, while this new spell allows you to quickly increase specific skills, but will require you to stockpile the appropriate ingredients. This spell won't *work* on dragon corpses and this for a simple reason: Dragon corpses aren't the real dragon corpse, so aren't truly associated with the original
		creature and the spell won't recognize the being as a corpse. Attribute enhancement from Imprison Soul Essence and Extract Spirit Essence has been made more useful by using SetAV instead of ModAV, so the change is permanent and affects the base actor value. Daedric Mystery Box will now offer the option to trade one of the nine elemental 
		spirit essence with another with a 1:1 ratio. I have solved an issue with the improvements of Sanguine and Namira...now they work as they were designed to work.


HOW TO ADJUST AN ATTRIBUTE INCREASED VIA IMPRISON SOUL ESSENCE IN 1.9 VERSION
As you have probably noticed, Imprison Soul Essence adds any extra point to attribute as an "empowerment". This wasn't meant to work like that, but was due to my imperfect understanding of the ActorValue mechanics.
My original desire was to have it to act exactly as if they were points of gained through level up (affecting Base Value), but I only found later that this requires the SetValue function.
Now...removing (and, if possible, re-adding) both the Imprison Soul Essence spell and any skull (which cannot be changed, so are lost, sorry) should solve the issue for the future, but the solution for the past is this:
- Check if you have any active enchantment or constant ability that affects your attributes (Health, Magicka and/or Stamina).
- Unequip any enchanted item affecting those statistics.
- Find out the amount of enhancement granted by any constant ability you have (this enhancement will be called OthEn later).
- Use the Player.GetBaseActorValue (BAV) command to get the base value of all your attributes.
- Calculate the appropriate value for the attribute as BAV + OthEn and record any difference between this amount and your total permanent actor value (this is the ImprEn).
- Use Player.ModAV to reduce the value by -ImprEn.
- Use Player.SetAV to increase the base value to BAV + ImprEn.
I am sorry, but I had to use this very same procedure with my own character to set up the previously made changes, but after updating you should have no more to use this "procedure"...

INSTALLATION
Just unpack the content of the zip file into your Data directory, select "Vile Art of Necromancy.esp" and it should work properly.

UNINSTALLATION
Remove all spells and items through console commands, deselect "Vile Art of Necromancy.esp", cancel Vile Art of Necromancy.bsa, Vile Art of Necromancy.bsl and Vile Art of Necromancy.esp and the whole package should be uninstalled.

CREDITS
- Bethesda for making Skyrim.
- JustinOther for allowing me to add the bones from his great "More Interactive Items - Grab Moveable Statics" mod to my mod.
- To all the guys who asked for a new way to spend their hard-earned daedric coins...this version wouldn't been possible if you didn't request this kind of "improvement"! ;P
- L3zard05 for finding out the error with the Daedric Mystery Box (solved in v. 1.7).
- SilentSymphony for finding out the problem with the Unholy Feast of Namira (solved in v. 2.0).