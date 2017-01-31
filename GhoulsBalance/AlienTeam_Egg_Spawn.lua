function AlienTeam:UpdateEggGeneration()

	if not self.timeLastEggUpdate then
		self.timeLastEggUpdate = Shared.GetTime()
	end

	if self.timeLastEggUpdate + ScaleWithPlayerCount(kEggGenerationRate, #GetEntitiesForTeam("Player", self:GetTeamNumber())) < Shared.GetTime() then

		local hives = GetEntitiesForTeam("Hive", self:GetTeamNumber())
		local builtHives = {}

		-- allow only built hives to spawn eggs
		for _, hive in ipairs(hives) do

			if hive:GetIsBuilt() and hive:GetIsAlive() then
				table.insert(builtHives, hive)
			end

		end

		for _, hive in ipairs(builtHives) do
			hive:UpdateSpawnEgg()
		end

		self.timeLastEggUpdate = Shared.GetTime()
	end

end