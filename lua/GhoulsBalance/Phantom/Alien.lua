function Alien:GetIsCamouflaged()
    return GetHasSilenceUpgrade(self) and not self:GetIsInCombat()
end