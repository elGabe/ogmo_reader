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

### ogmo.read_map(json, image)

Loads an ogmo map and returns its table.

**Synopsis**
```lua
function love.load()
  map = ogmo.read_map("path/to/level.json", love.graphics.newImage("path/to/tileset.png"))
end
```
**Arguments**  
```json```  
A path to the level's json file.  
```image```  
The image to draw the map with. AKA: The map's tileset loaded with ```love.graphics.newImage```

### map:draw(origin_x, origin_y, layer_index)

Draws an ogmo map.

```lua
function love.draw()
  map:draw(100, 100, 1)
end
```
**Arguments**  
All arguments here are optional. See ```main.lua``` for examples.  
```origin_x```  
X coordinate to draw map from  
```origin_y```  
Y coordinate to draw map from  
```layer_index```  
Layer of the map to draw. Omit to draw all layers.

### map:draw_layer(origin_x, origin_y, layer_index)  
Explicitly draws a layer from the map.

```lua
function love.draw()
  map:draw_layer(100, 100, 2)
end
```
**Arguments**  
```origin_x```  
X coordinate to draw map from  
```origin_y```  
Y coordinate to draw map from  
```layer_index```  
Layer of the map to draw. Must specify a layer.

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
