local comfy = require("help_functions.comfy") -- help funcitons

local function check_minable_material_front()
    -- checks if the block given is able to be mined
    local if_block, present_block = turtle.inspect()

    if if_block then
        if present_block["tags"]["minecraft:mineable/pickaxe"] == true then
            return true
        end
    end

    -- print(textutils.serialise(present_block))
    return false
end

local function check_minable_material_down()
    -- checks if the block given is able to be mined
    local if_block, present_block = turtle.inspectDown()

    if if_block then
        if present_block["tags"]["minecraft:mineable/pickaxe"] == true then
            return true
        end
    end

    -- print(textutils.serialise(present_block))
    return false
end

local function tunnel(length)
    for i=1, length do
        if check_minable_material_front() then
            comfy.fuel_check()
            turtle.dig()
            comfy.step_forward()
        end
    end
    for i=1, length do
        comfy.step_back()
    end
end

local function grid_of_tunnels(height, width, depth)
    for i=1,height do
        for i=1,width do
            comfy.step_right()
            tunnel(depth)
        end

        for i=1,width do
            comfy.step_left()
        end

        tunnel(depth)
        comfy.step_up()
    end

    for i=1,height do
        comfy.step_down()
    end
end

local function hole(depth)
    for i=1, depth do
        if check_minable_material_down() then
            comfy.fuel_check()
            turtle.digDown()
            comfy.step_down()
        end
    end
    for i = 1, depth do
        comfy.step_up()
    end
end

local function grid_of_holes(depth, width, height)
    for i=1,height do
        for i=1,width do
            comfy.step_right()
            hole(depth)
        end

        for i=1,width do
            comfy.step_left()
        end

        hole(depth)
        comfy.step_forward()
    end

    for i=1,height do
        comfy.step_back()
    end
end

return {
    tunnel = tunnel,
    grid_of_tunnels = grid_of_tunnels,
    hole = hole,
    grid_of_holes = grid_of_holes,
    check_minable_material_front = check_minable_material_front,
    check_minable_material_down = check_minable_material_down,
}
