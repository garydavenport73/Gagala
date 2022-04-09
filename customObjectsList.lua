customObjects = {}

-- loops through characters and calls their update functions
function updateCustomObjects(dt)
    print("length",#customObjects)
    for index, object in pairs(customObjects) do
        print("index","object")
        print(index,object.customObjectType)
        index = index
        object:update(dt)
    end
end

-- loops through characters and calls their draw functions
function drawCustomObjects()
    for index, customObject in pairs(customObjects) do
        index = index
        customObject:draw()
    end
end

-- This function, optionally if used in a game, will check all gameCharacters in the list
-- and remove them from the list, then destroy them if they have left the screen.
function clearCustomObjectsIfOffScreen()
    for index, customObject in pairs(customObjects) do
        -- print(index,customObject, customObject.customObjectType)
        if customObject.y > love.graphics.getHeight() or customObject.x >
            love.graphics.getWidth() or customObject.x +
            customObject:getScaleFactor() * customObject.w < 0 or customObject.y +
            customObject:getScaleFactor() * customObject.h < 0 then
            -- customObject:destroySelf()-->works, but is an O(n^2) operation
            -- customObject=nil                  --O(n) operation
            -- table.remove(customObjects,index) --O(n) operation
            customObject._garbage = true
        end
    end
    removeGarbageFromList()
end

function showCustomObjects(dt)
    for index, customObject in pairs(customObjects) do
        index = index
        -- print(index, customObject.customObjectType)
    end
end

function removeGarbageFromList()
    for i = #customObjects, 1, -1 do
        if customObjects[i]._garbage == true then
            -- tempObject = table.remove(customObjects,i) --works-------
            -- table.insert(customObjects,tempObject)
            -- --customObjects[#customObjects] = nil
            -- table.remove(customObjects,#customObjects) --works------

            --trying this
            local tempTable = table.remove(customObjects,i)
            tempTable = nil
            --table.insert(customObjects,tempObject)
            --table.remove(customObjects,#customObjects)


        end
    end
end
