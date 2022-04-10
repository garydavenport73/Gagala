aliens = {
    bigAlienDef = {
        w = 32,
        h = 32,
        image = 'assets/graphics/enemy-big.png',
        frames = {'1-2', 1},
        durations = 0.1,
        type = 'bigAlien',
        scaleFactor = 2,
        sx = 2,
        sy = 2
    }
}

function loadAliens(level, formation)

    for index, alien in pairs(customObjects) do
        if alien.customObjectType == 'bigAlien' then alien.garbage = true end
    end
    -- customObjects = {}
    removeGarbage()
    formation = formation or "circle"
    print("starting level", level)
    if formation == 'rectangle' then
        local numberOfColumns = 8
        local widthDifference = love.graphics.getWidth() - numberOfColumns *
                                    aliens.bigAlienDef.scaleFactor *
                                    aliens.bigAlienDef.w
        local margin = widthDifference / 2
        for i = 1, 3, 1 do
            for j = 1, numberOfColumns, 1 do
                local tempObject = CustomObject:Create((j - 1) *
                                                           aliens.bigAlienDef
                                                               .scaleFactor *
                                                           aliens.bigAlienDef.w +
                                                           margin, i *
                                                           aliens.bigAlienDef
                                                               .scaleFactor *
                                                           aliens.bigAlienDef.h,
                                                       aliens.bigAlienDef, 0, 0)
                tempObject["flying"] = false -- adding these new custom properties
                tempObject["rebasing"] = false --
                tempObject["waiting"] = true --
                tempObject["originalXSpawn"] = tempObject.x
                tempObject["originalYSpawn"] = tempObject.y

            end
        end

    elseif formation == 'circle' then

        for i = 1, 24, 1 do
            local radius = 0.25 * love.graphics.getWidth()
            local centerX = love.graphics.getWidth() / 2 - aliens.bigAlienDef.w
            print(aliens.bigAlienDef.w)
            -- local centerY = love.graphics.getWidth()-aliens.bigAlienDef.w

            print('radius', radius)

            local tempObject = CustomObject:Create(radius *
                                                       math.sin(i * 15 / 57.3) +
                                                       centerX, radius *
                                                       math.cos(i * 15 / 57.3) +
                                                       radius,
                                                   aliens.bigAlienDef, 0, 0)

            tempObject["flying"] = false -- adding these new custom properties
            tempObject["rebasing"] = false --
            tempObject["waiting"] = true --
            tempObject["originalXSpawn"] = tempObject.x
            tempObject["originalYSpawn"] = tempObject.y

        end

    elseif formation == 'weirdformation' then

        for i = 1, 18, 1 do
            local radius = 0.25 * love.graphics.getWidth()
            local centerX = love.graphics.getWidth() / 2 - aliens.bigAlienDef.w
            -- local centerY = love.graphics.getWidth()-aliens.bigAlienDef.w

            print('radius', radius)

            local tempObject = CustomObject:Create(radius *
                                                       math.sin(i * 15 / 57.3) +
                                                       centerX, radius *
                                                       math.cos(i * 20 / 57.3) +
                                                       radius,
                                                   aliens.bigAlienDef, 0, 0)
            tempObject["flying"] = false -- adding these new custom properties
            tempObject["rebasing"] = false --
            tempObject["waiting"] = true --
            tempObject["originalXSpawn"] = tempObject.x
            tempObject["originalYSpawn"] = tempObject.y
        end

    elseif formation == 'sformation' then

        for i = 1, 18, 1 do
            local radius = 0.25 * love.graphics.getWidth()
            local centerX = love.graphics.getWidth() / 2 - aliens.bigAlienDef.w
            -- local centerY = love.graphics.getWidth()-aliens.bigAlienDef.w

            print('radius', radius)

            local tempObject = CustomObject:Create(radius *
                                                       math.sin(i * 20 / 57.3) +
                                                       centerX, radius *
                                                       math.cos(i * 10 / 57.3) +
                                                       radius,
                                                   aliens.bigAlienDef, 0, 0)
            tempObject["flying"] = false -- adding these new custom properties
            tempObject["rebasing"] = false --
            tempObject["waiting"] = true --
            tempObject["originalXSpawn"] = tempObject.x
            tempObject["originalYSpawn"] = tempObject.y
        end

    end

    for index, alien in pairs(customObjects) do
        if alien.customObjectType == 'bigAlien' then
            alien.x = love.graphics.getWidth()
            alien.flying = false
            alien.rebasing = true
            alien.waiting = false
            alien.y = 0
            alien.x = math.random(love.graphics.getWidth() / 2,
                                  love.graphics.getWidth())
            alien.xVel = 0
            alien.yVel = 0
        end
    end
