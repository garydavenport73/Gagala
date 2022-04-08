function love.load()
    require('dependencies')
    ship = Ship:Create(love.graphics.getWidth() / 2, love.graphics.getHeight() - 64, shipDef)
    loadAliens(1)
end

function love.update(dt)
    ship:update(dt)

    -------TESTING/DEMONSTRATING dynamic making/destroying/tracking of customObjects

    gagalaRaid(dt)
    --alienRaid(2, 10, 3, 20)            --!comment this out to remove demonstration
    --clearCustomObjectsIfOffScreen()   --destroy bullets, aliens, and any other generic object that goes off screen
    showCustomObjects(dt)
    upDateGagalaAliensTrajectories()
    checkForEndOfRound()
    updateCustomObjects(dt)           --required if using dynamic list, loops through all CustomObjects
end

function love.draw()
    ship:draw()
    drawCustomObjects()   --required if using dynamic list of CustomObjects, loops through all CustomObjects
end

