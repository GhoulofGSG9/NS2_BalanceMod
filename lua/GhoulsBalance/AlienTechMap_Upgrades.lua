local changeTechs = {
	[kTechId.Crush] = { kTechId.Crush, 9, 5 },
	[kTechId.Vampirism] = { kTechId.Vampirism, 3, 5 },
	[kTechId.Silence] = { kTechId.Silence, 7, 5 },
}

for i, field in ipairs(kAlienTechMap) do
	local changeTech = changeTechs[field[1]]
	if changeTech then
		kAlienTechMap[i] = changeTech
	end
end
