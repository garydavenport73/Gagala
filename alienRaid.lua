alienCounter = 0
bigAlienDef = { --definition table for the aliens
    w = 32,
    h = 32,
    image = 'assets/graphics/enemy-big.png',
    frames = {'1-2', 1},
    durations = 0.1
}

function alienRaid(minSpeed, maxSpeed, xDev, spawnFrequencyInFrames)
    local xVel = math.random(-xDev, xDev)                    -- random x velocity
    local speed = math.random(minSpeed, maxSpeed)            -- random y velocity
    local randomX = math.random(0, love.graphics.getWidth())   --random starting x position
    alienCounter = alienCounter + 1
    if alienCounter % 300 == 0 then                           --resetting every 300 frames
        alienCounter = 0
    end
    if alienCounter % spawnFrequencyInFrames == 0 then        --spawn a new alien every so many frames
        local temp = CustomObject:Create(randomX, -32, bigAlienDef, xVel, speed) --create an object
        temp:changeScaleFactor(2 * math.random() + 1)         --change alien size randomly
        temp:setType('alien')
    end
end

function upDateAlienTrajectory(dt)
    
end

