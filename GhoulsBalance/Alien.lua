--Adjust silence to not go fully silent
local kSilenceVolumeScale = {
	-- fmod use the amplitude ratio as volume
	[0] = 1, -- 0db
	[1] = 0.5, -- -6db
	[2] = 0.32, -- -10db
	[3] = 0.1 -- -20db
}


function Alien:GetEffectParams(tableParams)

	tableParams[kEffectFilterSilenceUpgrade] = kSilenceVolumeScale[self.silenceLevel] == 0 -- for total silence
	tableParams[kEffectParamVolume] = kSilenceVolumeScale[self.silenceLevel]

end