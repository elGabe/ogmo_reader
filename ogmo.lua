
local json = require "lovegabe.json"
local gabe = require "lovegabe.gabe"
local ogmo = {}

local add = table.insert

-- Reads an ogmo json file and takes in a texture to assign to the level
function ogmo.read_map(path, texture)
    local map = {}
    map.texture = texture
    local string = love.filesystem.read(path)
    map.data = json.decode(string)

    map.tiles_layer = {}
    map.entities = {}
    map.width = map.data.width
    map.height = map.data.height
    map.solids = {}

    -- Loop through all layers
    for l = 1, #map.data.layers do
        -- Get current layer
        local layer = map.data.layers[l]
        
        -- Check if this is an entity layer
        if layer.entities ~= nil then
            map.entities = layer.entities
        end
        
        -- Check if layer has data
        if layer.data ~= nil then
            add(map.tiles_layer, layer)
        end

        if (layer.data2D ~= nil) then
            --[TODO] Unpack data2D into 1D array and run through same process
        end

        -- This layer represents solids
        if (string.lower(layer.name) == "solids") then
            map.solids = layer.data
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

    function map:make_solids(table)
        for y = 0, grid_height-1 do
            for x = 0, grid_width-1 do
                local tile = map.solids[(y * grid_width + x) + 1]
                local xx = cell_width * x
                local yy = cell_height * y

                if (tile ~= -1) then
                    local solid = gabe.make_AABB(xx, yy, cell_width, cell_height)
                    add(table, solid)
                end
            end
        end
    end

function map:draw()

    -- Loop through the tiles to draw
    for l = #map.tiles_layer, 1, -1 do
        local layer = map.tiles_layer[l]

        for y = 0, grid_height-1 do
            for x = 0, grid_width-1 do
                local tile = layer.data[(y * grid_width + x) + 1]
                local xx = cell_width * x
                local yy = cell_height * y

                if (tile ~= -1) then
                    love_draw(map.texture, map.subimages[tile+1], xx, yy)
                end
            end
        end
    end

end

function map:draw_layer(layer_index)
    local layer = map.tiles_layer[layer_index]

    for y = 0, grid_height-1 do
        for x = 0, grid_width-1 do
            local tile = layer.data[(y * grid_width + x) + 1]
            local xx = cell_width * x
            local yy = cell_height * y

            if (tile ~= -1) then
                love_draw(map.texture, map.subimages[tile+1], xx, yy)
            end
        end
    end
end

    return map
end

return ogmo