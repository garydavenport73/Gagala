function loadAliens(level)
    print("starting level", level)

    local widthDifference = love.graphics.getWidth()-8*aliens.bigAlienDef.scaleFactor*aliens.bigAlienDef.w
    local margin = widthDifference/2
    for i = 1, 3, 1 do
        for j = 1, 8, 1 do
            CustomObject:Create(
                (j-1) * aliens.bigAlienDef.scaleFactor * aliens.bigAlienDef.w + margin,
                i * aliens.bigAlienDef.scaleFactor * aliens.bigAlienDef.h,
                aliens.bigAlienDef, 0, 0)
        end
    end

end
