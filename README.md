# Ghouls Balance Mod

**SteamWorks Mod ID**: *2dd47a50*

This mod contains various prototype balance changes based on various ideas of the NS2 balance team.

Current changes:

- Marines
    - Shotgun
        - Reduced the amount of pellets the shotgun fires with each shot to 13 (from 17)
        - Increased the base damage of each pellet to 12 ( from 10)
            - These changes lower the possible total base damage of the shotgun to 156/shot (from 170/shot)

- Aliens
    - Upgrades
        - Autoselect upgrades at spawn
            - At spawn previously selected upgrades will be reapplied if they are still available.
            - In case the player hasn't selected an upgrade for an available trait yet a random one will be applied at spawn. 
            
        - Silence
            - Silence no longer affects any "attack" sounds
            - Requieres now a Shade Hive (instead of a Shift Hive)
            
        - Vampirism
            - Requires now a Crag Hive (instead of a Shade Hive)
            - Doesn't cloak anymore
            - Rebalanced health gain values (for each shell):
                - Skulk: 5 (from 5)
                - Gorge: 6 (from 5)
                - Lerk (Bite): 5 (from 3)
                - Lerk (Spike): 2 (from 0.66)
                - Fade: 12 (from 6.66)
                - Onos: 20 (from  13.33)
            - If Focus is selected Vampirism will heal additional 33% to compensate for the longer attack cooldowns.
        
        - Alien Regeneration
            - Alien Regeneration (both the upgrade and the natural one) doesn't restore health if you have been hurt less than 3 seconds ago.
        
        - Regeneration 
            - Increased amount of hp regen restores every 2 secs to 4% (from 2%) of the base hp for each shell.
            
        - Crush
            - Requires now a Shift Hive (instead of a Crag Hive)
            
    - PvE
        - Hive
            - Each Hive can now gain up to 4 Biomass
                 - The 4th biomass costs 60 team ressources and takes 60 seconds to research.
        - Drifter 
            - Added passive abilities for each hive type:
                - Camouflage (Shade Hive): Drifters turn invisble when they idle.
                - Regeneration (Crag Hive): Drifter regenerate 3% of their hp every 2 secs while being hurt.
                - Celerity (Shift Hive): Drifters move 18% faster.
                          
        - Contamination
            - Contamination doesn't spew bile bombs after being set on fire.

Code @ Github: https://github.com/GhoulofGSG9/Ghouls-Balance-Mod

Feel free to leave feedback ;)
