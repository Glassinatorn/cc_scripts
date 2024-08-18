local comfy = require("comfy") -- help funcitons

local function step_right()
    turtle.turnRight()
    comfy.fuel_check()
    turtle.forward()
    turtle.turnLeft()
end

local function step_left()
    turtle.turnLeft()
    comfy.fuel_check()
    turtle.forward()
    turtle.turnRight()
end

function long_tunnel(length)
    if length > 0 then
        if check_minable_material_front() then
            comfy.fuel_check()
            turtle.dig()
            turtle.forward()

            length = length - 1

            long_tunnel(length)
        end
    end

    comfy.fuel_check()
    turtle.back()
end

function grid_of_tunnels(height, width, depth)
    long_tunnel(depth)
    turtle.forward()

    for i=1,height do
        comfy.fuel_check()
        long_tunnel(depth)
        turtle.forward()

        for i=1,width do
            comfy.fuel_check()
            
            turtle.turnRight()
            turtle.forward()
            turtle.turnLeft()

            long_tunnel(depth)
            turtle.forward()
        end

        comfy.fuel_check()

        for i=1,width do
            comfy.fuel_check()

            turtle.turnLeft()
            turtle.forward()
            turtle.turnRight()
        end

        comfy.fuel_check()

        turtle.up()
    end

    for i=1,height do
        turtle.down()
        long_tunnel(depth)
    end
end

function check_minable_material_front()
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

return {
    long_tunnel = long_tunnel,
    grid_of_tunnels = grid_of_tunnels,
    check_minable_material_front = check_minable_material_front,
}
