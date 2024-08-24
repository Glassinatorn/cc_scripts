-- API to build things 
local comfy = require("help_functions.comfy")

local function farm()
    -- getting the height of the farm
    local height = comfy.get_number("How tall would you like the farm to be?")

    -- getting the length of the farm's walls
    local wall_length = comfy.get_number("Length of the wall?")
end

local function build_from_array(thing_to_build)
    local width_offset = comfy.table_length(thing_to_build)
    -- for i = 2, width_offset do
    --     comfy.step_right()
    -- end

    --print(require("help_functions.debugging").dump_table(thing_to_build))
    -- for width, height_table in ipairs(thing_to_build) do
    for height_table in thing_to_build do
        write("inside")
        local reversed_height_table = comfy.reverse_table(height_table)

        write("reversed: " .. reversed_height_table)
        -- for height, depth_table in ipairs(reversed_height_table) do
        --     write("inside")
        --     local depth_offset = comfy.table_length(depth_table)
        --     write("time to move forward")
        --     for i = 1, depth_offset do
        --         turtle.step_forward()
        --     end
        --     for depth, depth_index in ipairs(depth_table) do
        --         if depth_index == "x" then
        --             comfy.place_thing("minecraft:cobblestone") -- the index is supposed to store name of material
        --         end
        --         comfy.step_back()
        --     end
        --     comfy.step_up()
        -- end
        -- comfy.step_left()
    end
end

-- lua switch case
local function build_stuff()
    print("What would you like to build?")
    print("1. Farm")
    print("2. Bridge")
    print("3. Exit")
    local choice = io.read()

    if choice == "1" then
        farm()
    elseif choice == "2" then
        build_from_array()
    elseif choice == "3" then
        print("Exiting...")
        os.exit()
    else
        print("Invalid choice")
        build_stuff()
    end
end

local function place_needed(curr_position, map, width, height)
    for line in map do
        if line[index - (width * height)][1] == 191 then
            turtle.placeDown() -- place down thing
        end
    end
end

return {
    farm = farm,
    bridge = bridge,
    build_stuff = build_stuff,
    build_from_array = build_from_array,
    place_needed = place_needed,
}
