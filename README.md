# Ghouls Balance Mod

**SteamWorks Mod ID**: *2dd47a50*

This mod contains various prototype balance changes based on various ideas of the NS2 balance team.

Current changes:

- Marines
    - Shotgun
        - Increased the Shotgun research time to 60 seconds (from 30).
        - Reduced the amount of pellets the shotgun fires with each shot to 13 (from 17)
        - Increased the base damage of each pellet to 12 ( from 10)
            - These changes lower the possible total base damage of the shotgun to 156/shot (from 170/shot)

- Aliens
    - Upgrades
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
            
        - Focus
            - The extra cooldown is not changing with the veil level anymore and instead static 33%.
    - Lifeforms
        - Onos 
            - Boneshield doesn't heal armor anymore and instead grants a mucous shield of 400 hp while being used.
            
        - Fade
            - Pres cost increased to 37 (from 35)
            
        - Gorge
            - Movement / Belly Slide
                - Give players more control over belly slide and make it slightly faster:
                    - Increased max belly sliding speed to 14, from 13.
                    - Decreased belly slide cooldown from 1.5 to 1 second.
                    - Reduced slide friction on infestation from 0.068 to 0.039.
                    - Reduced slide energy cost from 25 to 20.
                    - Increased belly slide control from 10 to 18.                
                    - Speed loss sliding uphill is reduced by 25%.
                - Decreased the air friction from 0.8 to 0.2 so the Gorge doesn't move like a brick while jumping.
            - Bilebomb
                - Decreased the tickrate of the bile damage to 2/sec (from 2.5/sec) and lowered the damage that way to 110/sec (from 137.5/sec)
    - PvE
        - Alien Structures
            -  Increased the alien structures autogrowth to 50% (form 33%) of their normal (with drifter) growth rate.        
        - Hive
            - Added a Biomasss 3 research tech
                - Costs 60 tres and takes 60 sec to research                        
        - Harvester
            - Decreased growth time to 28 secs (from 38 secs)
        - Cyst
            - Increase maturity time to 120 seconds (from 45)
            
        - Drifter 
            - Added passive abilities for each hive type:
                - Camouflage (Shade Hive): Drifters turn invisble when they idle.
                - Regeneration (Crag Hive): Drifter regenerate 3% of their hp every 2 secs while being hurt.
                - Celerity (Shift Hive): Drifters move 18% faster.
                          
        - Contamination
            - Disables bile bombs when the Contamination is set on fire.

Code @ Github: https://github.com/GhoulofGSG9/Ghouls-Balance-Mod

Feel free to leave feedback ;)
