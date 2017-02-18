sher_kar_two_eventboss = Creature:new {
	customName = "Sher Kar (BOSS)",
	socialGroup = "geonosian_creature",
	pvpFaction = "",
	faction = "",
	level = 300,
	chanceHit = 95,
	damageMin = 570,
	damageMax = 2550,
	specialDamageMult = 25,
	baseXp = 3005409,
	baseHAM = 4400000,
	baseHAMmax = 5629000,
	armor = 3,
	resists = {30,30,30,30,30,30,30,30,30},
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
	creatureBitmask = PACK + STALKER + KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	scale = 1.5,

	templates = {"object/mobile/som/sher_kar.iff"},
	lootGroups = {},
	weapons = {"creature_spit_heavy_flame"},
	reactionStf = "@npc_reaction/slang",
	attacks = {
		{"creatureareacombo","StateAccuracyBonus=100"},
		{"creatureareaknockdown","StateAccuracyBonus=100"},
		{"knockdownattack","KnockdownChance=100"},
		{"creatureareaknockdown","KnockdownChance=100"},
		{"dizzyattack","DizzyChance=100"},
		{"stunattack","StunChance=100"},
		{"mildpoison","PoisonChance=100"},
		{"intimidationattack","IntimidationChance=100"},
		{"mediumpoison","PoisonChance=100"},
		{"creatureareapoison","PoisonChance=100"},
		{"mediumDisease","DiseaseChance=100"},
		{"mildDisease","DiseaseChance=100"},
		{"strongpoison","PoisonChance=100"},
		{"strongDisease","DiseaseChance=100"},
		{"creatureareaattack","StateAccuracyBonus=100"}
	}
}

CreatureTemplates:addCreatureTemplate(sher_kar_two_eventboss, "sher_kar_two_eventboss")
