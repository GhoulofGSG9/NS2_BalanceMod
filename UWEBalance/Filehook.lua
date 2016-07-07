--Check for diabling global
if gDisableUWEBalance then return end

ModLoader.SetupFileHook( "lua/Balance.lua", "lua/UWEBalance/BalanceAdjustments.lua", "post" )