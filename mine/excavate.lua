function long_tunnel(length)
    if length > 0 then
        if check_minable_material_front() then
            if turtle.getFuelLevel() < 5 then
                turtle.refuel()
            end
            turtle.dig()
            turtle.forward()

            length = length - 1

            long_tunnel(length)
        end
    end

    if turtle.getFuelLevel() < 5 then
        turtle.refuel()
    end

    turtle.back()
end

function grid_of_tunnels(height, width, depth)
    long_tunnel(depth)
    turtle.forward()

    for i=1,height do
        if turtle.getFuelLevel() < 5 then
            turtle.refuel()
        end

        long_tunnel(depth)
        turtle.forward()

        for i=1,width do
            if turtle.getFuelLevel() < 5 then
                turtle.refuel()
            end

            turtle.turnRight()
            turtle.forward()
            turtle.turnLeft()
            long_tunnel(depth)
            turtle.forward()
        end

        if turtle.getFuelLevel() < 5 then
            turtle.refuel()
        end


        for i=1,width do
            if turtle.getFuelLevel() < 5 then
                turtle.refuel()
            end

            turtle.turnLeft()
            turtle.forward()
            turtle.turnRight()
        end

        if turtle.getFuelLevel() < 5 then
            turtle.refuel()
        end

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