death_watch_battle_droid = Creature:new {
	objectName = "@mob/creature_names:mand_bunker_battle_droid",
	socialGroup = "death_watch",
	faction = "",
	level = 134,
	chanceHit = 5.5,
	damageMin = 795,
	damageMax = 1300,
	baseXp = 12612,
	baseHAM = 56000,
	baseHAMmax = 68000,
	armor = 2,
	resists = {75,75,100,60,100,25,40,85,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	scale = 1.15,

	templates = {
		"object/mobile/death_watch_battle_droid.iff",
		"object/mobile/death_watch_battle_droid_02.iff",
		"object/mobile/death_watch_battle_droid_03.iff"},
	lootGroups = {
		{
			groups = {
				{group = "death_watch_bunker_commoners", chance = 6000000},
				{group = "rifles", chance = 1000000},
				{group = "pistols", chance = 1000000},
				{group = "clothing_attachments", chance = 1000000},
				{group = "armor_attachments", chance = 1000000}
			},
			lootChance = 10000000
		},

		{
			groups = {
				{group = "ranged_components", chance = 10000000}
			},
			lootChance = 1000000

		}
	},
	weapons = {"battle_droid_weapons"},
	conversationTemplate = "",
	attacks = merge(pistoleermaster,carbineermaster,marksmanmaster)
}

CreatureTemplates:addCreatureTemplate(death_watch_battle_droid, "death_watch_battle_droid")
