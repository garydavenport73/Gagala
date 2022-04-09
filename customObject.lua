CustomObject = {}
CustomObject.__index = CustomObject

-- def contains everything needed for animating
-- def = {w = , h = , image = 'path/to/spritesheet.png', frames = {'x1-x2', 'y1-y2'}, duration = },
function CustomObject:Create(spawn_x, spawn_y, def, xVel, yVel)
    local this = {
        x = spawn_x,
        y = spawn_y,
        w = def.w,
        h = def.h,
        xVel = xVel or 0,
        yVel = yVel or 0,
        durations = def.durations or 0.1,
        image = love.graphics.newImage(def.image),
        anim = nil,
        _garbage = false,
        r = 0,
        sx = def.scaleFactor or 1,
        sy = def.scaleFactor or 1,
        customObjectType = def.type or 'notypedesignated',
        originalXSpawn = spawn_x or 0,
        originalYSpawn = spawn_y or 0,
        flying=false,
        rebasing = false,
        waiting = true
    }

    -- Set up animations
    local anim8 = require('libs/anim8')
    this.grid = anim8.newGrid(def.w, def.h, this.image:getDimensions())
    this.anim = anim8.newAnimation(this.grid(def.frames[1], def.frames[2]), this.durations)
    this.image:setFilter('nearest')
    setmetatable(this, self)

    -- add to the end of the list of customObjects
    table.insert(customObjects, this)
    return this
end

function CustomObject:update(dt)
    self.x = self.x + self.xVel
    self.y = self.y + self.yVel
    self.anim:update(dt)
end

function CustomObject:draw()
    self.anim:draw(self.image, self.x, self.y, self.r, self.sx, self.sy)
end

function CustomObject:changeScaleFactor(scaleFactor)
    self.sx = scaleFactor
    self.sy = scaleFactor
end

function CustomObject:getScaleFactor()
    return (self.sx + self.sy)/2.0
end

function CustomObject:setAnimation(def, durations)
    self.anim = self.newAnimation(self.grid(def.frames[1], def.frames[2]), durations)
end

function CustomObject:destroySelf()
    for index, customObject in pairs(customObjects) do
        if customObject==self then
          customObject=nil
          table.remove(customObjects,index)
        end
    end
end

function CustomObject:setType(type)
    self.customObjectType = type
end
