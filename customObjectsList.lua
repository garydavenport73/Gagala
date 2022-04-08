customObjects = {}

--loops through characters and calls their update functions
function updateCustomObjects(dt)
    for index, object in pairs(customObjects) do
        index = index
        object:update(dt)
    end
end

--loops through characters and calls their draw functions
function drawCustomObjects()
    for index, customObject in pairs(customObjects) do
        index = index
        customObject:draw()
    end
end

--This function, optionally if used in a game, will check all gameCharacters in the list
--and remove them from the list, then destroy them if they have left the screen.
function clearCustomObjectsIfOffScreen()
    for index, customObject in pairs(customObjects) do
        --print(index,customObject, customObject.customObjectType)
        if customObject.y > love.graphics.getHeight() or
            customObject.x > love.graphics.getWidth() or
            customObject.x + customObject:getScaleFactor() * customObject.w < 0 or
            customObject.y + customObject:getScaleFactor() * customObject.h < 0 then
          --customObject:destroySelf()-->works, but is an O(n^2) operation
          customObject=nil                  --O(n) operation
          table.remove(customObjects,index) --O(n) operation
        end
    end
end

function showCustomObjects(dt)
    for index, customObject in pairs(customObjects) do
        index = index
        --print(index, customObject.customObjectType)
    end
end
