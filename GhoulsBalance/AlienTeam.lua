local oldUpdateBioMassLevel = AlienTeam.UpdateBioMassLevel
function AlienTeam:UpdateBioMassLevel()
	oldUpdateBioMassLevel(self)

	self.maxBioMassLevel = math.min(self.maxBioMassLevel + 1, 12)
end