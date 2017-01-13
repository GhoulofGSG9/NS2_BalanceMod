local oldAddResearchNode = TechTree.AddResearchNode
function TechTree:AddResearchNode(techId, prereq1, prereq2, addOnTechId)
	if techId == kTechId.Spores then
		prereq1 = kTechId.BioMassFive
	end

	oldAddResearchNode(self, techId, prereq1, prereq2, addOnTechId)
end
