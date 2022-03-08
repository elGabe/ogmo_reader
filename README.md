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

Loads an ogmo map and returns its table.

```lua
local map = ogmo.read_map("path/to/level.json", love.graphics.newImage("path/to/tileset.png"))
```
