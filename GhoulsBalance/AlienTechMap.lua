do
	for i, field in ipairs(kAlienTechMap) do
		if field[1] == kTechId.Spores then
			kAlienTechMap[i] = {kTechId.Spores, 7, 10 }
			break
		end
	end
end