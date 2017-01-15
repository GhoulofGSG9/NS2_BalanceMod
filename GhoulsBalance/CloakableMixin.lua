local kPlayerMaxCloak = 0.88
local kPlayerHideModelMin = 0
local kPlayerHideModelMax = 0.15

local kEnemyUncloakDistanceSquared = 1.5 ^ 2

local function UpdateDesiredCloakFraction(self, deltaTime)

	if Server then

		self.cloakingDesired = false

		-- Animate towards uncloaked if triggered
		if Shared.GetTime() > self.timeUncloaked and (not HasMixin(self, "Detectable") or not self:GetIsDetected()) and ( not GetConcedeSequenceActive() ) then

			-- Uncloaking takes precedence over cloaking
			if Shared.GetTime() < self.timeCloaked then
				self.cloakingDesired = true
				self.cloakRate = 3
			elseif self.GetIsCamouflaged and self:GetIsCamouflaged() then

				self.cloakingDesired = true

				if self:isa("Player") or self:isa("Babbler") then
					self.cloakRate = GetShellLevel(self:GetTeamNumber())
				else
					self.cloakRate = 3
				end

			end

		end

	end

	local newDesiredCloakFraction = self.cloakingDesired and 1 or 0

	-- Update cloaked fraction according to our speed and max speed
	if newDesiredCloakFraction == 1 and self.GetSpeedScalar then
		newDesiredCloakFraction = 1 - self:GetSpeedScalar()
	end

	if newDesiredCloakFraction ~= nil then
		self.desiredCloakFraction = Clamp(newDesiredCloakFraction, 0, (self:isa("Player") or self:isa("Drifter") or self:isa("Babbler")) and kPlayerMaxCloak or 1)
	end

end

local function UpdateCloakState(self, deltaTime)
	PROFILE("CloakableMixin:OnUpdate")
	-- Account for trigger cloak, uncloak, camouflage speed
	UpdateDesiredCloakFraction(self, deltaTime)

	-- Animate towards desired/internal cloak fraction (so we never "snap")
	local rate = (self.desiredCloakFraction > self.cloakFraction) and CloakableMixin.kCloakRate * (self.cloakRate / 3) or CloakableMixin.kUncloakRate

	local newCloak = Clamp(Slerp(self.cloakFraction, self.desiredCloakFraction, deltaTime * rate), 0, 1)

	if newCloak ~= self.cloakFraction then

		local callOnCloak = (newCloak == 1) and (self.cloakFraction ~= 1) and self.OnCloak
		self.cloakFraction = newCloak

		if callOnCloak then
			self:OnCloak()
		end

	end

	if Server then

		self.fullyCloaked = self:GetCloakFraction() >= kPlayerMaxCloak

		if self.lastTouchedEntityId then

			local enemyEntity = Shared.GetEntity(self.lastTouchedEntityId)
			if enemyEntity and (self:GetOrigin() - enemyEntity:GetOrigin()):GetLengthSquared() < kEnemyUncloakDistanceSquared then
				self:TriggerUncloak()
			else
				self.lastTouchedEntityId = nil
			end

		end

	end

end

function CloakableMixin:OnUpdate(deltaTime)
	UpdateCloakState(self, deltaTime)
end

function CloakableMixin:OnProcessMove(input)
	UpdateCloakState(self, input.time)
end

function CloakableMixin:OnProcessSpectate(deltaTime)
	UpdateCloakState(self, deltaTime)
end