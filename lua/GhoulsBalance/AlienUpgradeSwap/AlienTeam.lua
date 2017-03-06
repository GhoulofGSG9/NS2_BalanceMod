function AlienTeam:OnUpgradeChamberDestroyed(upgradeChamber)

	if upgradeChamber:GetTechId() == kTechId.CarapaceShell then
		self.updateAlienArmor = true
	end

	-- These is a list of all tech to check when a upgrade chamber is destroyed.
	local checkForLostResearch =
	{
		[kTechId.RegenerationShell] = { "Shell", kTechId.Regeneration },
		[kTechId.CarapaceShell] = { "Shell", kTechId.Carapace },
		[kTechId.CrushShell] = { "Shell", kTechId.Vampirism },

		[kTechId.CeleritySpur] = { "Spur", kTechId.Celerity },
		[kTechId.AdrenalineSpur] = { "Spur", kTechId.Adrenaline },
		[kTechId.SilenceSpur] = { "Spur", kTechId.Crush },

		[kTechId.FocusVeil] = { "Veil", kTechId.Focus },
		[kTechId.AuraVeil] = { "Veil", kTechId.Aura },
		[kTechId.VampirismVeil] = { "Veil", kTechId.Silence }
	}

	local checkTech = checkForLostResearch[upgradeChamber:GetTechId()]
	if checkTech then

		local anyRemain = false
		for _, ent in ientitylist(Shared.GetEntitiesWithClassname(checkTech[1])) do

			-- Don't count the upgradeChamber as it is being destroyed now.
			if ent ~= upgradeChamber and ent:GetTechId() == upgradeChamber:GetTechId() then

				anyRemain = true
				break

			end

		end

		if not anyRemain then
			SendTeamMessage(self, kTeamMessageTypes.ResearchLost, checkTech[2])
		end

	end

end

function AlienTeam:OnResearchComplete(structure, researchId)

	PlayingTeam.OnResearchComplete(self, structure, researchId)

	local checkForGainedResearch =
	{
		[kTechId.RegenerationShell] = { "Shell", kTechId.Regeneration },
		[kTechId.CarapaceShell] = { "Shell", kTechId.Carapace },
		[kTechId.CrushShell] = { "Shell", kTechId.Vampirism },

		[kTechId.CeleritySpur] = { "Spur", kTechId.Celerity },
		[kTechId.AdrenalineSpur] = { "Spur", kTechId.Adrenaline },
		[kTechId.SilenceSpur] = { "Spur", kTechId.Crush },

		[kTechId.FocusVeil] = { "Veil", kTechId.Focus },
		[kTechId.AuraVeil] = { "Veil", kTechId.Aura },
		[kTechId.VampirismVeil] = { "Veil", kTechId.Silence }
	}

	local gainedResearch = checkForGainedResearch[researchId]
	if gainedResearch then
		SendTeamMessage(self, kTeamMessageTypes.ResearchComplete, gainedResearch)
	end

end