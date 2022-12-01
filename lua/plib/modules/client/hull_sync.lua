local net_ReadVector = net.ReadVector
local net_ReadEntity = net.ReadEntity
local net_ReadUInt = net.ReadUInt
local IsValid = IsValid

net.Receive('Player Server Hull - Sync', function()
    local ply = net_ReadEntity()
    if IsValid( ply ) and ply:IsPlayer() then
        local command = net_ReadUInt( 1 )
        if (command == 0) then
            ply:SetHullDuck( net_ReadVector(), net_ReadVector() )
        elseif (command == 1) then
            ply:SetHull( net_ReadVector(), net_ReadVector() )
        end
    end
end)