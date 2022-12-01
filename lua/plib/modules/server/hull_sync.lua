util.AddNetworkString( 'Player Server Hull - Sync' )

local net_WriteEntity = net.WriteEntity
local net_WriteVector = net.WriteVector
local net_Broadcast = net.Broadcast
local net_WriteUInt = net.WriteUInt
local net_Start = net.Start
local ArgAssert = ArgAssert

local PLAYER = FindMetaTable( 'Player' )

PLAYER.SourceSetHullDuck = PLAYER.SourceSetHullDuck or PLAYER.SetHullDuck
function PLAYER:SetHullDuck( mins, maxs )
    ArgAssert( mins, 1, 'vector' )
    ArgAssert( maxs, 2, 'vector' )

    if (mins[3] > 0) then return end
    if (maxs[3] <= 0) then return end

    net_Start( 'Player Server Hull - Sync' )
        net_WriteEntity( self )
        net_WriteUInt( 0, 1 )
        net_WriteVector( mins )
        net_WriteVector( maxs )
    net_Broadcast()

    self:SourceSetHullDuck( mins, maxs )
end

PLAYER.SourceSetHull = PLAYER.SourceSetHull or PLAYER.SetHull
function PLAYER:SetHull( mins, maxs )
    ArgAssert( mins, 1, 'vector' )
    ArgAssert( maxs, 2, 'vector' )

    if (mins[3] > 0) then return end
    if (maxs[3] <= 0) then return end

    net_Start( 'Player Server Hull - Sync' )
        net_WriteEntity( self )
        net_WriteUInt( 1, 1 )
        net_WriteVector( mins )
        net_WriteVector( maxs )
    net_Broadcast()

    self:SourceSetHull( mins, maxs )
end
