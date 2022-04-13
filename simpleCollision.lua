function collisionDetect(object1, object2, hitX_0to1, hitY_0to1)
    hitX_0to1 = hitX_0to1 or .9
    hitY_0to1 = hitY_0to1 or hitX_0to1
    local x1 = object1.x
    local y1 = object1.y
    local w1 = object1.w * object1.sx
    local h1 = object1.h * object1.sy
    local x2 = object2.x
    local y2 = object2.y
    local w2 = object2.w * object2.sx
    local h2 = object2.h * object2.sy

    if  (x2<(x1+w1*hitX_0to1)) and
        (x1<(x2+w2*hitX_0to1)) and
        (y2<(y1+h1*hitY_0to1)) and
        (y1<(y2+h2*hitY_0to1)) then
        return true
    else
        return false
        --;alksdjf;lkjasdf;flkjasdff
    end
end
