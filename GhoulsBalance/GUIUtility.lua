local oldGetLinePositionForTechMap = GetLinePositionForTechMap
function GetLinePositionForTechMap(techMap, fromTechId, toTechId)
	local changeTechs = {
		[kTechId.Crush] = kTechId.Spur,
		[kTechId.Vampirism] = kTechId.Shell,
		[kTechId.Silence] = kTechId.Veil,
	}

	if changeTechs[toTechId] then
		fromTechId = changeTechs[toTechId]
	end

	return oldGetLinePositionForTechMap(techMap, fromTechId, toTechId)
end

