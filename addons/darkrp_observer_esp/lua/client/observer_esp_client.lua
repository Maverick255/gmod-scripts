CreateClientConVar("observer_esp", 1, true, true, "Toggle basic ESP functionality.")
CreateClientConVar("observer_esp_advanced", 1, true, true, "Toggle advanced ESP (lines and boxes).")

hook.Add("HUDPaint", "DrawObserverESP", function()
    local client = LocalPlayer()

    if client:IsAdmin() and client:GetMoveType() == MOVETYPE_NOCLIP then
        local sx, sy = ScrW(), ScrH()
        local dimDistance = 1024

        for _, ply in ipairs(player.GetAll()) do
            if ply == client then continue end

            local scrPos = ply:GetPos():ToScreen()
            local margin = math.min(sx, sy) * 0.1
            local x, y = math.Clamp(scrPos.x, margin, sx - margin), math.Clamp(scrPos.y, margin, sy - margin)
            local teamColor = team.GetColor(ply:Team())
            local distance = client:GetPos():Distance(ply:GetPos())
            local factor = 1 - math.Clamp(distance / dimDistance, 0, 1)
            local size = math.max(10, 32 * factor)
            local alpha = math.Clamp(255 * factor, 80, 255)

            surface.SetDrawColor(teamColor.r, teamColor.g, teamColor.b, alpha)
            if GetConVar("observer_esp_advanced"):GetBool() then
                surface.DrawLine(sx * 0.5, sy * 0.5, x, y)
                surface.DrawRect(x - size / 2, y - size / 2, size, size)
            end

            draw.SimpleText(ply:Nick(), "DermaDefault", x, y - size, ColorAlpha(teamColor, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end)
