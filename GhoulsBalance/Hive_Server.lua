function Hive:PerformActivation(techId, position, normal, commander)

	local success = false
	local continue = true


	if techId == kTechId.ShiftHatch then

		success = self:HatchEggs()
		continue = not success

	end

	return success, continue

end

function Hive:HatchEggs()
	local amountEggsForHatch = ScaleWithPlayerCount(kEggsPerHatch, #GetEntitiesForTeam("Player", self:GetTeamNumber()), true)
	local eggCount = 0
	for i = 1, amountEggsForHatch do
		local egg = self:SpawnEgg(true)
		if egg then eggCount = eggCount + 1 end
	end

	if eggCount > 0 then
		self:TriggerEffects("hatch")
		return true
	end

	return false
end

--Todo: This should be tracked via Egg.SetHive
function Hive:GetNumEggs()

	local numEggs = 0
	local eggs = GetEntitiesForTeam("Egg", self:GetTeamNumber())

	for index, egg in ipairs(eggs) do

		if egg:GetLocationName() == self:GetLocationName() and egg:GetIsAlive() and egg:GetIsFree() and not egg.manuallySpawned then
			numEggs = numEggs + 1
		end

	end

	return numEggs

end

function Hive:UpdateSpawnEgg()

	local success = false
	local egg = nil

	local eggCount = self:GetNumEggs()
	if eggCount < ScaleWithPlayerCount(kAlienEggsPerHive, #GetEntitiesForTeam("Player", self:GetTeamNumber()), true) then

		egg = self:SpawnEgg()
		success = egg ~= nil

	end

	return success, egg

end

function Hive:SpawnEgg(manually)
	if self.eggSpawnPoints == nil or #self.eggSpawnPoints == 0 then

		--Print("Can't spawn egg. No spawn points!")
		return nil

	end

	local lastTakenSpawnPoint = self.lastTakenSpawnPoint or 0
	local maxAvailablePoints = #self.eggSpawnPoints
	for i = 1, maxAvailablePoints do

		local j = (i + lastTakenSpawnPoint) % maxAvailablePoints
		local position = self.eggSpawnPoints[j]

		-- Need to check if this spawn is valid for an Egg and for a Skulk because
		-- the Skulk spawns from the Egg.
		local validForEgg = GetCanEggFit(position)

		if validForEgg then

			local egg = CreateEntity(Egg.kMapName, position, self:GetTeamNumber())

			if egg then
				egg:SetHive(self)

				self.lastTakenSpawnPoint = i

				-- Randomize starting angles
				local angles = self:GetAngles()
				angles.yaw = math.random() * math.pi * 2
				egg:SetAngles(angles)

				-- To make sure physics model is updated without waiting a tick
				egg:UpdatePhysicsModel()

				self.timeOfLastEgg = Shared.GetTime()

				if manually then
					egg.manuallySpawned = true
				end

				return egg

			end

		end


	end

	return nil
end