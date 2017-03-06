--Check for diabling global
if gDisableUWEBalance then return end

-- Biomass 3 research
Script.Load("lua/GhoulsBalance/BiomassThree/Hive.lua")

if AddModPanel then
	local panel = PrecacheAsset("materials/ghoulsbalancemod/panel.material")
	AddModPanel(panel, "https://ghoulofgsg9.github.io/Ghouls-Balance-Mod/")
end