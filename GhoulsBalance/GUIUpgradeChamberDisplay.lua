--Todo turn locals to references in vanilla
local kUpgradeLevelFunc =
{
	GetShellLevel,
	GetSpurLevel,
	GetVeilLevel
}

-- first entry is tech id to use if the player has none of the upgrades in the list
local kIndexToUpgrades =
{
	{ kTechId.Shell, kTechId.Vampirism, kTechId.Carapace, kTechId.Regeneration },
	{ kTechId.Spur, kTechId.Crush, kTechId.Celerity, kTechId.Adrenaline },
	{ kTechId.Veil, kTechId.Silence, kTechId.Aura, kTechId.Focus },
}

local function GetTechIdToUse(playerUpgrades, categoryUpgrades)

	for i = 1, #categoryUpgrades do

		if table.contains(playerUpgrades, categoryUpgrades[i]) then
			return categoryUpgrades[i], true
		end

	end

	return categoryUpgrades[1], false

end

local kIconColor = Color( 1, 190/255, 50/255, 1 ) --kIconColors[kAlienTeamType]
function GUIUpgradeChamberDisplay:Update(deltaTime)
	PROFILE("GUIUpgradeChamberDisplay:Update")
	local player = Client.GetLocalPlayer()
	if player then

		local upgrades = player:GetUpgrades()

		for i = 1, 3 do

			local category = self.upgradeIcons[i]
			local level = kUpgradeLevelFunc[i](player:GetTeamNumber())
			local techId, upgraded = GetTechIdToUse(upgrades, kIndexToUpgrades[i])
			local alpha = (upgraded or player:isa("Commander")) and 1 or (0.25 + (1 + math.sin(Shared.GetTime() * 5)) * 0.5) * 0.75

			for upgradeLevel = 1, 3 do

				if level == 0 then

					self.upgradeIcons[i][upgradeLevel]:SetIsVisible(false)
					break

				else

					local color = Color(kIconColor.r, kIconColor.g, kIconColor.b, alpha)
					if level < upgradeLevel then

						color.r = 0
						color.g = 0
						color.b = 0
						color.a = 1

					end

					self.upgradeIcons[i][upgradeLevel]:SetTexturePixelCoordinates(unpack(GetTextureCoordinatesForIcon(techId)))
					self.upgradeIcons[i][upgradeLevel]:SetColor(color)
					self.upgradeIcons[i][upgradeLevel]:SetIsVisible(true)

				end

			end

		end

	end

end