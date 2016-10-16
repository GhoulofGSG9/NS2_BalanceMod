--Silence no longer affects ability sounds
function Ability:GetEffectParams(tableParams)
	if not self.GetApplySilence or not self:GetApplySilence() then return end

	local player = self:GetParent()
	if player then
		local silenceLevel = player.silenceLevel or 0
		tableParams[kEffectFilterSilenceUpgrade] = silenceLevel == 3
		tableParams[kEffectParamVolume] = 1 - Clamp(silenceLevel / 3, 0, 1)
	end

end
