Lerk.kFlapForce = 5
Lerk.kFlapForceForward = 8.3
Lerk.kFlapForceStrafe = 7
Lerk.kMaxSpeed = 13
Lerk.kGlideAccel = 6

local function UpdateFlap(self, input, velocity)

	local flapPressed = bit.band(input.commands, Move.Jump) ~= 0

	if flapPressed ~= self.flapPressed then

		self.flapPressed = flapPressed
		self.glideAllowed = not self:GetIsOnGround()

		if flapPressed and self:GetEnergy() > kLerkFlapEnergyCost and not self.gliding then

			-- take off
			if self:GetIsOnGround() or input.move:GetLength() == 0 then
				velocity.y = velocity.y * 0.5 + 5

			else

				local flapForce = Lerk.kFlapForce
				local move = Vector(input.move)
				move.x = move.x * 0.75
				-- flap only at 50% speed side wards

				local wishDir = self:GetViewCoords():TransformVector(move)
				wishDir:Normalize()

				-- the speed we already have in the new direction
				local currentSpeed = move:DotProduct(velocity)
				-- prevent exceeding max speed of kMaxSpeed by flapping
				local maxSpeedTable = { maxSpeed = self.kMaxSpeed }
				self:ModifyMaxSpeed(maxSpeedTable, input)

				local maxSpeed = math.max(currentSpeed, maxSpeedTable.maxSpeed)

				if input.move.z ~= 1 and velocity.y < 0 then
					-- apply vertical flap
					velocity.y = velocity.y * 0.5 + 3.8
				elseif input.move.z == 1 and input.move.x == 0 then
					-- flapping forward
					flapForce = self.kFlapForceForward
				elseif input.move.z == 0 and input.move.x ~= 0 then
					-- strafe flapping
					flapForce = self.kFlapForceStrafe
					velocity.y = velocity.y + 3.5
				end

				-- directional flap
				velocity:Scale(0.65)
				velocity:Add(wishDir * flapForce)

				if velocity:GetLengthSquared() > maxSpeed * maxSpeed then
					velocity:Normalize()
					velocity:Scale(maxSpeed)
				end

			end

			self:DeductAbilityEnergy(kLerkFlapEnergyCost)
			self.lastTimeFlapped = Shared.GetTime()
			self.onGround = false
			self:TriggerEffects("flap")

		end

	end

end

local function UpdateGlide(self, input, velocity, deltaTime)

	-- more control when moving forward
	local holdingGlide = bit.band(input.commands, Move.Jump) ~= 0 and self.glideAllowed
	if input.move.z == 1 and holdingGlide then

		local useMove = Vector(input.move)
		useMove.x = useMove.x * 0.5

		local wishDir = GetNormalizedVector(self:GetViewCoords():TransformVector(useMove))
		-- slow down when moving in another XZ direction, accelerate when falling down
		local currentDir = GetNormalizedVector(velocity)
		local glideAccel = -currentDir.y * deltaTime * self.kGlideAccel

		local maxSpeedTable = { maxSpeed = self.kMaxSpeed }
		self:ModifyMaxSpeed(maxSpeedTable, input)

		local speed = velocity:GetLength() -- velocity:DotProduct(wishDir) * 0.1 + velocity:GetLength() * 0.9
		local useSpeed = math.min(maxSpeedTable.maxSpeed, speed + glideAccel)

		-- when speed falls below 1, set horizontal speed to 1, and vertical speed to zero, but allow dive to regain speed
		if useSpeed < 4 then
			useSpeed = 4
			local newY = math.min(wishDir.y, 0)
			wishDir.y = newY
			wishDir = GetNormalizedVector(wishDir)
		end

		-- when gliding we always have 100% control
		local redirectVelocity = wishDir * useSpeed
		VectorCopy(redirectVelocity, velocity)

		self.gliding = not self:GetIsOnGround()

	else
		self.gliding = false
	end

end

local function UpdateCrouchDive(self, input, velocity, deltaTime)
	if self:GetCrouching() and not self:GetIsOnGround() then

		local vy = velocity.y
		if velocity.y > 0 then
			-- cut upwards momentum quick
			velocity.y = velocity.y - velocity.y * 5 * deltaTime
		else

			---- add some air friction at high speeds
			local maxSpeedTable = { maxSpeed = self.kMaxSpeed }
			self:ModifyMaxSpeed(maxSpeedTable, input)

			local maxSpeed = maxSpeedTable.maxSpeed * 1.5
			if velocity.y * velocity.y > maxSpeed * maxSpeed then
				-- add some high speedair friction
				velocity.y = velocity.y - velocity.y * 1.5 * deltaTime
			end

		end

	end
end

-- jetpack and exo do the same, move to utility function
local function UpdateAirStrafe(self, input, velocity, deltaTime)

	if not self:GetIsOnGround() and not self.gliding then

		-- do XZ acceleration
		local wishDir = self:GetViewCoords():TransformVector(input.move)
		wishDir.y = 0
		wishDir:Normalize()

		local maxSpeed = math.max(kAirStrafeMaxSpeed, velocity:GetLengthXZ())
		velocity:Add(wishDir * 18 * deltaTime)

		if velocity:GetLengthXZ() > maxSpeed then

			local yVel = velocity.y
			velocity.y = 0
			velocity:Normalize()
			velocity:Scale(maxSpeed)
			velocity.y = yVel

		end

	end

end

function Lerk:ModifyVelocity(input, velocity, deltaTime)

	UpdateFlap(self, input, velocity)
	UpdateAirStrafe(self, input, velocity, deltaTime)
	UpdateGlide(self, input, velocity, deltaTime)
	UpdateCrouchDive(self, input, velocity, deltaTime)

end

function Lerk:GetAirFriction()
	return 0.08
end