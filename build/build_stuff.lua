-- API to build things 
local comfy = require("help_functions.comfy")
local debugging = require("help_functions.debugging")

local function farm()
    -- getting the height of the farm
    local height = comfy.get_number("How tall would you like the farm to be?")

    -- getting the length of the farm's walls
    local wall_length = comfy.get_number("Length of the wall?")
end

local function build_from_array(thing_to_build)
    local width_offset = comfy.table_length(thing_to_build)
    local height = 0
    -- for i = 2, width_offset do
    --     comfy.step_right()
    -- end

    --print(require("help_functions.debugging").dump_table(thing_to_build))

    for width_step, height_table in ipairs(thing_to_build) do
        local reversed_table = comfy.reverse_table(height_table)
        for height_index, row in ipairs(reversed_table) do
            local depth_offset = comfy.table_length(row)
            for i = 1, depth_offset do
                comfy.step_forward()
            end
            for index, value in ipairs(row) do
                if value == "x" then
                    comfy.place_thing("minecraft:cobblestone") -- the index is supposed to store name of material
                end
                comfy.step_back()
            end
            height = height + 1
            comfy.step_up()
        end
        
        for i = 1, height do
            comfy.step_down()
        end
        height = 0
        comfy.step_right()
    end
    for i = 1, width_offset do
        comfy.step_left()
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

local function read_exported_model()
    local array = comfy.lines_from("voxel_model.txt")
    
    return array
end

return {
    farm = farm,
    bridge = bridge,
    build_stuff = build_stuff,
    build_from_array = build_from_array,
    place_needed = place_needed,
    read_exported_model = read_exported_model,
}
