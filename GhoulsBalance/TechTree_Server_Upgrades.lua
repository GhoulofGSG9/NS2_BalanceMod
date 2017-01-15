local changeTechs = {
	[kTechId.Crush] = kTechId.Spur,
	[kTechId.Vampirism] = kTechId.Shell,
	[kTechId.Silence] = kTechId.Veil
}

local oldAddBuyNode = TechTree.AddBuyNode
function TechTree:AddBuyNode(techId, prereq1, prereq2, addOnTechId)
	if changeTechs[techId] then
		prereq1 = changeTechs[techId]
	end

	oldAddBuyNode(self, techId, prereq1, prereq2, addOnTechId)
end