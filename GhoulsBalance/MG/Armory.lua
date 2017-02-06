function Armory:GetTechButtons(techId)

	local techButtons = nil

	techButtons = { kTechId.ShotgunTech, kTechId.MinesTech, kTechId.GrenadeTech, kTechId.None,
		kTechId.None, kTechId.None, kTechId.None, kTechId.None }

	-- Show button to upgraded to advanced armory
	if self:GetTechId() == kTechId.Armory and self:GetResearchingId() ~= kTechId.AdvancedArmoryUpgrade then
		techButtons[kMarineUpgradeButtonIndex] = kTechId.AdvancedArmoryUpgrade
	end

	return techButtons

end
