local playerShoveData = {}
local shoveAnimations = {
    ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2,
    ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST,
    ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND
}

hook.Add("PlayerButtonDown", "ShoveAction", function(ply, button)
    if button == KEY_E then
        if not playerShoveData[ply] then
            playerShoveData[ply] = { shoves = 0, lastShoveTime = 0 }
        end

        local shoveData = playerShoveData[ply]
        
        if shoveData.shoves >= 2 and CurTime() - shoveData.lastShoveTime < 3 then
            return
        end

        if CurTime() - shoveData.lastShoveTime >= 3 then
            shoveData.shoves = 0
        end

        local tr = ply:GetEyeTrace()

        if tr.Hit and IsValid(tr.Entity) and tr.Entity:IsPlayer() and tr.HitPos:Distance(ply:GetPos()) < 100 then
            local target = tr.Entity
            local randomAnim = shoveAnimations[math.random(#shoveAnimations)]
            ply:DoAnimationEvent(randomAnim)

            local pushDir = (target:GetPos() - ply:GetPos()):GetNormalized() * 150
            target:SetVelocity(pushDir + Vector(0, 0, 100))
            target:EmitSound("physics/body/body_medium_impact_soft6.wav", 75, 100)

            shoveData.shoves = shoveData.shoves + 1
            shoveData.lastShoveTime = CurTime()
        end
    end
end)
