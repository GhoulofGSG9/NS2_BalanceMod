function Drifter:GetIsCamouflaged()
	return self.camouflaged and self.hasCamouflage
end

if Server then
	Drifter.kRegenHealRate = 0.03

	local oldOnUpdate = Drifter.OnUpdate
	function Drifter:OnUpdate(deltaTime)
		oldOnUpdate(self, deltaTime)

		self.hasCamouflage = GetHasTech(self, kTechId.ShadeHive)
		self.hasCelerity = GetHasTech(self, kTechId.ShiftHive)
		self.hasRegeneration = GetHasTech(self, kTechId.CragHive)

		if self.hasRegeneration then

			if self:GetIsHealable() and ( not self.timeLastAlienAutoHeal or self.timeLastAlienAutoHeal + kAlienRegenerationTime <= Shared.GetTime() ) then

				self:AddHealth(self.kRegenHealRate * self:GetMaxHealth())
				self.timeLastAlienAutoHeal = Shared.GetTime()

			end

		end
	end
end

Drifter.kCelerityMoveSpeed = 13
Drifter.kMoveSpeed = 11

function Drifter:ModifyMaxSpeed(maxSpeedTable)
	if self.hasCelerity then
		maxSpeedTable.maxSpeed = maxSpeedTable.maxSpeed + 2
	end
end