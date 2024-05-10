local function SpawnCombineSoldier(ply)
    if not IsValid(ply) then return end
    local combine = ents.Create("npc_combine_s")
    if not IsValid(combine) then return end
    local trace = ply:GetEyeTrace()
    combine:SetPos(trace.HitPos + Vector(0, 0, 20))
    combine:SetAngles(Angle(0, ply:EyeAngles().y, 0))
    combine:SetHealth(500)
    combine:SetKeyValue("additionalequipment", "weapon_ar2")
    combine:Spawn()
    ply:ChatPrint("Combine soldier spawned!")
end

hook.Add("PlayerButtonDown", "SpawnCombineSoldierKeyPress", function(ply, button)
    if button == KEY_H then
        SpawnCombineSoldier(ply)
    end
end)
