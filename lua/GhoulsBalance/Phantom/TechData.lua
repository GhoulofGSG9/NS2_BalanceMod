local oldBuildTechData = BuildTechData
function BuildTechData()
    local techData = oldBuildTechData()

    for i = 1, #techData do
        local data = techData[i]
        if data[kTechDataId] == kTechId.Silence then
            data[kTechDataDisplayName] = "PHANTOM"
            data[kTechDataTooltipInfo] = "PHANTOM_TOOLTIP"
            break
        end
    end

    return techData
end