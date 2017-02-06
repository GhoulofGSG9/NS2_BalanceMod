-- Called when research or upgrade complete
function Armory:OnResearchComplete(researchId)

	if researchId == kTechId.AdvancedArmoryUpgrade then

		self:SetTechId(kTechId.AdvancedArmory)

		local techTree = self:GetTeam():GetTechTree()
		local researchNode = techTree:GetTechNode(kTechId.AdvancedWeaponry)

		if researchNode then

			researchNode:SetResearchProgress(1.0)
			techTree:SetTechNodeChanged(researchNode, string.format("researchProgress = %.2f", self.researchProgress))
			researchNode:SetResearched(true)
			techTree:QueueOnResearchComplete(kTechId.AdvancedWeaponry, self)

		end

		local researchNode = techTree:GetTechNode(kTechId.HeavyMachineGunTech)
		if researchNode then

			researchNode:SetResearchProgress(1.0)
			techTree:SetTechNodeChanged(researchNode, string.format("researchProgress = %.2f", self.researchProgress))
			researchNode:SetResearched(true)
			techTree:QueueOnResearchComplete(kTechId.HeavyMachineGunTech, self)

		end

	end

end



