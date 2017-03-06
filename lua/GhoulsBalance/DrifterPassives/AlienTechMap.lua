do
	kAlienTechMap[#kAlienTechMap+1] = { kTechId.DrifterRegeneration, 5, 3 }
	kAlienTechMap[#kAlienTechMap+1] = { kTechId.DrifterCamouflage, 8, 3 }
	kAlienTechMap[#kAlienTechMap+1] = { kTechId.DrifterCelerity, 11, 3 }

	kAlienLines[#kAlienLines+1] = GetLinePositionForTechMap(kAlienTechMap, kTechId.CragHive, kTechId.DrifterRegeneration)
	kAlienLines[#kAlienLines+1] = GetLinePositionForTechMap(kAlienTechMap, kTechId.ShadeHive, kTechId.DrifterCamouflage)
	kAlienLines[#kAlienLines+1] = GetLinePositionForTechMap(kAlienTechMap, kTechId.ShiftHive, kTechId.DrifterCelerity)
end