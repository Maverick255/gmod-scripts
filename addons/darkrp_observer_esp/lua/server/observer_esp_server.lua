hook.Add("PlayerNoClip", "ObserverNoclipToggle", function(ply, state)
    if not ply:IsAdmin() then
        return false
    end

    if state then
        ply:SetNoDraw(true)
        ply:SetNotSolid(true)
        ply:DrawWorldModel(false)
        ply:SetNoTarget(true)
        ply:GodEnable()
    else
        ply:SetNoDraw(false)
        ply:SetNotSolid(false)
        ply:DrawWorldModel(true)
        ply:SetNoTarget(false)
        ply:GodDisable()
    end

    return true
end)
