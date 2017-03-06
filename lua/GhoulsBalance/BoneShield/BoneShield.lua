function BoneShield:OnProcessMove(input)

	if self.primaryAttacking then

		if self:GetFuel() > 0 then

			local player = self:GetParent()
			if player then

				player:AddHealth(kBoneShieldHealPerSecond * input.time, true, false, true, player)
				player:AddArmor(kBoneShieldArmorPerSecond * input.time, true, true, player)
				if Server and not self.muscuousEnabled then
					player:AddMucousShield(kBoneShieldMuscuous)
					self.muscuousEnabled = true
				end

			end

		else

			self:SetFuel( 0 )
			self.primaryAttacking = false

		end

	elseif self.muscuousEnabled then

		local player = self:GetParent()
		if player then
			player:ReoveMucousShield(kBoneShieldMuscuous)
		end

		self.muscuousEnabled = false

	end

end

