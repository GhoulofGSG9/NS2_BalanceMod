--Check for diabling global
if gDisableUWEBalance then return end

ModLoader.SetupFileHook( "lua/Balance.lua", "lua/GhoulsBalance/BalanceAdjustments.lua", "post" )

--Boneshield Changes
ModLoader.SetupFileHook( "lua/Weapons/Alien/BoneShield.lua", "lua/GhoulsBalance/BoneShield.lua", "post" )
ModLoader.SetupFileHook( "lua/MucousableMixin.lua", "lua/GhoulsBalance/MucousableMixin.lua", "post" )

--Shotgun
ModLoader.SetupFileHook( "lua/Weapons/Marine/Shotgun.lua", "lua/GhoulsBalance/Shotgun.lua", "post" )