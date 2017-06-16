local oldResolveString = Locale.ResolveString

local modStrings = {
	SILENCE_TOOLTIP = "Make no sound while moving.",
	VAMPIRISM_TOOLTIP = "Leeches health when directly damaging enemy players.",
	REGENERATION_TOOLTIP = "Slowly heals you while not under attack.",
	DRIFTER_REGENERATION_TOOLTIP = "Drifters regenerate 3% of their hp every 2 secs while being hurt",
	DRIFTER_CELERITY_TOOLTIP = "Drifters move 18% faster"
}

function Locale.ResolveString(indexString)
	return modStrings[indexString] or oldResolveString(indexString)
end