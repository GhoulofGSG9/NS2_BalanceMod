local kMaxShield = 1000

MucousableMixin.networkVars =
{
	mucousShield = "boolean",
	shieldRemaining = string.format("float (0 to %f by 1)", kMaxShield)
}

function MucousableMixin:__initmixin()

	self.mucousShield = false
	self.shieldRemaining = 0
	self.lastMucousShield = 0
	self.forcedAmount = 0

end

function MucousableMixin:GetMaxShieldAmount()
	return math.floor(math.min(self:GetBaseHealth() * kMucousShieldPercent, kMaxShield) + self.forcedAmount)
end

local function SharedUpdate(self)
	if Server then
		self.mucousShield = (self.forceShield or self.lastMucousShield + kMucousShieldDuration >= Shared.GetTime()) and self.shieldRemaining > 0
		if not self.mucousShield then
			self.shieldRemaining = 0
		end
	end
end

function MucousableMixin:OnProcessMove(input)
	SharedUpdate(self)
end

if Server then
	function MucousableMixin:AddMucousShield(amount)
		if amount <= 0 then return end

		self.mucousShield = true
		self.shieldRemaining = self.shieldRemaining + amount
		self.forcedAmount = self.forcedAmount + amount
		self.forceShield = true
	end

	function MucousableMixin:ReoveMucousShield(amount)
		if amount <= 0 then return end

		self.shieldRemaining = math.max(self.shieldRemaining - amount, 0)
		self.forcedAmount = math.max(self.forcedAmount - amount, 0)

		self.forceShield = false
	end
end