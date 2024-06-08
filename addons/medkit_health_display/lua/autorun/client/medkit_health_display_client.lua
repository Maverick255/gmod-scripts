local displayDistance = 100

local allowedWeapons = {
    ["med_kit"] = true,
    ["weapon_medkit"] = true
}

local function drawHealthBar(x, y, width, height, healthPercent)
    local barWidth = math.Clamp((healthPercent / 100) * width, 0, width)
    local healthColor = Color(255 - 2.55 * healthPercent, 2.55 * healthPercent, 0, 255)

    surface.SetDrawColor(0, 0, 0, 150)
    surface.DrawRect(x, y, width, height)

    surface.SetDrawColor(healthColor)
    surface.DrawRect(x, y, barWidth, height)
end

hook.Add("HUDPaint", "DrawPlayerHealth", function()
    local ply = LocalPlayer()
    if not ply:Alive() then return end
    local weapon = ply:GetActiveWeapon()
    if not IsValid(weapon) or not allowedWeapons[weapon:GetClass()] then return end

    local trace = ply:GetEyeTrace()
    if not trace.Hit or not trace.Entity:IsPlayer() then return end

    local target = trace.Entity
    if ply:GetPos():Distance(target:GetPos()) > displayDistance then return end

    local health = target:Health()
    local maxHealth = target:GetMaxHealth()
    local healthPercent = math.Clamp((health / maxHealth) * 100, 0, 100)

    local screenPos = (target:GetPos() + Vector(0, 0, 80)):ToScreen()
    local barWidth = 100
    local barHeight = 10
    local barX = screenPos.x - barWidth / 2
    local barY = screenPos.y - barHeight / 2

    drawHealthBar(barX, barY, barWidth, barHeight, healthPercent)
end)

hook.Add("PreDrawHalos", "AddGlowToTargetedPlayers", function()
    local ply = LocalPlayer()
    if not ply:Alive() then return end
    local weapon = ply:GetActiveWeapon()
    if not IsValid(weapon) or not allowedWeapons[weapon:GetClass()] then return end

    local trace = ply:GetEyeTrace()
    if not trace.Hit or not trace.Entity:IsPlayer() then return end

    local target = trace.Entity
    if ply:GetPos():Distance(target:GetPos()) > displayDistance then return end

    local health = target:Health()
    local maxHealth = target:GetMaxHealth()
    local healthPercent = math.Clamp((health / maxHealth) * 100, 0, 100)

    local screenPos = (target:GetPos() + Vector(0, 0, 80)):ToScreen()
    local barWidth = 100
    local barHeight = 10
    local barX = screenPos.x - barWidth / 2
    local barY = screenPos.y - barHeight / 2

    local barWidthPercent = math.Clamp((healthPercent / 100) * barWidth, 0, barWidth)
    local healthColor = Color(255 - 2.55 * healthPercent, 2.55 * healthPercent, 0, 255)

    surface.SetDrawColor(0, 0, 0, 150)
    surface.DrawRect(barX, barY, barWidth, barHeight)

    surface.SetDrawColor(healthColor)
    surface.DrawRect(barX, barY, barWidthPercent, barHeight)

    local glowColor = Color(255 - 2.55 * healthPercent, 2.55 * healthPercent, 0, 255)

    halo.Add({target}, glowColor, 3, 3, 2, true, true)
end)
