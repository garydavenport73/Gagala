customObjects = {}

-- loops through characters and calls their update functions
function updateCustomObjects(dt)
    removeGarbage() -- new added here so it does not have to be a separate main call
    for index, object in pairs(customObjects) do
        index = index
        if object.customObjectType == 'basicExplosion' then
            stepBasicExplosions(object)
        end
        object:update(dt)
    end
end

function stepBasicExplosions(explosionObject)
        explosionObject.explosionCount = explosionObject.explosionCount + 1
        if explosionObject.explosionCount > explosionObject.durations*6*60 then --6 frames in total 60 frams per minute
            explosionObject.garbage = true
        end
end

-- loops through characters and calls their draw functions
function drawCustomObjects()
    for index, customObject in pairs(customObjects) do
        index = index
        customObject:draw()
    end
end

function objectOffScreen(object)
    if object.y > love.graphics.getHeight() or object.x >
        love.graphics.getWidth() or object.x + object:getScaleFactor() *
        object.w < 0 or object.y + object:getScaleFactor() * object.h < 0 then
        return true
    else
        return false
    end
end

function removeGarbage()
    -- print("list length before", #customObjects)
    for i = #customObjects, 1, -1 do
        if customObjects[i].garbage == true then
            -- print("removing", customObjects[i].customObjectType, "at index", i)
            local tempObject = table.remove(customObjects, i)
            tempObject = nil
        end
    end
    -- print("list length after", #customObjects)
end
--------------------------------------------------------------

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
        garbage = false,
        r = 0,
        sx = def.sx or 3,
        sy = def.sy or 3,
        customObjectType = def.type or 'notypedesignated',
        onloop = def.onloop or nil,
        explosionCount = 0
    }

    -- Set up animations
    local anim8 = require('libs/anim8')
    this.grid = anim8.newGrid(def.w, def.h, this.image:getDimensions())
    this.anim = anim8.newAnimation(this.grid(def.frames[1], def.frames[2]),
                                   this.durations, def.onloop)
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

function CustomObject:getScaleFactor() return (self.sx + self.sy) / 2.0 end

function CustomObject:setAnimation(def, durations)
    self.anim = self.newAnimation(self.grid(def.frames[1], def.frames[2]),
                                  durations)
end

function CustomObject:setOnloop(onloop) self.onloop = onloop end

function CustomObject:placeInGarbage() self.garbage = true end

function CustomObject:setType(type) self.customObjectType = type end
