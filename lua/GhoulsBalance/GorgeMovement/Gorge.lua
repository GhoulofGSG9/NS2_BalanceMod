--So many locals ...
local kMass = 80
local kJumpHeight = 1.2
local kStartSlideSpeed = 8.9
local kViewOffsetHeight = 0.6
local kMaxGroundSpeed = 6
local kMaxSlidingSpeed = 14 --13
local kSlidingMoveInputScalar = 0.1
local kBuildingModeMovementScalar = 0.001
local kSlideCoolDown = 1 --1.5
local kBellySlideControl = 18

Gorge.kAirZMoveWeight = 2.5
Gorge.kAirStrafeWeight = 2.5
Gorge.kAirBrakeWeight = 0.1

local kGorgeBellyYaw = "belly_yaw"
local kGorgeLeanSpeed = 2

Gorge.kBellyFriction = 0.1
Gorge.kBellyFrictionOnInfestation = 0.039 --0.068
kBellySlideCost = 20

function Gorge:GetAirControl()
	return 6
end

function Gorge:GetAirFriction()
	return 0.2
end

function Gorge:GetMaxBackwardSpeedScalar()
	return 0.7
end

function Gorge:ModifyVelocity(input, velocity, deltaTime)

	-- Give a little push forward to make sliding useful
	if self.startedSliding then

		if self:GetIsOnGround() then

			local pushDirection = GetNormalizedVectorXZ(self:GetViewCoords().zAxis)

			local currentSpeed = math.max(0, pushDirection:DotProduct(velocity))

			local maxSpeedTable = { maxSpeed = kStartSlideSpeed }
			self:ModifyMaxSpeed(maxSpeedTable, input)

			local addSpeed = math.max(0, maxSpeedTable.maxSpeed - currentSpeed)
			local impulse = pushDirection * addSpeed

			velocity:Add(impulse)

		end

		self.startedSliding = false

	end

	if self:GetIsBellySliding() then

		local currentSpeed = velocity:GetLengthXZ()
		local prevY = velocity.y
		velocity.y = 0

		local addVelocity = self:GetViewCoords():TransformVector(input.move)
		addVelocity.y = 0
		addVelocity:Normalize()
		addVelocity:Scale(deltaTime * kBellySlideControl)

		velocity:Add(addVelocity)
		velocity:Normalize()
		velocity:Scale(currentSpeed)
		velocity.y = prevY

	end

end

function Gorge:PostUpdateMove(input, runningPrediction)

	if self:GetIsBellySliding() and self:GetIsOnGround() then

		local velocity = self:GetVelocity()

		local yTravel = self:GetOrigin().y - self.prevY
		local xzSpeed = velocity:GetLengthXZ()

		if yTravel > 0 then
			xzSpeed = xzSpeed + yTravel * -3
		else
			xzSpeed = xzSpeed + yTravel * -4
		end

		if xzSpeed < kMaxSlidingSpeed or yTravel > 0 then

			local directionXZ = GetNormalizedVectorXZ(velocity)
			directionXZ:Scale(xzSpeed)

			velocity.x = directionXZ.x
			velocity.z = directionXZ.z

			self:SetVelocity(velocity)

		end

		self.verticalVelocity = yTravel / input.time

	end

end

function Gorge:GetMovementSpecialCooldown()
	local cooldown = 0
	local timeLeft = (Shared.GetTime() - self.timeSlideEnd)

	local slideDelay = kSlideCoolDown
	if timeLeft < slideDelay then
		cooldown = 1-Clamp(timeLeft / slideDelay, 0, 1)
	end

	return cooldown
end

--Todo get rid of these local functions
local function GetIsSlidingDesired(self, input)

	if bit.band(input.commands, Move.MovementModifier) == 0 then
		return false
	end

	if self.crouching then
		return false
	end

	if not self:GetHasMovementSpecial() then
		return false
	end

	if self:GetVelocity():GetLengthXZ() < 3 or self:GetIsJumping() then

		if self:GetIsBellySliding() then
			return false
		end

	else

		local zAxis = self:GetViewCoords().zAxis
		zAxis.y = 0
		zAxis:Normalize()

		if GetNormalizedVectorXZ(self:GetVelocity()):DotProduct( zAxis ) < 0.2 then
			return false
		end

	end

	return true

end

-- Handle transitions between starting-sliding, sliding, and ending-sliding
local function UpdateGorgeSliding(self, input)

	PROFILE("Gorge:UpdateGorgeSliding")

	local slidingDesired = GetIsSlidingDesired(self, input)
	if slidingDesired and not self.sliding and self.timeSlideEnd + kSlideCoolDown < Shared.GetTime() and self:GetIsOnGround() and self:GetEnergy() >= kBellySlideCost then

		self.sliding = true
		self.startedSliding = true

		if Server then
			if (GetHasSilenceUpgrade(self) and GetVeilLevel(self:GetTeamNumber()) == 0) or not GetHasSilenceUpgrade(self) then
				self.slideLoopSound:Start()
			end
		end

		self:DeductAbilityEnergy(kBellySlideCost)
		self:PrimaryAttackEnd()
		self:SecondaryAttackEnd()

	end

	if not slidingDesired and self.sliding then

		self.sliding = false

		if Server then
			self.slideLoopSound:Stop()
		end

		self.timeSlideEnd = Shared.GetTime()

	end

	-- Have Gorge lean into turns depending on input. He leans more at higher rates of speed.
	if self:GetIsBellySliding() then

		local desiredBellyYaw = 2 * (-input.move.x / kSlidingMoveInputScalar) * (self:GetVelocity():GetLength() / self:GetMaxSpeed())
		self.bellyYaw = Slerp(self.bellyYaw, desiredBellyYaw, input.time * kGorgeLeanSpeed)

	end

end

function Gorge:HandleButtons(input)

	PROFILE("Gorge:HandleButtons")

	Alien.HandleButtons(self, input)

	UpdateGorgeSliding(self, input)

end