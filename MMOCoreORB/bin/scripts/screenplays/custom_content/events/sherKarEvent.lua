local ObjectManager = require("managers.object.object_manager")

SherKarScreenPlay = ScreenPlay:new {
	numberOfActs = 1,

	-- sher kar vars
	sherKarOneTemplate = "sher_kar_eventboss",
	sherKarTwoTemplate = "sher_kar_two_eventboss",
	sherKarLocation = {0, 2963.31, 290, -4696.46, 286.282, 0},

	-- terminal vars
  terminalModal = "object/tangible/dungeon/terminal_free_s1.iff",
	terminalName = "Volcanic Testing Unit",
  -- (planet, modal, x, z, y, cellID?, ow, ?, oy, ?)
	terminalLocation = {2878.32, 304.78, -4734.3, 0, -0.5, 0, 0.866025, 0},

	-- lair and minion vars
	younglingTemplate = "sher_kar_youngling_eventminion",
	adultTemplate = "sher_kar_adolescent_eventminion",
	lairModal = "object/static/destructible/destructible_cave_wall_damprock.iff",
  lairHealth = 200000,
  spawnLocations = {
    {2879.41, 290, -4702.47, 0, 1, 0, 0, 0},
    {2966.51, 290, -4610.18, 0, 1, 0, 0, 0},
    {3031.17, 290, -4651.98, 0, 1, 0, 0, 0},
    {3013.38, 290, -4754.45, 0, 1, 0, 0, 0}
  },
	younglingWaveTimer = 5 * 1000, -- time between youngling waves

	-- message vars
	eventStartedMessage = " seems to have disturbed a creature within it!", -- terminal name added to start
	eventOnCDMessage = " batteries are currently recharging...", -- terminal name added to start
	eventInProgressMessage = " is still taking readings. Please wait...", -- terminal name added to start
	eventPhaseTwoMessage = "Come forth my younglings!", -- Sher Kar says
	eventPhaseThreeMessage = "So you defeated my minors. Lets see how you fair against my strongest!", -- Sher Kar says
	eventPhaseFourMessage = "Sher Kar gathers strength from the the volcano ready for his final fight!", -- Local broadcast message

  -- reset timer for event: set 2mins for debugging
	killResetTimer = 2 * 60 * 1000,
}

registerScreenPlay("SherKarScreenPlay", true)

function SherKarScreenPlay:start()
	if (isZoneEnabled("lok")) then
		print("Sher Kar Loaded")
		self:spawnObjects()
		self:resetData()
	end
end

function SherKarScreenPlay:spawnObjects()
	local spawnedSceneObject = LuaSceneObject(nil)
	local spawnedPointer
	local tLoc = self.terminalLocation

  -- (planet, modal, x, z, y, cellID?, ow, ?, oy, ?)
  spawnedPointer = spawnSceneObject("lok", self.terminalModal, tLoc[1], tLoc[2], tLoc[3], tLoc[4], tLoc[5], tLoc[6], tLoc[7], tLoc[8])
	spawnedSceneObject:_setObject(spawnedPointer)
	spawnedSceneObject:setCustomObjectName(self.terminalName)

	if (spawnedPointer ~= nil) then
		createObserver(OBJECTRADIALUSED, "SherKarScreenPlay", "terminalUsed", spawnedPointer);
	end
end

function SherKarScreenPlay:resetData()

end

function SherKarScreenPlay:terminalUsed(pTerminal, pPlayer, radialSelected)
	if (pPlayer == nil) then
		return 0
	end

	if (radialSelected == 20) then
		local isEventStarted = readData("sher_kar_event:event_started")
		local isEventOnCD = readData("sher_kar_event:event_oncd")

		if (isEventOnCD == 1) then
			CreatureObject(pPlayer):sendSystemMessage(self.terminalName .. self.eventOnCDMessage)
		else
			if (isEventStarted == 0) then
				CreatureObject(pPlayer):sendSystemMessage(self.terminalName .. self.eventStartedMessage)
				writeData("sher_kar_event:event_started", 1)
				self:startPhaseOne()
			else
				CreatureObject(pPlayer):sendSystemMessage(self.terminalName .. self.eventInProgressMessage)
			end
		end
	end

	return 0
