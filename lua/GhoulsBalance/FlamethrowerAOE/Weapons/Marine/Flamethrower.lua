Flamethrower.kConeWidth = 0.3 --0.17
Flamethrower.kDamageRadius = 2.0

function Flamethrower:BurnSporesAndUmbra(startPoint, endPoint)

    local toTarget = endPoint - startPoint
    local distanceToTarget = toTarget:GetLength()
    toTarget:Normalize()
    
    local stepLength = 2
    local burnSpent = false

    for i = 1, 5 do
    
        -- stop when target has reached, any spores would be behind
        if distanceToTarget < i * stepLength then
            break
        end
    
	    if burnSpent then
            break
		end

        local checkAtPoint = startPoint + toTarget * i * stepLength
        local spores = GetEntitiesWithinRange("SporeCloud", checkAtPoint, kSporesDustCloudRadius)
        
        local umbras = GetEntitiesWithinRange("CragUmbra", checkAtPoint, CragUmbra.kRadius)
        table.copy(GetEntitiesWithinRange("StormCloud", checkAtPoint, StormCloud.kRadius), umbras, true)
        table.copy(GetEntitiesWithinRange("MucousMembrane", checkAtPoint, MucousMembrane.kRadius), umbras, true)
        table.copy(GetEntitiesWithinRange("EnzymeCloud", checkAtPoint, EnzymeCloud.kRadius), umbras, true)
        
        local bombs = GetEntitiesWithinRange("Bomb", checkAtPoint, 1.6)
        table.copy(GetEntitiesWithinRange("WhipBomb", checkAtPoint, 1.6), bombs, true)
        
        for index, bomb in ipairs(bombs) do
			if bomb.health <= 1 then
				bomb:TriggerEffects("burn_bomb", { effecthostcoords = Coords.GetTranslation(bomb:GetOrigin()) } )
				DestroyEntity(bomb)
			else
				if bomb.TakeDamage then bomb:TakeDamage() end
			end
            burnSpent = true
        end
        
        for index, spore in ipairs(spores) do
            self:TriggerEffects("burn_spore", { effecthostcoords = Coords.GetTranslation(spore:GetOrigin()) } )
            DestroyEntity(spore)
            burnSpent = true
        end
        
        for index, umbra in ipairs(umbras) do
            self:TriggerEffects("burn_umbra", { effecthostcoords = Coords.GetTranslation(umbra:GetOrigin()) } )
            DestroyEntity(umbra)
            burnSpent = true
        end
    
    end

end

function Flamethrower:CreateFlame(player, position, normal, direction)

    -- create flame entity, but prevent spamming:
    local nearbyFlames = GetEntitiesForTeamWithinRange("Flame", self:GetTeamNumber(), position, 1.7)    

    if table.count(nearbyFlames) == 0 then
    
        local flame = CreateEntity(Flame.kMapName, position, player:GetTeamNumber())
        flame:SetOwner(player)
        
        local coords = Coords.GetTranslation(position)
        coords.yAxis = normal
        coords.zAxis = direction
        
        coords.xAxis = coords.yAxis:CrossProduct(coords.zAxis)
        coords.xAxis:Normalize()
        
        coords.zAxis = coords.xAxis:CrossProduct(coords.yAxis)
        coords.zAxis:Normalize()
        
        flame:SetCoords(coords)
        
    end

end

function Flamethrower:ApplyConeDamage(player)
    
    local eyePos  = player:GetEyePos()    
    local ents = {}


    local fireDirection = player:GetViewCoords().zAxis
    local extents = Vector(self.kConeWidth, self.kConeWidth, self.kConeWidth)
    local range = self:GetRange()
    
    local startPoint = Vector(eyePos)
    local filterEnts = {self, player}
        
    local trace = TraceMeleeBox(self, startPoint, fireDirection, extents, range, PhysicsMask.Flame, EntityFilterList(filterEnts))
        
    -- Check for spores in the way.
    if Server then
        self:BurnSporesAndUmbra(startPoint, trace.endPoint)
    end
        
    if trace.fraction ~= 1 then

        if trace.entity then

            if HasMixin(trace.entity, "Live") then
                table.insertunique(ents, trace.entity)
            end

            table.insertunique(filterEnts, trace.entity)

            local hitEntities = GetEntitiesWithMixinWithinRange("Live", trace.endPoint, Flamethrower.kDamageRadius)
            for index, entRadius in ipairs(hitEntities) do
                table.insertunique(ents, entRadius)
                table.insertunique(filterEnts, entRadius)
            end

            --Create flame below target
            if Server then
                local groundTrace = Shared.TraceRay(trace.endPoint, trace.endPoint + Vector(0, -2, 0), CollisionRep.Default, PhysicsMask.CystBuild, EntityFilterAllButIsa("TechPoint"))
                if groundTrace.fraction ~= 1 then
                    fireDirection = fireDirection * 0.55 + trace.normal
                    fireDirection:Normalize()

                    self:CreateFlame(player, groundTrace.endPoint, groundTrace.normal, fireDirection)
                end
            end

        else

            if Server then
                fireDirection = fireDirection * 0.55 + trace.normal
                fireDirection:Normalize()

                self:CreateFlame(player, trace.endPoint, trace.normal, fireDirection)
            end

        end

    end

    
    for _, ent in ipairs(ents) do
    
        if ent ~= player then
        
            local toEnemy = GetNormalizedVector(ent:GetModelOrigin() - eyePos)
            local health = ent:GetHealth()
            
            local attackDamage = kFlamethrowerDamage
            
            --[[if HasMixin( ent, "Fire" ) then
                local time = Shared.GetTime()
                if ( ent:isa("AlienStructure") or HasMixin( ent, "Maturity" ) ) and ent:GetIsOnFire() and time >= (ent.timeBurnInit + kCompoundFireDamageDelay) then
                    attackDamage = kFlamethrowerDamage + ( kFlamethrowerDamage * kCompundFireDamageScalar )
                end
            end--]]
            
            self:DoDamage( attackDamage, ent, ent:GetModelOrigin(), toEnemy )
            
            -- Only light on fire if we successfully damaged them
            if ent:GetHealth() ~= health and HasMixin(ent, "Fire") then
                ent:SetOnFire(player, self)
            end
            
            if ent.GetEnergy and ent.SetEnergy then
                ent:SetEnergy(ent:GetEnergy() - kFlameThrowerEnergyDamage)
            end
            
            --[[if Server and ent:isa("Alien") then
                ent:CancelEnzyme()
            end--]]
            
        end
    
    end

end