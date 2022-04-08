-- Ship definition
shipDef = {
    w = 16,
    h = 24,
    image = 'assets/graphics/ship.png',
    frames = {3, '1-2'},
    weaponFeatures = {10, "standard", false, 20, 15} -- Weapon features from Weapon:addFeatures()
}

Ship = {}
Ship.__index = Ship

function Ship:Create(spawn_x, spawn_y, def)
    local this = {
        x = spawn_x,
        y = spawn_y,
        w = def.w,
        h = def.h,
        image = love.graphics.newImage(def.image),
        anim = nil,
        --
        health = 3,
        weapon = nil,
        shield = nil
    }

    -- Set up weapon
    this.weapon = Weapon:Create(this.x, this.y, 0, 0)
    this.weapon:addFeatures(def.weaponFeatures[1], def.weaponFeatures[2],
                            def.weaponFeatures[3], def.weaponFeatures[4],
                            def.weaponFeatures[5])

    -- Set up animations
    local anim8 = require('libs/anim8')
    local grid = anim8.newGrid(def.w, def.h, this.image:getDimensions())
    this.anim = anim8.newAnimation(grid(def.frames[1], def.frames[2]), 0.1)

    this.image:setFilter('nearest')
    setmetatable(this, self)
    return this
end

function Ship:update(dt)
    -- update animations
    self.anim:update(dt)
    -- handle input
    self:handleInput()
    -- update weapon
    self.weapon:update(dt)
    self.weapon.x = self.x
    self.weapon.y = self.y
end

function Ship:handleInput()
    -- movement input
    -- firing input
    if love.keyboard.isDown('space') then self.weapon:fire() end
end

function Ship:draw()
    -- draw the animation in the ship's x/y coordinate
    self.anim:draw(self.image, self.x, self.y, 0, 3, 3)
end
