--Check for diabling global
if gDisableUWEBalance then return end

-- Biomass 3 research & Drifter tech
Script.Load("lua/GhoulsBalance/Hive.lua")

if AddModPanel then
	local panel = PrecacheAsset("materials/ghoulsbalancemod/panel.material")
	AddModPanel(panel, "https://ghoulofgsg9.github.io/Ghouls-Balance-Mod/")
elseif Client then
	Script.Load("lua/GhoulsBalance/changelog.lua")
end