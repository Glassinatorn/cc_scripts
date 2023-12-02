local function is_position(curr_position, dest)
    local same_position = curr_position.x == dest.x and 
        curr_position.y == dest.y and 
        curr_position.z == dest.z

    return same_position
end

local function x_move(curr_position, dest)
    if curr_position.x < dest.x then
        curr_position.x = curr_position.x + 1
        turtle.forward()
    else
        curr_position.x = curr_position.x - 1
        turtle.back()
    end
end

local function y_move(curr_position, dest)
    if curr_position.y < dest.y then
        curr_position.y = curr_position.y + 1
        turtle.up()
    else
        curr_position.y = curr_position.y - 1
        turtle.down()
    end
end

local function z_move(curr_position, dest)
    if curr_position.z < dest.z then
        curr_position.z = curr_position.z + 1
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
    else
        curr_position.z = curr_position.z - 1
        turtle.turnLeft()
        turtle.forward()
        turtle.turnRight()
    end
end


local function move_to(curr_position, dest)
    if curr_position = dest
        return 
    end

    x_move(curr_position, dest)
    y_move(curr_position, dest)
    z_move(curr_position, dest)

    move_to(curr_position, dest)
end

local function place_needed(curr_position, map)
-- check map to see what is needed in the block below
end

local function traverse_layer(curr_position, map, width, depth)
    for i=1,width do
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
        curr_position.x = curr_position.x + 1
        for i=1,depth do
            turtle.forward()
            curr_position.z = curr_position.z + 1
            place_needed(curr_position, map)
        end
    end
end

return {
    is_position = is_position,
    move_to = move_to,
    traverse_layer = traverse_layer,
}
