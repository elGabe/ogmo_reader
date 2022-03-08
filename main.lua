

ogmo = require("ogmo")

WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

function love.load()

	level_0 = ogmo.read_map("maps/level_0.json", love.graphics.newImage("tilesets/0x72_16x16RobotTileset.v1.png"))

end

function love.update(dt)

end

function love.draw()
	
	--Draw map at the origin point
	level_0:draw()

	-- Draw map at a specific coordinate
	--level_0:draw(100, 100)
	
	-- Draw map centered, using map properties
	--level_0:draw(WINDOW_WIDTH/2 - level_0.width/2, WINDOW_HEIGHT/2 - level_0.height/2)

	-- Draw map layer
	--level_0:draw_layer(2, 100, 100)

end