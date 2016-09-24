--Check for diabling global
if gDisableUWEBalance then return end

ModLoader.SetupFileHook( "lua/Balance.lua", "lua/GhoulsBalance/BalanceAdjustments.lua", "post" )
ModLoader.SetupFileHook( "lua/Weapons/Alien/BoneShield.lua", "lua/GhoulsBalance/BoneShield.lua", "post" )
ModLoader.SetupFileHook( "lua/MucousableMixin.lua", "lua/GhoulsBalance/MucousableMixin.lua", "post" )