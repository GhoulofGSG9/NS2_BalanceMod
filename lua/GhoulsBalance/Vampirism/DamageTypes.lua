kLifeformVampirismScalars = {} --FIXME change to Weapon/Doer classnames, not lifeform
kLifeformVampirismScalars["Skulk"] = 14
kLifeformVampirismScalars["Gorge"] = 18
kLifeformVampirismScalars["LerkBite"] = 15
kLifeformVampirismScalars["LerkSpikes"] = 6
kLifeformVampirismScalars["Fade"] = 36
kLifeformVampirismScalars["Onos"] = 60

function NS2Gamerules_GetAlienVampiricLeechFactor( attacker, doer, damageType, veilLevel )

	local leechFactor = 0
	local attackerClass = attacker:GetClassName()
	local doerClassName = doer:GetClassName()

	if attackerClass == "Lerk" then

		attackerClass = doerClassName

		if attackerClass == "SporeCloud" then
			return 0
		end

		--Note: this will need to be adjusted should Lerk Spikes damage type ever change
		if attackerClass == "LerkBite" and damageType == kDamageType.Puncture then --Spikes
			attackerClass = "LerkSpikes"
		end

	elseif attackerClass == "Gorge" then
		if doerClassName == "DotMarker" or doerClassName == "Babbler" or doerClassName == "Hydra" or damageType == kDamageType.Biological then
			return 0
		end
	elseif attackerClass == "Onos" and doerClassName == "Shockwave" then
		return 0
	elseif attackerClass == "Skulk" and ( doerClassName == "Parasite" or doerClassName == "XenocideLeap" )then
		return 0
	end

	local baseLeechAmount = kLifeformVampirismScalars[attackerClass]
	if baseLeechAmount ~= nil and type(baseLeechAmount) == "number" then
		leechFactor = baseLeechAmount * ( veilLevel * kAlienVampirismHealingScalarPerLevel )
	end

	if attacker:GetHasUpgrade( kTechId.Focus ) then
		leechFactor = leechFactor * (1 + kFocusAttackSlowAtMax)
	end

	return leechFactor

end