local networkVars = {}
AddMixinNetworkVars(GameEffectsMixin, networkVars)
AddMixinNetworkVars(FireMixin, networkVars)

local oldOnCreate = Contamination.OnCreate
function Contamination:OnCreate()
	oldOnCreate(self)

	InitMixin(self, GameEffectsMixin)
	InitMixin(self, FireMixin)
end

local function SineFalloff( distanceFraction )
	local piFraction = Clamp(distanceFraction, 0, 1) * math.pi / 2
	return math.cos(piFraction + math.pi) + 1
end

local function SpewBile( self )

	if not self:GetIsAlive() or self:GetIsOnFire() or kContaminationBileSpewCount < 1 then
		return false
	end

	self.bileEmitCount = self.bileEmitCount + 1

	local dotMarker = CreateEntity( DotMarker.kMapName, self:GetOrigin(), self:GetTeamNumber() )
	dotMarker:SetDamageType( kBileBombDamageType )
	dotMarker:SetLifeTime( kBileBombDuration )
	dotMarker:SetDamage( kBileBombDamage )
	dotMarker:SetRadius( kBileBombSplashRadius )
	dotMarker:SetDamageIntervall( kBileBombDotInterval )
	dotMarker:SetDotMarkerType( DotMarker.kType.Static )
	dotMarker:SetTargetEffectName( "bilebomb_onstructure" )
	dotMarker:SetDeathIconIndex( kDeathMessageIcon.BileBomb )
	dotMarker:SetOwner( self:GetOwner() )
	dotMarker:SetFallOffFunc( SineFalloff )
	dotMarker:TriggerEffects( "bilebomb_hit" )

	return self.bileEmitCount < kContaminationBileSpewCount

end

local oldAddTimedCallback = Contamination.AddTimedCallback
function Contamination:AddTimedCallback(callback, interval, early)
	if interval == kTechId.ResearchBioMassThree then
		callback = SpewBile
	end

	return oldAddTimedCallback(self, callback, interval, early)
end

Shared.LinkClassToMap("Contamination", nil, networkVars)