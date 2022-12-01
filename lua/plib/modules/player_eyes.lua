local isnumber = isnumber
local ismatrix = ismatrix
local istable = istable

local ENTITY = FindMetaTable( 'Entity' )

module( 'player_eyes' )

function HeadPos( ply )
    local head = ply:LookupBone( 'ValveBiped.Bip01_Head1' )
    if isnumber( head ) and (head >= 0) then
        local headPos = ply:GetBonePosition( head )
        if (headPos == ply:GetPos()) then
            local matrix = ply:GetBoneMatrix( head )
            if ismatrix( matrix ) then
                headPos = matrix:GetTranslation()
            end
        end

        return headPos
    end
end

function GetEyes( ply )
    local eyes = ply:LookupAttachment( 'eyes' )
    if (eyes > 0) then
        local attachmet = ply:GetAttachment( eyes )
        if istable( attachmet ) then
            return attachmet
        end
    end
end

function EyePos( ply, default )
    local eyes = GetEyes( ply )
    if (eyes) then
        return eyes.Pos
    end

    local headPos = HeadPos( ply )
    if (headPos) then
        return headPos
    end

    if (default) then
        return default
    end

    return ENTITY.EyePos( ply )
end

function EyeAngles( ply, default )
    local eyes = GetEyes()
    if (eyes) then
        return eyes.Ang
    end

    if (default) then
        return default
    end

    return ENTITY.EyeAngles( ply )
end