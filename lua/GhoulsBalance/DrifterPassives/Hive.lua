local oldGetTechButtons = Hive.GetTechButtons
function Hive:GetTechButtons()
	local techButtons = oldGetTechButtons(self)

	local techId = self:GetTechId()
	if techId == kTechId.CragHive then
		techButtons[5] = kTechId.DrifterRegeneration
	elseif techId == kTechId.ShiftHive then
		techButtons[5] = kTechId.DrifterCelerity
	elseif techId == kTechId.ShadeHive then
		techButtons[5] = kTechId.DrifterCamouflage
	end

	return techButtons
end