end

function SherKarScreenPlay:phaseCheck(pSherKar, pPlayer)

	local bossPercent = self:bossLowestPercent(pSherKar)
	local currentPhase = readData("sher_kar_event:event_phase")

	if (bossPercent <= 75) and (currentPhase == 1) then
		spatialChat(pSherKar, self.eventPhaseTwoMessage)
		writeData("sher_kar_event:event_phase", 2)
		self:startPhaseTwo(pSherKar, pPlayer)

		return 0
	end

	if (bossPercent <= 50) and (currentPhase == 2) then
		spatialChat(pSherKar, self.eventPhaseThreeMessage)
		writeData("sher_kar_event:event_phase", 3)
		--self:startPhaseThree(pSherKar, pPlayer)

		return 0
	end

	if (bossPercent <= 25) and (currentPhase == 3) then
		spatialChat(pSherKar, self.eventPhaseFourMessage)
		writeData("sher_kar_event:event_phase", 4)
		--self:startPhaseFour(pSherKar, pPlayer)

		return 0
	end

	return 0
end

function SherKarScreenPlay:bossLowestPercent(pSherKar)
	local boss = LuaCreatureObject(pSherKar)

	if ( boss ~= nil ) then
		local bossHealthPercent = ((boss:getHAM(0) / boss:getMaxHAM(0)) * 100)
		local bossActionPercent = ((boss:getHAM(3) / boss:getMaxHAM(3)) * 100)
		local bossMindPercent = ((boss:getHAM(6) / boss:getMaxHAM(6)) * 100)

		if (bossHealthPercent < bossActionPercent) and (bossHealthPercent < bossMindPercent) then
			return bossHealthPercent
		end

		if (bossActionPercent < bossHealthPercent) and (bossActionPercent < bossMindPercent) then
			return bossActionPercent
		end

		if (bossMindPercent < bossActionPercent) and (bossMindPercent < bossHealthPercent) then
			return bossMindPercent
		end
	end

	return 100 -- default to 100% to prevent early phase starts on error or lag
end

function SherKarScreenPlay:startPhaseOne()
	local Loc = self.sherKarLocation
	local sherKar = spawnMobile("lok", self.sherKarOneTemplate, Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], Loc[6])
	createObserver(DAMAGERECEIVED, "SherKarScreenPlay", "phaseCheck", sherKar)

	return 0
end

function SherKarScreenPlay:startPhaseTwo(pSherKar, pPlayer)
	self:shuffleSpawns()
	local spawnedPointer
	local spawnedSceneObject
	local locOne = self.spawnLocations[1]
	local locTwo = self.spawnLocations[2]

	spawnedPointer = spawnSceneObject("lok", self.lairModal, locOne[1], locOne[2], locOne[3], locOne[4], locOne[5], locOne[6], locOne[7], locOne[8])
	TangibleObject(spawnedPointer):setMaxCondition(self.lairHealth)
  --spawnedSceneObject:_setObject(spawnedPointer)
	--spawnedSceneObject:setCustomObjectName("Younglings Lair")
  createObserver(OBJECTDESTRUCTION, "SherKarScreenPlay", "onLairDestroyed", spawnedPointer)

	spawnedPointer = spawnSceneObject("lok", self.lairModal, locTwo[1], locTwo[2], locTwo[3], locTwo[4], locTwo[5], locTwo[6], locTwo[7], locTwo[8])
	TangibleObject(spawnedPointer):setMaxCondition(self.lairHealth)
  --spawnedSceneObject:_setObject(spawnedPointer)
	--spawnedSceneObject:setCustomObjectName("Younglings Lair")
  createObserver(OBJECTDESTRUCTION, "SherKarScreenPlay", "onLairDestroyed", spawnedPointer)

	return 0
end

