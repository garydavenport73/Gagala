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

gCollectibles = {
    shield = {
        w = 16,
        h = 16,
        image = 'assets/graphics/power-up.png',
        frames = {'1-2', 1},
        durations = 0.3,
        type = 'shield'
    },
    health = {
        w = 16,
        h = 16,
        image = 'assets/graphics/power-up.png',
        frames = {'1-2', 2},
        durations = 0.3,
        type = 'health'
    },
    homing = {
        w = 16,
        h = 16,
        image = 'assets/graphics/power-up.png',
        frames = {'3-4', 1},
        durations = 0.3,
        type = 'homing',
    },
}