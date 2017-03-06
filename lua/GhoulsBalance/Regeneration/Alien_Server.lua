--Regen doesn't heal in combat anymore
kAlienRegenerationCombatModifier = 0

function Alien:UpdateAutoHeal()

	PROFILE("Alien:UpdateAutoHeal")

	if self:GetIsHealable() and ( not self.timeLastAlienAutoHeal or self.timeLastAlienAutoHeal + kAlienRegenerationTime <= Shared.GetTime() ) then

		local healRate = 1
		local hasRegenUpgrade = GetHasRegenerationUpgrade(self)
		local shellLevel = GetShellLevel(self:GetTeamNumber())
		local maxHealth = self:GetBaseHealth()

		if hasRegenUpgrade and shellLevel > 0 then
			healRate = Clamp(kAlienRegenerationPercentage * maxHealth, kAlienMinRegeneration, kAlienMaxRegeneration) * (shellLevel/3)
		else
			healRate = Clamp(kAlienInnateRegenerationPercentage * maxHealth, kAlienMinInnateRegeneration, kAlienMaxInnateRegeneration)
		end

		if self:GetTimeLastDamageDealt() + kAlienRegenerationTime + 1 > Shared.GetTime() then
			healRate = healRate * kAlienRegenerationCombatModifier
		end

		self:AddHealth(healRate, false, false, not hasRegenUpgrade)
		self.timeLastAlienAutoHeal = Shared.GetTime()

	end

end

