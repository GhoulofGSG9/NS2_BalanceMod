local changeTechs = {
	[kTechId.Crush] = kTechId.ShiftHive,
	[kTechId.Vampirism] = kTechId.CragHive,
	[kTechId.Silence] = kTechId.ShadeHive,
}

local oldBuildTechData = BuildTechData
function BuildTechData()
	local techData = oldBuildTechData()

	for i = 1, #techData do
		local data = techData[i]
		if data[kTechDataId] and changeTechs[data[kTechDataId]] then
			data[kTechDataCategory] = changeTechs[data[kTechDataId]]
			techData[i] = data
		end
	end

	return techData
end