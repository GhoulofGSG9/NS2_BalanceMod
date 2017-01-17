function Alien:UpdateSilenceLevel()

	if GetHasSilenceUpgrade(self) then
		self.silenceLevel = GetVeilLevel(self:GetTeamNumber())
	else
		self.silenceLevel = 0
	end

end

