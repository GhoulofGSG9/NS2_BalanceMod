local oldGetTechAllowed = Hive.GetTechAllowed
function Hive:GetTechAllowed(techId, techNode, player)
	local allowed, canAfford = oldGetTechAllowed(self, techId, techNode, player)

	if techId == kTechId.ResearchBioMassThree then
		allowed = allowed and self.bioMassLevel == 3
	end

	return allowed, canAfford
end

local oldGetTechButtons = Hive.GetTechButtons
function Hive:GetTechButtons()
	local techButtons = oldGetTechButtons(self)

	if self.bioMassLevel == 3 then
		techButtons[2] = kTechId.ResearchBioMassThree
	end

	return techButtons
end

local oldUpdateResearch = Hive.UpdateResearch
function Hive:UpdateResearch()
	oldUpdateResearch(self)

	local researchId = self:GetResearchingId()
	if researchId == kTechId.ResearchBioMassThree then
		self.biomassResearchFraction = self:GetResearchProgress()
	end
end