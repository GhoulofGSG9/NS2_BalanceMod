--Check for diabling global
if gDisableUWEBalance then return end

--Boneshield Changes
ModLoader.SetupFileHook( "lua/Weapons/Alien/BoneShield.lua", "lua/GhoulsBalance/BoneShield/BoneShield.lua", "post" )
ModLoader.SetupFileHook( "lua/MucousableMixin.lua", "lua/GhoulsBalance/BoneShield/MucousableMixin.lua", "post" )
ModLoader.SetupFileHook( "lua/Balance.lua", "lua/GhoulsBalance/BoneShield/Balance.lua", "post" )

--Silence
ModLoader.SetupFileHook( "lua/Weapons/Alien/Ability.lua", "lua/GhoulsBalance/Silence/Ability.lua", "post" )
ModLoader.SetupFileHook( "lua/Weapons/Alien/DropStructureAbility.lua", "lua/GhoulsBalance/Silence/DropStructureAbility.lua", "post" )
ModLoader.SetupFileHook( "lua/Weapons/Alien/Metabolize.lua", "lua/GhoulsBalance/Silence/Metabolize.lua", "post" )

-- Biomass 3 research
ModLoader.SetupFileHook( "lua/Hive.lua", "lua/GhoulsBalance/BiomassThree/Hive.lua", "post" )
ModLoader.SetupFileHook( "lua/TeamInfo.lua", "lua/GhoulsBalance/BiomassThree/TeamInfo.lua", "post" )
ModLoader.SetupFileHook( "lua/Balance.lua", "lua/GhoulsBalance/BiomassThree/Balance.lua", "post" )
ModLoader.SetupFileHook( "lua/AlienTeam.lua", "lua/GhoulsBalance/BiomassThree/AlienTeam.lua", "post" )

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
ModLoader.SetupFileHook( "lua/Alien.lua", "lua/GhoulsBalance/Vampirism/Alien.lua", "post" )
ModLoader.SetupFileHook( "lua/DamageTypes.lua", "lua/GhoulsBalance/Vampirism/DamageTypes.lua", "post" )

--Contamination
ModLoader.SetupFileHook( "lua/CommAbilities/Alien/Contamination.lua", "lua/GhoulsBalance/Contamination/Contamination.lua", "post" )

--Alien Autobuild
ModLoader.SetupFileHook( "lua/Balance.lua", "lua/GhoulsBalance/Autobuild/Balance.lua", "post" )

--Regeneration
ModLoader.SetupFileHook( "lua/Alien_Server.lua", "lua/GhoulsBalance/Regeneration/Alien_Server.lua", "post" )
ModLoader.SetupFileHook( "lua/Balance.lua", "lua/GhoulsBalance/Regeneration/Balance.lua", "post" )

--Focus
ModLoader.SetupFileHook( "lua/Ability.lua", "lua/GhoulsBalance/Focus/Ability.lua", "post" )

--Improved Gorge Movement
ModLoader.SetupFileHook( "lua/Gorge.lua", "lua/GhoulsBalance/GorgeMovement/Gorge.lua", "post" )

--Shotgun Light Damage (Reduced pallets and longer research)
ModLoader.SetupFileHook( "lua/Balance.lua", "lua/GhoulsBalance/ShotgunLight/Balance.lua", "post" )

--Onos Speed Change
ModLoader.SetupFileHook( "lua/Onos.lua", "lua/GhoulsBalance/OnosSpeed/Onos.lua", "post" )

--Fade Init Timing fix
ModLoader.SetupFileHook( "lua/Balance.lua", "lua/GhoulsBalance/FadePRes/Balance.lua", "post" )

--Auto select upgrades at spawn for aliens
ModLoader.SetupFileHook( "lua/Egg.lua", "lua/GhoulsBalance/SpawnWithUpgrades/Egg.lua", "post" )