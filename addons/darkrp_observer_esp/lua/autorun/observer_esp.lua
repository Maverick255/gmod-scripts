if SERVER then
    AddCSLuaFile("client/observer_esp_client.lua")
    include("server/observer_esp_server.lua")
else
    include("client/observer_esp_client.lua")
end
