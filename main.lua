
ship=nil
startup=true
level=1
function startUp()
        customObjects={}
        -- Ship definition
        shipDef = {
            w = 16,
            h = 24,
            image = 'assets/graphics/ship.png',
            frames = {3, '1-2'},
            weaponFeatures = gWeaponDefs.heavy -- Weapon features from Weapon:addFeatures()
        }
    
        ship = Ship:Create(love.graphics.getWidth() / 2,
                           love.graphics.getHeight() - 64, shipDef)
        --
        -- Create shield collectible using the CollectibleTable
        shieldObj = createCollectible(100, 750, 'shield')
        loadAliens(level, "circle") -- options are "rectangle" "circle" "weirdformation" "sformation"
        -- love.graphics.setColor(1,1,1,1)
        gameScore = 0
        lives = 3
        waitingForShipRegeneration = false
        shipRegenerationCount = 0
        centerMessage = "LEVEL 1"
        shipLaunchable=false
end


function love.load()
    require('dependencies')




end
-- //////////////Testing placing object and removing///////////
-- testcount = 0
shipHit = false
function love.update(dt)
    if startup==true then
        startUp()
        startup=false
        shipHit=false
    end


    -- testcount=testcount+1
    -- if testcount==30 then
    --     BasicExplosion:Create(math.random(0,love.graphics.getWidth()), math.random(0,love.graphics.getHeight()), math.random(2,4), .05)
    --     testcount=0
    -- end

    -- /////////////////////////////////////////////////////////////

    -------TESTING/DEMONSTRATING dynamic making/destroying/tracking of customObjects
    -- alienRaid(2, 10, 3, 20)            --!comment this out to remove demonstration
    -- if collisionDetect(ship,shieldObj) then
    --     print("Collision Detected !!!!!")
    -- else
    --     print("Collision not Detected.")
    -- end

    for index1, object1 in pairs(customObjects) do
        -- print(object1.customObjectType)
        if object1.customObjectType == "bigAlien" then
            for index2, object2 in pairs(customObjects) do
                if object2.customObjectType == "bullet" then
                    if collisionDetect(object1, object2) then
                        BasicExplosion:Create(object1.x, object1.y, 3, 0.05)
                        object1.garbage = true
                        object2.garbage = true
                        gameScore = gameScore + 1
                    end
                end
            end
        end

        if object1.customObjectType == "bigAlien" then
            if shipHit == false then
                if ship~=nil then
                    if collisionDetect(object1, ship,.7) then
                        BasicExplosion:Create(object1.x, object1.y, 5, 0.05)
                        object1.garbage = true
                        shipHit = true
                        ship = nil
                        waitingForShipRegeneration = true
                        shipLaunchable=false
                        lives = lives - 1
                    end        
                end

            end

        end
    end

    if ship ~= nil then
        ship:update(dt)
        ship.weapon[1]:setOffScreenBulletsForRemoval()
    end

    if waitingForShipRegeneration == true then
        if lives > 0 and shipLaunchable then
            ship = Ship:Create(love.graphics.getWidth() / 2,
                               love.graphics.getHeight() - 64, shipDef)
            shipHit = false
            waitingForShipRegeneration = false
            shipLaunchable=false
        else
            if lives < 1 then centerMessage = "    GAME OVER\nPress S to restart." end
        end
    end

    upDateGagalaAliensTrajectories()
    updateCustomObjects(dt) -- required if using dynamic list, loops through all CustomObjects
    ---------------------------------
end

function love.draw()
    if ship ~= nil then
        ship:draw()
    end

    love.graphics.print("LEVEL:" .. level, 0, 0, 0, 1, 1, 0, 0, 0, 0)
    love.graphics.print("SCORE:" .. gameScore, 100, 0, 0, 1, 1, 0, 0, 0, 0)
    love.graphics.print("LIVES:" .. lives, 200, 0, 0, 1, 1, 0, 0, 0, 0)
    love.graphics.print(centerMessage, 275, 450, 0, 1, 1, 0, 0, 0, 0)
    drawCustomObjects() -- required if using dynamic list of CustomObjects, loops through all CustomObjects
end

function love.keypressed(key)
    if key == 'f' then
        if ship.weaponInd == 1 then
            ship.weaponInd = 2
        else
            ship.weaponInd = 1
        end
    end

    if key == 's' then
        lives = 3
        gameScore = 0
        waitingForShipRegeneration = true
        centerMessage=""
        startup=true
        level = 1

    end
end

-- Creates a collectible to be used with customObject class
function createCollectible(x, y, _type)
    local collectibleDef = {}

    if _type == 'shield' then
        collectibleDef = gCollectibles.shield
    elseif _type == 'health' then
        collectibleDef = gCollectibles.health
    else
        collectibleDef = gCollectibles.homing
    end

    local collectible = CustomObject:Create(x, y, collectibleDef)

    return collectible
end
