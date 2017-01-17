--Check for diabling global
if gDisableUWEBalance then return end

ModLoader.SetupFileHook( "lua/Balance.lua", "lua/GhoulsBalance/BalanceAdjustments.lua", "post" )

--Boneshield Changes
ModLoader.SetupFileHook( "lua/Weapons/Alien/BoneShield.lua", "lua/GhoulsBalance/BoneShield.lua", "post" )
ModLoader.SetupFileHook( "lua/MucousableMixin.lua", "lua/GhoulsBalance/MucousableMixin.lua", "post" )

--Silence
ModLoader.SetupFileHook( "lua/Weapons/Alien/Ability.lua", "lua/GhoulsBalance/Ability.lua", "post" )
ModLoader.SetupFileHook( "lua/Weapons/Alien/DropStructureAbility.lua", "lua/GhoulsBalance/DropStructureAbility.lua", "post" )
ModLoader.SetupFileHook( "lua/Weapons/Alien/Metabolize.lua", "lua/GhoulsBalance/Metabolize.lua", "post" )

-- Biomass 3 research
ModLoader.SetupFileHook( "lua/AlienTeam.lua", "lua/GhoulsBalance/AlienTeam.lua", "post" )
ModLoader.SetupFileHook( "lua/TeamInfo.lua", "lua/GhoulsBalance/TeamInfo.lua", "post" )
ModLoader.SetupFileHook( "lua/TechTree_Server.lua", "lua/GhoulsBalance/TechTree_Server.lua", "post" )
ModLoader.SetupFileHook( "lua/AlienTechMap.lua", "lua/GhoulsBalance/AlienTechMap.lua", "post" )

--drifter techs
ModLoader.SetupFileHook( "lua/Drifter.lua", "lua/GhoulsBalance/Drifter.lua", "post" )
ModLoader.SetupFileHook( "lua/AlienTechMap.lua", "lua/GhoulsBalance/AlienTechMap_Drifter.lua", "post" )

--Alien upgrades tech swap
ModLoader.SetupFileHook( "lua/TechTree_Server.lua", "lua/GhoulsBalance/TechTree_Server_Upgrades.lua", "post" )
ModLoader.SetupFileHook( "lua/AlienTeam.lua", "lua/GhoulsBalance/AlienTeam_Upgrades.lua", "post" )
ModLoader.SetupFileHook( "lua/AlienTechMap.lua", "lua/GhoulsBalance/AlienTechMap_Upgrades.lua", "post" )
--ModLoader.SetupFileHook( "lua/GUIUtility.lua", "lua/GhoulsBalance/GUIUtility.lua", "post" )
ModLoader.SetupFileHook( "lua/GUIUpgradeChamberDisplay.lua", "lua/GhoulsBalance/GUIUpgradeChamberDisplay.lua", "post" )
ModLoader.SetupFileHook( "lua/TechData.lua", "lua/GhoulsBalance/TechData.lua", "post" )
ModLoader.SetupFileHook( "lua/CloakableMixin.lua", "lua/GhoulsBalance/CloakableMixin.lua", "post" )
ModLoader.SetupFileHook( "lua/DamageTypes.lua", "lua/GhoulsBalance/DamageTypes.lua", "post" )
ModLoader.SetupFileHook( "lua/Alien_Server.lua", "lua/GhoulsBalance/Alien_Server.lua", "post" )