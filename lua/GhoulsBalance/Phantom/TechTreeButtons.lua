local kTechIdToMaterialOffset = {}

kTechIdToMaterialOffset[kTechId.UpgradeSilenceSpur] = 66
kTechIdToMaterialOffset[kTechId.SilenceSpur] = 66
kTechIdToMaterialOffset[kTechId.Silence] = 66

local oldGetMaterialXYOffset = GetMaterialXYOffset

function GetMaterialXYOffset(techId)


    local columns = 12
    local index = kTechIdToMaterialOffset[techId]

    if index then

        local x = index % columns
        local y = math.floor(index / columns)
        return x, y

    end

    return oldGetMaterialXYOffset(techId)

end