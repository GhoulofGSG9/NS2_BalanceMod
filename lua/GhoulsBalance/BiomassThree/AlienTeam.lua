local oldUpdateBioMassLevel = AlienTeam.UpdateBioMassLevel
function AlienTeam:UpdateBioMassLevel()
	oldUpdateBioMassLevel(self)

	self.maxBioMassLevel = 0

	for _, hive in ipairs(GetEntitiesForTeam("Hive", self:GetTeamNumber())) do

		if GetIsUnitActive(hive) then
			self.maxBioMassLevel = self.maxBioMassLevel + 4
		end

	end
end