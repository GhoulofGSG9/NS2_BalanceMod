local oldResolveString = Locale.ResolveString

local modStrings = {
	SILENCE_TOOLTIP = "Make no sound while moving.",
	VAMPIRISM_TOOLTIP = "Leeches health when directly damaging enemy players.",
	REGENERATION_TOOLTIP = "Slowly heals you while not under attack.",
	BONESHIELD_TOOLTIP = "Uses the head carapace to block most frontal attacks and grants a temporarily mucous shield."
}

function Locale.ResolveString(indexString)
	return modStrings[indexString] or oldResolveString(indexString)
end