-- Define a function to create a Combine soldier with a rocket launcher
local function SpawnCombineSoldier(ply)
    if not IsValid(ply) then return end -- Check if the player is valid

    -- Create a Combine soldier entity
    local combine = ents.Create("npc_combine_s")
    if not IsValid(combine) then return end -- Check if the entity creation was successful

    -- Set the position and angles of the Combine soldier
    local trace = ply:GetEyeTrace()
    combine:SetPos(trace.HitPos + Vector(0, 0, 20)) -- Spawn the Combine soldier slightly above where the player is looking
    combine:SetAngles(Angle(0, ply:EyeAngles().y, 0)) -- Set the angles to match the player's view direction

    -- Set the health of the Combine soldier to 500
    combine:SetHealth(500)

    -- Equip the Combine soldier with a weapon (in this case, a weapon_ar2 is used)
    combine:SetKeyValue("additionalequipment", "weapon_ar2")

    -- Spawn the Combine soldier
    combine:Spawn()

    -- Notify the player that the Combine soldier was spawned
    ply:ChatPrint("Combine soldier spawned!")
end

-- Hook into the player's key press event
hook.Add("PlayerButtonDown", "SpawnCombineSoldierKeyPress", function(ply, button)
    -- Check if the key pressed is the "H" key (you can change this to any other key)
    if button == KEY_H then
        -- Call the SpawnCombineSoldier function to spawn the Combine soldier
        SpawnCombineSoldier(ply)
    end
end)
