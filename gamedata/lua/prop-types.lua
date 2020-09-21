#****************************************************************************
#**
#**  File     : /lua/proptree.lua
#**
#**  Summary  : Class for tree props that can burn and fall down and such
#**
#**  Copyright 2006 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local Prop = import('/lua/sim/Prop.lua').Prop
local FireEffects = import('/lua/EffectTemplates.lua').TreeBurning01
local DefaultExplosions = import('/lua/defaultexplosions.lua')
local GetRandomFloat = import('/lua/utilities.lua').GetRandomFloat

local Entity = import('/lua/sim/Entity.lua').Entity
local Unit = import('/lua/sim/Unit.lua').Unit

Collidable = Class(Prop) {

    OnCreate = function(self)

        -- construct an entity that can collide
        local spec = self:GetBlueprint()
        local collider = Entity { }

        LOG("This is self: ")
        LOG(repr(self))

        LOG("This is spec: ")
        LOG(repr(spec))

        LOG("This is collider: ")
        LOG(repr(collider))

        -- self.Motor = self.Motor or self:FallDown()
        -- self.Motor:Whack(1.0, 0, 0, 0.5, true)

        -- set the mesh
        -- collider:SetMesh(spec.Display.MeshBlueprint)
        -- collider:SetDrawScale(spec.Display.UniformScale)
        self:SetCollisionShape('None')

        -- set the collision shape
        cx = spec.CollisionOffsetX
        cy = spec.CollisionOffsetY + spec.SizeY * 0.5
        cz = spec.CollisionOffsetZ
        sx = spec.SizeX * 0.5
        sy = spec.SizeY * 0.5
        sz = spec.SizeZ * 0.5
        collider:SetCollisionShape('Box', cx, cy, cz, sx, sy, sz)

        --collider:SetMaxHealth(100000)
        --collider:SetHealth(nil, 100000)

        -- set various stats
        -- collider:SetDoNotTarget(true)
        -- collider:SetReclaimable(false);
        -- collider:SetCapturable(false);
        -- collider:SetDoNotTarget(true);
        -- collider:SetUnSelectable(true);
        -- collider:SetCanBeKilled(false);

        -- translate it
        collider:SetPosition(self:GetPosition(), true)
        collider:SetOrientation(self:GetOrientation(), true)

        collider.OnCollisionCheck = function(self, other)
            return true 
        end

        -- doesn't exist?
        LOG(repr(self.Trash))

        -- make sure it is cleaned up properly
        -- self.Trash:Add(collider)

        LOG("Created as an entity!")
    end,

    OnCollisionCheck = function(self, other)
        LOG("Check!")
        return true
    end,

    OnCollision = function(self, other, nx, ny, nz, depth)
        LOG("Boom!")
    end,

    OnDamage = function(self, instigator, armormod, direction, type)
    end,

    OnKilled = function(self)
    end,

    OnDestroy = function(self)
    end,
    

}