# Ogmo Reader
A LÖVE library for loading OGMO Editor maps

## Usage
Just copy ```ogmo.lua```\* into your project folder and add 
```lua
local ogmo = require("path.to.ogmo")

``` 

in the begining of your ```main.lua```

\*also add ```json.lua``` if you don't have it.

## Functions

### ogmo.read_map(path_to_json, image)

Loads an ogmo map and returns its table. Returns ogmo map as a table.

```lua
function love.load()
  map = ogmo.read_map("path/to/level.json", love.graphics.newImage("path/to/tileset.png"))
end
```
### map:draw(origin_x, origin_y)

Draws an ogmo map.

```lua
function love.draw()
  map:draw(100, 100)
end
```
## Properties

### width
Returns the width of the map.
```lua
local map_width = map.width
```
### height
Returns the height of the map.
```lua
local map_height = map.height
```
### layers
Returns a table of layers from the map.
```lua
local map_layers = {}
map_layers = map.layers
```
