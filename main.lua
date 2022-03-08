

ogmo = require("ogmo")

function love.load()

	level_0 = ogmo.read_map("maps/level_0.json", love.graphics.newImage("tilesets/0x72_16x16RobotTileset.v1.png"))

end

function love.update(dt)

end

function love.draw()
	level_0:draw()
end