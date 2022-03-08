# Ogmo Reader
A LÖVE library for loading OGMO Editor maps

## Usage
Just copy ```ogmo.lua```\* into your project and add 
```lua
local ogmo = require("path.to.ogmo")

``` 

in the begining of your ```main.lua```

\*also add ```json.lua``` if you don't have it.

## Functions

### ogmo.new(string:path_to_json, Image:image)

Loads an ogmo map and returns its table.
