
--
-- ogmo.lua
--
-- Copyright (c) 2020 elGabe
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
-- of the Software, and to permit persons to whom the Software is furnished to do
-- so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--

local json = require("json")
local ogmo = {}

local add = table.insert

-- Reads an ogmo json file and takes in a texture to assign to the level
function ogmo.read_map(path, texture)
    local map = {}
    map.texture = texture
    local string = love.filesystem.read(path)
    map.data = json.decode(string)

    map.layers = {}
    map.entities = {}
    map.width = map.data.width
    map.height = map.data.height
    map.solids = {}

    -- Loop through all layers
    for l = 1, #map.data.layers do
        -- Get current layer
        local layer = map.data.layers[l]
        
        -- IMPROVE ON THIS!!!!
        -- USE ASSERTS AND DEFAULTS INSTEAD
        -- Check if this is an entity layer
        if layer.entities ~= nil then
            map.entities = layer.entities
        end
        
        -- Check if layer has data
        if layer.data ~= nil then
            add(map.layers, layer)
        end

        if (layer.data2D ~= nil) then
            --[TODO] Unpack data2D into 1D array and run through same process
        end
    end

    -- Information to split the texture
    local cell_width = map.data.layers[1].gridCellWidth
    local cell_height = map.data.layers[1].gridCellHeight
    local grid_width = map.data.layers[1].gridCellsX
    local grid_height = map.data.layers[1].gridCellsY
    local texture_width = map.texture:getWidth()
    local texture_height = map.texture:getHeight()

    map.subimages = {}

    -- locals instead of globals for performance
    local love_draw = love.graphics.draw
    local love_quad = love.graphics.newQuad

    -- Splitting texture into individual tile images
    for uvy = 0, (texture_height / cell_height) - 1 do
        for uvx = 0, (texture_width / cell_width) - 1 do
            local quad = love_quad(uvx * cell_width, uvy * cell_height, cell_width, cell_height, map.texture:getDimensions())
            add(map.subimages, quad)
        end
    end

-- Change scale? Separate texture??
function map:draw(origin_x, origin_y, layer_index)

    origin_x = origin_x or 0
    origin_y = origin_y or 0

    -- 
    if (layer_index ~= nil) then
        
        assert(layer_index >= 1, "Lua tables are 1-indexed; 'layer_index' cannot be lower than 1.")

        local layer = map.layers[layer_index]

        for y = 0, grid_height-1 do
            for x = 0, grid_width-1 do
                local tile = layer.data[(y * grid_width + x) + 1]
                local xx = cell_width * x
                local yy = cell_height * y

                if (tile ~= -1) then
                    love_draw(map.texture, map.subimages[tile+1], origin_x + xx, origin_y + yy)
                end
            end
        end        
    else
        -- If layer_index is omitted, assume we draw all layers
        -- Loop through the tiles to draw
        for l = #map.layers, 1, -1 do
            local layer = map.layers[l]

            for y = 0, grid_height-1 do
                for x = 0, grid_width-1 do
                    local tile = layer.data[(y * grid_width + x) + 1]
                    local xx = cell_width * x
                    local yy = cell_height * y

                    if (tile ~= -1) then
                        love_draw(map.texture, map.subimages[tile+1], origin_x + xx, origin_y + yy)
                    end
                end
            end
        end
    end

end

function map:draw_layer(layer_index, origin_x, origin_y)

    layer_index = layer_index or 1

    assert(layer_index >= 1, "Lua tables are 1-indexed; 'layer_index' cannot be lower than 1.")
    
    origin_x = origin_x or 0
    origin_y = origin_y or 0

    local layer = map.layers[layer_index]

    for y = 0, grid_height-1 do
        for x = 0, grid_width-1 do
            local tile = layer.data[(y * grid_width + x) + 1]
            local xx = cell_width * x
            local yy = cell_height * y

            if (tile ~= -1) then
                love_draw(map.texture, map.subimages[tile+1], origin_x + xx, origin_y + yy)
            end
        end
    end
end

    return map
end

-- TODO: Decorations, instances, collisions(??)

return ogmo