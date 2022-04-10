Ship = {}
Ship.__index = Ship

function Ship:Create(spawn_x, spawn_y, def)
    local this = {
        x = spawn_x,
        y = spawn_y,
        w = def.w,
        h = def.h,
        image = love.graphics.newImage(def.image),
        frames = def.frames,
        anim = nil,
        facing = 'forward',
        --
        health = 3,
        weapon = {nil, nil},
        weaponInd = 1,
        shield = nil,
        sx = def.sx or 3,
        sy = def.sy or 3
    }

    -- Set up weapon 1 (never changes)
    this.weapon[1] = Weapon:Create(this.x, this.y, 0, 0)
    this.weapon[1]:addFeatures(gWeaponDefs.basic)

    -- setup weapon 2 (can change)
    this.weapon[2] = Weapon:Create(this.x, this.y, 0, 0)
    this.weapon[2]:addFeatures(def.weaponFeatures)

    -- Set up animations
    anim8 = require('libs/anim8')
    grid = anim8.newGrid(def.w, def.h, this.image:getDimensions())
    this.anim = anim8.newAnimation(grid(this.frames[1], this.frames[2]), 0.1)

    this.image:setFilter('nearest')
    setmetatable(this, self)
    return this
end

function Ship:update(dt)
    if self.facing == 'forward' then
        self.frames = {3, '1-2'}
    elseif self.facing == 'right' then
        self.frames = {5, '1-2'}
    else
        self.frames = {1, '1-2'}
    end
    self.anim = anim8.newAnimation(grid(self.frames[1], self.frames[2]), 0.1)
    -- update animations
    self.anim:update(dt)
    -- handle input
    self:handleInput()
    -- update weapon
    self.weapon[1]:update(dt)
    self.weapon[2]:update(dt)
    
    self.weapon[self.weaponInd].x = self.x
    self.weapon[self.weaponInd].y = self.y
end

function Ship:handleInput()
    -- movement input
    if love.keyboard.isDown('up') or love.keyboard.isDown('left') or love.keyboard.isDown('down') or love.keyboard.isDown('right') then
        if love.keyboard.isDown('up') then
            self.facing = 'forward'        
            self.y = clamp(self.y - 3, love.graphics.getHeight() - 200, love.graphics.getHeight() - self.h)
        end
        if love.keyboard.isDown('down') then
            self.facing = 'forward'
            self.y = clamp(self.y + 3, love.graphics.getHeight() - 200, love.graphics.getHeight() - (self.h * 3))
        end
        if love.keyboard.isDown('right') then
            self.facing = 'right'
            self.x = clamp(self.x + 3, 0, love.graphics.getWidth() - (self.w * 3))
        end
        if love.keyboard.isDown('left') then
            self.facing = 'left'
            self.x = clamp(self.x - 3, 0, love.graphics.getWidth())
        end
    else 
        self.facing = 'forward'
    end
    -- firing input
    if love.keyboard.isDown('space') then
        self.weapon[self.weaponInd]:fire()
    end
end

function Ship:draw()
    -- draw the animation in the ship's x/y coordinate
    self.anim:draw(self.image, self.x, self.y, 0, self.sx, self.sy)
end

-- Returns a value contained between 
function clamp(val, min, max)
    if val < min then
        return min
    elseif val > max then
        return max 
    else
        return val
    end
end
