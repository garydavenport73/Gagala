BasicExplosion = {}
BasicExplosion.__index = BasicExplosion
function BasicExplosion:Create(spawn_x, spawn_y, scaleFactor, durations)
    local this = {
        x = spawn_x,
        y = spawn_y,
        scaleFactor = scaleFactor or 2,
        durations = durations or 0.05,
        explosionDef = {w = 16 , h = 16, image = 'assets/graphics/explosion.png', frames = {'1-5', 1}, durations = durations, onloop='pauseAtEnd', sx=1,sy=1}
    }
    this.explosion = CustomObject:Create(this.x,this.y,this.explosionDef,0,0)
    this.explosion:changeScaleFactor(this.scaleFactor)
    this.explosion:setType("basicExplosion")
    return this.explosion
end



