Weapon = {}
Weapon.__index = Weapon

--def = {w = , h = , image = 'path/to/spritesheet.png', frames = {'x1-x2', 'y1-y2'}}
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
        strength = 10,
        type = 'standard',
        ammoCount = 100,
        coolOffPeriodInFrames = 30, -- 1/2 second
        coolCount = 0,
        cooledOff = true,
        unlimitedAmmo = true
    }

    setmetatable(this, self)
    return this
end

function Weapon:update(dt)
    --self.x = self.x + self.xVel
    --self.y = self.y + self.yVel

    --if weapon just fired, track cool off time
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

function Weapon:getScaleFactor()
    return (self.sx + self.sy) / 2.0
end

function Weapon:addFeatures(strength, type, unlimitedAmmo, ammoCount, coolOffPeriodInFrames)
    self.strength = strength
    self.type = type
    self.unlimitedAmmo = unlimitedAmmo
    self.ammoCount = ammoCount
    self.coolOffPeriodInFrames = coolOffPeriodInFrames
end

function Weapon:fire()
    print(" ")
    print("Weapon info")
    print("---------------------------------------")
    print("Weapon fired - Before firing:")
    print("CooledOff", self.cooledOff, "ammoCount", self.ammoCount, "unlimitedAmmo", self.unlimitedAmmo)
    if self.cooledOff == true then
        if self.ammoCount > 0 then
            self.cooledOff = false
            if self.type == "yourType" then
                print("yourType weapon chosen")
                --your code here
            elseif self.type == "someoneElsesType" then
                print("someoneElsesType weapon chosen")
                --your code here
            else
                self.type = "standard"
                print("Standard Weapon Chosen")
                local bulletDef = { --definition table for the bullet
                    w = 16,
                    h = 16,
                    image = 'assets/graphics/laser-bolts.png',
                    frames = {'1-2', 1},
                }
                local bulletScaleFactor = 2
                local centeredX = self.x - (bulletScaleFactor * bulletDef.w - self:getScaleFactor() * self.w) / 2
                bullet = CustomObject:Create(centeredX, self.y, bulletDef, 0, -10)
                bullet:changeScaleFactor(bulletScaleFactor)
                bullet:setType('bullet') -- just really for debugging, not needed
            end
            if self.unlimitedAmmo == false then
                self.ammoCount = self.ammoCount - 1
            end
        end
    end
    print("After firing:")
    print("CooledOff", self.cooledOff, "ammoCount", self.ammoCount, "unlimitedAmmo", self.unlimitedAmmo)
end

