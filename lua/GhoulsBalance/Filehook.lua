--Check for diabling global
if gDisableUWEBalance then return end

--drifter techs
ModLoader.SetupFileHook( "lua/Drifter.lua", "lua/GhoulsBalance/DrifterPassives/Drifter.lua", "post" )
ModLoader.SetupFileHook( "lua/AlienTechMap.lua", "lua/GhoulsBalance/DrifterPassives/AlienTechMap.lua", "post" )
ModLoader.SetupFileHook( "lua/Hive.lua", "lua/GhoulsBalance/DrifterPassives/Hive.lua", "post" )

--Alien upgrades tech swap
ModLoader.SetupFileHook( "lua/TechTree_Server.lua", "lua/GhoulsBalance/AlienUpgradeSwap/TechTree_Server.lua", "post" )
ModLoader.SetupFileHook( "lua/AlienTeam.lua", "lua/GhoulsBalance/AlienUpgradeSwap/AlienTeam.lua", "post" )
ModLoader.SetupFileHook( "lua/AlienTechMap.lua", "lua/GhoulsBalance/AlienUpgradeSwap/AlienTechMap.lua", "post" )
--ModLoader.SetupFileHook( "lua/GUIUtility.lua", "lua/GhoulsBalance/AlienUpgradeSwap/GUIUtility.lua", "post" )
ModLoader.SetupFileHook( "lua/GUIUpgradeChamberDisplay.lua", "lua/GhoulsBalance/AlienUpgradeSwap/GUIUpgradeChamberDisplay.lua", "post" )
ModLoader.SetupFileHook( "lua/TechData.lua", "lua/GhoulsBalance/AlienUpgradeSwap/TechData.lua", "post" )
ModLoader.SetupFileHook( "lua/DamageTypes.lua", "lua/GhoulsBalance/AlienUpgradeSwap/DamageTypes.lua", "post" )
ModLoader.SetupFileHook( "lua/Alien_Server.lua", "lua/GhoulsBalance/AlienUpgradeSwap/Alien_Server.lua", "post" )

--Vampirism changes
ModLoader.SetupFileHook( "lua/DamageTypes.lua", "lua/GhoulsBalance/Vampirism/DamageTypes.lua", "post" )

--Phantom
ModLoader.SetupFileHook( "lua/Alien.lua", "lua/GhoulsBalance/Phantom/Alien.lua", "post" )
ModLoader.SetupFileHook( "lua/TechTreeButtons.lua", "lua/GhoulsBalance/Phantom/TechTreeButtons.lua", "post" )
ModLoader.SetupFileHook( "lua/TechData.lua", "lua/GhoulsBalance/Phantom/TechData.lua", "post" )

--Silence changes
ModLoader.SetupFileHook( "lua/Weapons/Alien/Ability.lua", "lua/GhoulsBalance/Silence/Ability.lua", "post" )
ModLoader.SetupFileHook( "lua/Weapons/Alien/DropStructureAbility.lua", "lua/GhoulsBalance/Silence/DropStructureAbility.lua", "post" )
ModLoader.SetupFileHook( "lua/Weapons/Alien/Metabolize.lua", "lua/GhoulsBalance/Silence/Metabolize.lua", "post" )

--Regeneration
ModLoader.SetupFileHook( "lua/Alien_Server.lua", "lua/GhoulsBalance/Regeneration/Alien_Server.lua", "post" )
ModLoader.SetupFileHook( "lua/Balance.lua", "lua/GhoulsBalance/Regeneration/Balance.lua", "post" )

--Focus
ModLoader.SetupFileHook( "lua/Ability.lua", "lua/GhoulsBalance/Focus/Ability.lua", "post" )

--Auto select upgrades at spawn for aliens
ModLoader.SetupFileHook( "lua/Egg.lua", "lua/GhoulsBalance/SpawnWithUpgrades/Egg.lua", "post" )