Weapon = {}
Weapon.__index = Weapon

-- def = {w = , h = , image = 'path/to/spritesheet.png', frames = {'x1-x2', 'y1-y2'}}
function Weapon:Create(spawn_x, spawn_y, xVel, yVel)
    local this = {
        x = spawn_x,
        y = spawn_y,
        w = 16,
        h = 24,
        xVel = xVel or 0,
        yVel = yVel or 0,
        sx = 3,
        sy = 3,
        strength =  gWeaponDefs.basic.strength,
        type =  gWeaponDefs.basic.type,
        ammoCount = gWeaponDefs.basic.ammoCount,
        coolOffPeriodInFrames = gWeaponDefs.basic.coolOffPeriodInFrames, -- 1/2 second
        unlimitedAmmo =  gWeaponDefs.basic.unlimitedAmmo,
        bulletFrames = gWeaponDefs.basic.bulletFrames,
        bulletSpeed = gWeaponDefs.basic.bulletSpeed,
        coolCount = 0,
        cooledOff = true,
    }

    setmetatable(this, self)
    return this
end

function Weapon:update(dt)
    -- if weapon just fired, track cool off time
    if self.cooledOff == false then
        self.coolCount = self.coolCount + 1
        if self.coolCount == self.coolOffPeriodInFrames then
            self.coolCount = 0
            self.cooledOff = true
        end
    end
end

function Weapon:changeScaleFactor(scaleFactor)
    self.sx = scaleFactor
    self.sy = scaleFactor
end

function Weapon:getScaleFactor() return (self.sx + self.sy) / 2.0 end

function Weapon:addFeatures(def)
    self.strength = def.strength
    self.type = def.type
    self.unlimitedAmmo = def.unlimitedAmmo
    self.ammoCount = def.ammoCount
    self.coolOffPeriodInFrames = def.coolOffPeriodInFrames
    self.bulletFrames = def.bulletFrames
    self.bulletSpeed = def.bulletSpeed
end

function Weapon:fire()
    if self.cooledOff == true then
        if self.ammoCount > 0 then
            self.cooledOff = false
            local bulletDef = { -- definition table for the bullet
                w = 16,
                h = 16,
                image = 'assets/graphics/laser-bolts.png',
                frames = self.bulletFrames
            }
            local bulletScaleFactor = 2
            local centeredX = self.x -(bulletScaleFactor * bulletDef.w - self:getScaleFactor() * self.w) / 2
            local bullet = CustomObject:Create(centeredX, self.y, bulletDef, 0, self.bulletSpeed)
            bullet:changeScaleFactor(bulletScaleFactor)
            bullet:setType('bullet') -- just really for debugging, not needed
            if self.unlimitedAmmo == false then
                self.ammoCount = self.ammoCount - 1
            end
        end
    end
end

function Weapon:setOffScreenBulletsForRemoval()
    for index, object in ipairs(customObjects) do
        if object.customObjectType == "bullet" then
            if objectOffScreen(object) then
                object.garbage = true
            end
        end
    end
end