-- Define a function to clean up props and weapons dropped by NPCs
local function CleanupEntities()
    for _, ent in ipairs(ents.GetAll()) do
        -- Check if the entity is valid and is a prop or a weapon
        if IsValid(ent) and (ent:GetClass() == "prop_physics" or ent:IsWeapon()) then
            -- Check if the entity is owned by a player
            local owner = ent:GetOwner()
            if not IsValid(owner) or not owner:IsPlayer() then
                -- Remove the prop or weapon
                ent:Remove()
            end
        end
    end
end

-- Set up a timer to run the cleanup function every 10 seconds
timer.Create("EntityCleanupTimer", 10, 0, CleanupEntities)
