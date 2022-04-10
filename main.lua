function love.load()
    require('dependencies')

    -- Ship definition
    local shipDef = {
        w = 16,
        h = 24,
        image = 'assets/graphics/ship.png',
        frames = {3, '1-2'},
        weaponFeatures = gWeaponDefs.heavy -- Weapon features from Weapon:addFeatures()
    }

    ship = Ship:Create(love.graphics.getWidth() / 2, love.graphics.getHeight() - 64, shipDef)
    --
        -- Create shield collectible using the CollectibleTable
    shieldObj = createCollectible(50, 50, 'shield')
    loadAliens(1,"circle") --options are "rectangle" "circle" "weirdformation" "sformation"

end
--//////////////Testing placing object and removing///////////
testcount = 0
function love.update(dt)
    testcount=testcount+1
    if testcount==30 then
        BasicExplosion:Create(math.random(0,love.graphics.getWidth()), math.random(0,love.graphics.getHeight()), math.random(2,4), .05)
        testcount=0
    end

--/////////////////////////////////////////////////////////////

    ship:update(dt)
    -------TESTING/DEMONSTRATING dynamic making/destroying/tracking of customObjects
    --alienRaid(2, 10, 3, 20)            --!comment this out to remove demonstration
    ship.weapon[1]:setOffScreenBulletsForRemoval()
    upDateGagalaAliensTrajectories()
    updateCustomObjects(dt)           --required if using dynamic list, loops through all CustomObjects
    ---------------------------------
end

function love.draw()
    ship:draw()
    drawCustomObjects()   --required if using dynamic list of CustomObjects, loops through all CustomObjects
end

function love.keypressed(key)
    if key == 'f' then
        if ship.weaponInd == 1 then
            ship.weaponInd = 2
        else
            ship.weaponInd = 1
        end
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