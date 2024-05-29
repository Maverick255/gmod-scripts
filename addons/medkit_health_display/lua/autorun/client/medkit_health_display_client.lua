-- medkit_health_display_client.lua

local maxDisplayDistance = 200 -- Maximum distance to display the health percentage
local allowedWeapons = {
    ["med_kit"] = true,
    ["weapon_medkit"] = true
}

hook.Add("HUDPaint", "DrawTargetHealthPercentage", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    if not ply:Alive() then return end

    local wep = ply:GetActiveWeapon()
    if not IsValid(wep) or not allowedWeapons[wep:GetClass()] then return end

    local trace = ply:GetEyeTrace()
    if not trace.Hit or not IsValid(trace.Entity) or not trace.Entity:IsPlayer() then return end

    local target = trace.Entity
    local distance = ply:GetPos():Distance(target:GetPos())
    if distance > maxDisplayDistance then return end

    local health = target:Health()
    local maxHealth = target:GetMaxHealth()
    local healthPercentage = (health / maxHealth) * 100

    local color
    if healthPercentage > 75 then
        color = Color(0, 255, 0) -- Green
    elseif healthPercentage > 50 then
        color = Color(255, 255, 0) -- Yellow
    elseif healthPercentage > 25 then
        color = Color(255, 165, 0) -- Orange
    else
        color = Color(255, 0, 0) -- Red
    end

    local screenPos = target:EyePos():ToScreen()
    draw.SimpleText(string.format("Health: %.0f%%", healthPercentage), "Trebuchet24", screenPos.x, screenPos.y - 50, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)
