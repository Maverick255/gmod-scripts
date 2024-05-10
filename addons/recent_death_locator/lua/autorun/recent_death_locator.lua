if SERVER then
    util.AddNetworkString("RecentDeathLocation")

    hook.Add("PlayerDeath", "RecentDeathLocator", function(victim, inflictor, attacker)
        local deathLocation = victim:GetPos()
        local victimName = victim:Nick()
        net.Start("RecentDeathLocation")
        net.WriteVector(deathLocation)
        net.WriteString(victimName) 
        net.Broadcast()
        timer.Simple(15, function()
            net.Start("RecentDeathLocation")
            net.WriteVector(Vector(0, 0, 0))
            net.WriteString("")
            net.Broadcast()
        end)
    end)
end

if CLIENT then
    local deathLocations = {} 
    local deathRange = 1000 
    local deathExpirationTime = 15 

    net.Receive("RecentDeathLocation", function()
        local location = net.ReadVector()
        local victimName = net.ReadString()
        print("Received death location for:", victimName)
        deathLocations[#deathLocations + 1] = { location = location, victimName = victimName, time = CurTime() }
    end)

    hook.Add("PostDrawTranslucentRenderables", "DrawRecentDeathLocations", function(depth, skybox)
        if not skybox then
            local localPlayerPos = LocalPlayer():GetPos()
            for _, deathInfo in ipairs(deathLocations) do
                local distance = deathInfo.location:DistToSqr(localPlayerPos)
                if distance <= deathRange * deathRange and deathInfo.location ~= Vector(0, 0, 0) then
                    local pos = deathInfo.location + Vector(0, 0, 10)
                    local angle = (pos - LocalPlayer():EyePos()):Angle()
                    angle:RotateAroundAxis(angle:Forward(), 90)
                    angle:RotateAroundAxis(angle:Right(), 90)
                    cam.Start3D2D(pos, angle, 0.8)
                    draw.SimpleTextOutlined(deathInfo.victimName .. "'s Body", "DermaDefaultBold", 0, 0, Color(255, 165, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))
                    cam.End3D2D()
                end
            end
        end

        -- Clean up expired death locations
        for i = #deathLocations, 1, -1 do
            if CurTime() - deathLocations[i].time > deathExpirationTime then
                table.remove(deathLocations, i)
            end
        end
    end)
end