end

function upDateGagalaAliensTrajectories()
    -- loop through all aliens
    for index, alien in pairs(customObjects) do
        if alien.customObjectType == 'bigAlien' then

            if alien.waiting == true and alien.flying == false and
                alien.rebasing == false then
                -- if alien is waiting, no flying, not rebasing
                if math.random(1, 1000) < 10 then
                    xDev = math.random(-2, 2)
                    ySpeed = math.random(1, 5)
                    alien.xVel = xDev + math.random(-1, 1)
                    alien.yVel = ySpeed
                    alien.flying = true
                    alien.waiting = false
                    alien.rebasing = false
                end

                --     check for random
                --         launch
                --         waiting false
                --         flying true
                --         rebasing false   
            end
            if alien.waiting == false and alien.flying == true and
                alien.rebasing == false then

                local currentX = alien.x
                local newXVel = alien.xVel + math.random(-1, 1) /
                                    math.random(2, 5)
                if currentX + newXVel + alien.w * alien:getScaleFactor() >
                    love.graphics.getWidth() then
                    alien.xVel = 0
                elseif currentX + newXVel < 0 then
                    alien.xVel = 0
                else
                    alien.xVel = newXVel
                end

                -- if alien is flying
                --     fly
                --         flying true
                --         rebasing false
                --         waiting false
            end

            if alien.waiting == false and alien.flying == false and
                alien.rebasing == true then

                -- print(index, 'rebasing')
                -- if alien rebasing
                --     flying false
                --     rebase true
                --     waiting false
                --     if rebasing done
                --         flying false
                --         rebase false
                --         waiting false
                if (alien.x - alien.originalXSpawn < 3) and
                    (alien.y - alien.originalYSpawn < 3) then
                    alien.x = alien.originalXSpawn
                    alien.y = alien.originalYSpawn
                    alien.rebasing = false
                    alien.flying = false
                    alien.waiting = false -- this will be reset to true when all aliens are finished rebasing

                else
                    -- print("originalXSpawn","x","(original - x )/30")
                    -- print(alien.originalXSpawn,alien.x, (alien.originalXSpawn - alien.x) / 30)
                    -- if alien.x >= alien.originalXSpawn then                
                    --     alien.x = alien.x - (alien.x - alien.originalXSpawn) / 30
                    -- else
                    --     alien.x = alien.x + (alien.originalXSpawn - alien.x) / 30
                    -- end

                    alien.x = alien.x + (alien.originalXSpawn - alien.x) / 30

                    alien.y = alien.y + (alien.originalYSpawn - alien.y) / 30

                end

            end

            if alien.y > love.graphics.getHeight() then
                -- if flight height > 0
                --     flying false
                --     rebasing true
                --     waiting false
                alien.flying = false
                alien.rebasing = true
                alien.waiting = false
                -- alien._garbage = true

                alien.y = 0
                alien.x = love.graphics.getWidth()
                alien.xVel = 0
                alien.yVel = 0

            end

            -- if all flying false, rebasing false, waiting = false
            --     set all to waiting
        end
    end

    if readyForLaunch() == true then

        -- local levelType="rectangle"
        -- gameLevel=gameLevel+1
        -- if gameLevel==1 then levelType = "rectangle" end
        -- if gameLevel==2 then levelType = "circle" end
        -- if gameLevel==3 then levelType = "weirdformation" end
        -- if gameLevel==4 then levelType = "sformation" end

        -- loadAliens(gameLevel,levelType)

        for index, alien in pairs(customObjects) do
            alien.flying = false
            alien.rebasing = false
            alien.waiting = true
            -- alien.x = alien.originalXSpawn --needs fixed, this is a temp fix, last alien not placed before relaunch
            -- alien.y = alien.originalYSpawn --needs fixed, same
        end

    end
end

function readyForLaunch()
    local ready = true
    for index, alien in pairs(customObjects) do
        if alien.customObjectType == 'bigAlien' then
            if alien.waiting == false and alien.flying == false and
                alien.rebasing == false and alien.x - alien.originalXSpawn == 0 and
                alien.y - alien.originalYSpawn == 0 then
                -- do nothing
            else
                ready = false
            end
        end
    end
    return ready
end
