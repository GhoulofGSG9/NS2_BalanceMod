function Alien:UpdateSilenceLevel()

	if GetHasSilenceUpgrade(self) then
		self.silenceLevel = GetVeilLevel(self:GetTeamNumber())
	else
		self.silenceLevel = 0
	end

end

function Alien:GetIsHealableOverride()
	return self:GetIsAlive() and self:AmountDamaged() > 0
end