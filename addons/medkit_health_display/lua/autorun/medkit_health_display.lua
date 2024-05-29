-- medkit_health_display.lua
if SERVER then
    include("autorun/server/medkit_health_display_server.lua")
    AddCSLuaFile("autorun/client/medkit_health_display_client.lua")
end

if CLIENT then
    include("autorun/client/medkit_health_display_client.lua")
end
