function gagalaRaid(dt)
    -- print("calling gagala raid")
    for index, customObject in pairs(customObjects) do

        if customObject.customObjectType == "bigAlien" then
            -- print("found a bigAlien")
            -- print("someonesFlying", aliensFlying())
            if math.random(1, 1000) < 5 then
                print("less than 5/1000")
                if customObject.inFlight == false then
                    print("not in flight")
                    if customObject.flightFinished == false then
                        if customObject.reBasing == false then
                           
                            print('launch!!!!!!!!!!!!!!!!!!!!!!')
                            -- customObject.yVel = 3
                            singleAlienLaunch(customObject)  
                        end

                    end
                end
            end

        end

    end

end

function singleAlienLaunch(alien)
    -- alien trajectory
    xDev = math.random(-2, 2)
    ySpeed = math.random(1, 5)
    alien.xVel = xDev + math.random(-1, 1)
    alien.yVel = ySpeed
    alien.inFlight = true
end

function upDateGagalaAliensTrajectories()
    local currentX = 0
    local currentXVel = 0
    local newXVel = 0
    for index, customObject in pairs(customObjects) do
        if customObject.customObjectType == "bigAlien" then
            if customObject.inFlight == true and customObject.reBasing == false then
                currentX = customObject.x
                newXVel = customObject.xVel + math.random(-1, 1) /
                              math.random(2, 5)
                if currentX + newXVel + customObject.w *
                    customObject:getScaleFactor() > love.graphics.getWidth() then
                    customObject.xVel = 0
                elseif currentX + newXVel < 0 then
                    customObject.xVel = 0
                else
                    customObject.xVel = newXVel
                end
                if customObject.y > love.graphics.getHeight() then
                    customObject.inFlight = false
                    -- customObject.flightFinished = true
                    customObject.reBasing = true
                    -- customObject.x = -999
                    customObject.y = 0
                    -- customObject.x = customObject.originalXSpawn
                    -- customObject.y = customObject.originalYSpawn
                    -- customObject.xVel = 0
                    -- customObject.yVel = 0
                end


            end
        end
        if customObject.reBasing == true then
            if customObject.x - customObject.originalXSpawn < 5 then
                customObject.x = customObject.originalXSpawn
                customObject.y = customObject.originalYSpawn
                customObject.reBasing = false
                customObject.flightFinished = true
            else
                customObject.x = customObject.x +
                                     (customObject.originalXSpawn -
                                         customObject.x) / 10
                customObject.x = customObject.x +
                                     (customObject.originalXSpawn -
                                         customObject.x) / 10
            end

        end
    end

end

function checkForEndOfRound()
    if aliensFlying() == false then
        if aliensFinishedFlight() == true then _resetAliens() end
    end
end

function _resetAliens()
    for index, customObject in pairs(customObjects) do
        if customObject.customObjectType == "bigAlien" then
            customObject.flightFinished = false
            customObject.x = customObject.originalXSpawn
            customObject.y = customObject.originalYSpawn
        end
    end

end

function aliensFlying()
    local someonesFlying = false
    for index, customObject in pairs(customObjects) do
        if customObject.customObjectType == "bigAlien" then
            if customObject.inFlight == true then
                someonesFlying = true
            end
        end
    end
    return someonesFlying
end

function aliensFinishedFlight()
    local allFinished = true
    for index, customObject in pairs(customObjects) do
        if customObject.customObjectType == "bigAlien" then
            if customObject.flightFinished == false then
                allFinished = false
            end
        end
    end
    return allFinished
end