function SherKarScreenPlay:startPhaseThree(pSherKar, pPlayer)
	local spawnedPointer
	local spawnedSceneObject
	local locOne = self.spawnLocations[3]
	local locTwo = self.spawnLocations[4]
	local minionOne
	local minionTwo

	spawnedPointer = spawnSceneObject("lok", self.lairModal, locOne[1], locOne[2], locOne[3], locOne[4], locOne[5], locOne[6], locOne[7], locOne[8])
	--spawnedSceneObject:_setObject(spawnedPointer)
	--spawnedSceneObject:setCustomObjectName("Adolescent Lair")
	minionOne = spawnMobile("lok", self.adultTemplate, locOne[1], locOne[2], locOne[3], locOne[4], locOne[5], locOne[6])
	--ObjectManager.withCreatureObject(minionOne, function(add)
	--	add:engageCombat(pPlayer)
	--end)

	spawnedPointer = spawnSceneObject("lok", self.lairModal, locTwo[1], locTwo[2], locTwo[3], locTwo[4], locTwo[5], locTwo[6], locTwo[7], locTwo[8])
	--spawnedSceneObject:_setObject(spawnedPointer)
	--spawnedSceneObject:setCustomObjectName("Adolescent Lair")
	minionTwo = spawnMobile("lok", self.adultTemplate, locTwo[1], locTwo[2], locTwo[3], locTwo[4], locTwo[5], locTwo[6])
	--ObjectManager.withCreatureObject(minionTwo, function(add)
	--	add:engageCombat(pPlayer)
	--end)

	return 0
end

function SherKarScreenPlay:startPhaseFour(pSherKar, pPlayer)
	local Loc = self.sherKarLocation
	local sherKar = spawnMobile("lok", self.sherKarTwoTemplate, Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], Loc[6])
	createObserver(OBJECTDESTRUCTION, "SherKarScreenPlay", "killed", sherKar)

	return 0
end

function SherKarScreenPlay:onLairDestroyed(pLairObject, pKiller, nothing)
  if (pLairObject == nil or pKiller == nil) then
    return 1
  end
  SceneObject(pLairObject):destroyObjectFromWorld()

  return 1
end

function SherKarScreenPlay:shuffleSpawns()
	local n = #self.spawnLocations
	  while n < 2 do
	    local k = math.random(n)
	    self.spawnLocations[n], self.spawnLocations[k] = self.spawnLocations[k], self.spawnLocations[n]
	    n = n - 1
	 end

	 return 0
end

function SherKarScreenPlay:spawnMinionsOne()
	local lair = readData("sher_kar_event:lair_one")
	if (lair ~= 0) then
		self:spawnMinion(self.spawnLocations[1])
		createEvent(self.younglingWaveTimer, "SherKarScreenPlay", "spawnMinionsOne", "", "")
	end

	return 0
end

function SherKarScreenPlay:spawnMinionsTwo()
	local lair = readData("sher_kar_event:lair_two")
	if (lair ~= 0) then
		self:spawnMinion(self.spawnLocations[1])
		createEvent(self.younglingWaveTimer, "SherKarScreenPlay", "spawnMinionsTwo", "", "")
	end

	return 0
end

function SherKarScreenPlay:spawnMinion(pLoc)
	local youngling = spawnMobile("lok", self.younglingTemplate, pLoc[1], pLoc[2], pLoc[3], pLoc[4], pLoc[5], pLoc[6])
end

function SherKarScreenPlay:killed()
	print("SherKar Killed")
	
	writeData("sher_kar_event:event_oncd", 1)
	createEvent(self.killResetTimer, "SherKarScreenPlay", "resetEvent", "", "")

	return 0
end

function SherKarScreenPlay:resetEvent()
	print("SherKar Reset")

	writeData("sher_kar_event:event_started", 0)
	writeData("sher_kar_event:event_phase", 1)
	writeData("sher_kar_event:event_oncd", 0)
	writeData("sher_kar_event:lair_one", 0)
	writeData("sher_kar_event:lair_two", 0)

	return 0
end
