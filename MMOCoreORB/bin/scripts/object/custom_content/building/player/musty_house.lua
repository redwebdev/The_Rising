object_building_player_musty_house = object_building_player_shared_musty_house:new {
	lotSize = 10,
	baseMaintenanceRate = 80,
	allowedZones = {"corellia", "dantooine", "lok", "naboo", "rori", "talus", "tatooine", "yavin4", "dathomir", "kaas", "endor"},
	publicStructure = 0,
	constructionMarker = "object/building/player/construction/construction_player_house_corellia_large_style_01.iff",
	length = 1,
	width = 1,
	skillMods = {
		{"private_medical_rating", 100},
		{"private_buff_mind", 100},
		{"private_med_battle_fatigue", 15},
		{"jedi_saber_assembly", 50},
		{"jedi_saber_experimentation", 50},
		{"weapon_assembly", 50},
		{"weapon_experimentation", 50},
		{"crafting_general", 50},
		{"general_experimentation", 50},
		{"crafting_structure_general", 50},
		{"structure_experimentation", 50},
		{"crafting_food_general", 50},
		{"food_experimentation", 50},
		{"crafting_bio_engineer_creature", 50},
		{"bio_engineer_experimentation", 50},
		{"crafting_medicine_general", 50},
		{"combat_medicine_experimentation", 50},
		{"crafting_clothing_armor", 50},
		{"armor_experimentation", 50},
		{"engine_assembly", 50},
		{"engine_experimentation", 50},
		{"crafting_droid_general", 50},
		{"droid_experimentation", 50},
		{"medicine_assembly", 50},
		{"medicine_experimentation", 50}
	},
	childObjects = {
			{templateFile = "object/tangible/terminal/terminal_bank.iff", x = -2.83054, z = 0.469543, y = 9.45055, ow = -4.37114e-08, ox = 0, oz = 0, oy = -1, cellid = 1, containmentType = -1},
			{templateFile = "object/tangible/terminal/terminal_mission.iff", x = -4.05691, z = 0.469543, y = 8.82943, ow = -0.382683, ox = 0, oz = 0, oy = -0.923879, cellid = 1, containmentType = -1},
			{templateFile = "object/tangible/beta/beta_terminal_wound.iff", x = 4.54366, z = 0.469543, y = 9.46938, ow = -0.34202, ox = 0, oz = 0, oy = 0.939693, cellid = 1, containmentType = -1},
			{templateFile = "object/tangible/terminal/terminal_guild.iff", x = -0.0201342, z = -32.9999, y = 14.85, ow = -4.37114e-08, ox = 0, oz = 0, oy = -1, cellid = 8, containmentType = -1},
			{templateFile = "object/tangible/terminal/terminal_elevator_up.iff", x = 0, z = -33, y = -1.29, ow = 0, ox = 0, oy = 0, oz = 0, cellid = 10, containmentType = -1}, --Floor 3
			{templateFile = "object/tangible/terminal/terminal_elevator.iff", x = 0, z = -26.0005, y = -1.29, ow = 0, ox = 0, oy = 0, oz = 0, cellid = 10, containmentType = -1}, --Floor 2
			{templateFile = "object/tangible/terminal/terminal_elevator_down.iff", x = 0, z = 0.469522, y = -1.29, ow = 0, ox = 0, oy = 0, oz = 0, cellid = 10, containmentType = -1}, --floor 1
			{templateFile = "object/tangible/terminal/terminal_player_structure.iff", x = 2.85101, z = 0.469541, y = 9.34914, ow = -4.37114e-08, ox = 0, oz = 0, oy = 1, cellid = 1, containmentType = -1},
			{templateFile = "object/tangible/sign/player/house_address.iff", x = -2.73606, z = 2.46955, y = 11.9769, ow = 0, ox = 0, oz = 0, oy = 1, cellid = -1, containmentType = -1}
	},
	shopSigns = {
			{templateFile = "object/tangible/sign/player/house_address.iff", x = -3.17249, z = 1.96954, y = 11.8851, ow = 1.31134e-07, ox = 0, oz = -0, oy = -1, cellid = -1, containmentType = -1, requiredSkill = "", suiItem = "@player_structure:house_address"},
			{templateFile = "object/tangible/sign/player/shop_sign_s01.iff", x = -2.93747, z = 2.16974, y = 11.4647, ow = 0.5, ox = 0.5, oz = 0.5, oy = 0.5, cellid = -1, containmentType = -1, requiredSkill = "crafting_merchant_management_01", suiItem = "@player_structure:shop_sign1"},
			{templateFile = "object/tangible/sign/player/shop_sign_s02.iff", x = -2.93747, z = 2.16974, y = 11.4647, ow = 0.5, ox = 0.5, oz = 0.5, oy = 0.5, cellid = -1, containmentType = -1, requiredSkill = "crafting_merchant_management_02", suiItem = "@player_structure:shop_sign2"},
			{templateFile = "object/tangible/sign/player/shop_sign_s03.iff", x = -2.93747, z = 2.16974, y = 11.4647, ow = 0.5, ox = 0.5, oz = 0.5, oy = 0.5, cellid = -1, containmentType = -1, requiredSkill = "crafting_merchant_management_03", suiItem = "@player_structure:shop_sign3"},
			{templateFile = "object/tangible/sign/player/shop_sign_s04.iff", x = -2.93747, z = 2.16974, y = 11.4647, ow = 0.5, ox = 0.5, oz = 0.5, oy = 0.5, cellid = -1, containmentType = -1, requiredSkill = "crafting_merchant_management_04", suiItem = "@player_structure:shop_sign4"}
	}
}

ObjectTemplates:addTemplate(object_building_player_musty_house, "object/building/player/musty_house.iff")
