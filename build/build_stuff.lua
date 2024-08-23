-- API to build things 
local comfy = require("help_functions.comfy")

local function farm()
    -- getting the height of the farm
    local height = comfy.get_number("How tall would you like the farm to be?")

    -- getting the length of the farm's walls
    local wall_length = comfy.get_number("Length of the wall?")
end

local function build_from_array(array)
    -- getting the length of the bridge
    -- local length = comfy.get_number("How long would you like the bridge to be?")
    local slot = comfy.search_inventory("minecraft:stone")

    turtle.select(slot)
    for i=1, length(array) do
        place_down(array[i])
    end
    for width, width_index in ipairs(array) do
        for height, height_index in ipairs(width_index) do
            for depth, depth_index in ipairs(height_index) do
                
            end
        end
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
    place_needed = place_needed,
}
