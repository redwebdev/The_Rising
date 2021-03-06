nightsister_elder = Creature:new {
	objectName = "@mob/creature_names:nightsister_elder",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "nightsister",
	faction = "",
	level = 278,
	chanceHit = 27.25,
	damageMin = 1520,
	damageMax = 2750,
	baseXp = 26654,
	baseHAM = 321000,
	baseHAMmax = 392000,
	armor = 3,
	resists = {200,25,25,200,200,200,200,200,-1},
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
	creatureBitmask = PACK + KILLER + HEALER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_dathomir_nightsister_elder.iff"},
	lootGroups = {
		{
			groups = {
				{group = "crystals_premium",  chance = 1000000},
				{group = "nightsister_common",  chance = 1000000},
				{group = "armor_attachments",  chance = 1000000},
				{group = "clothing_attachments",  chance = 1000000},
				{group = "pistols",  chance = 1000000},
				{group = "rifles",  chance = 1000000},
				{group = "carbines",  chance = 1000000},
				{group = "melee_weapons",  chance = 1000000},
				{group = "axkva_min",  chance = 1000000},
				{group = "redeed2",  chance = 1000000}
			},
			lootChance = 10000000
		}
	},
	weapons = {"mixed_force_weapons"},
	conversationTemplate = "",
	attacks = merge(tkamaster,swordsmanmaster,fencermaster,pikemanmaster,brawlermaster)
}

CreatureTemplates:addCreatureTemplate(nightsister_elder, "nightsister_elder")
