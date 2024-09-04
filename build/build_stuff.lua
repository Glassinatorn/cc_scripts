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
    local width = comfy.find_max_table(thing_to_build)
    local height = 0
    
    for x = 1, #thing_to_build do
        for y = 1, #thing_to_build[x] do
            for i = 1, #thing_to_build[x][y] do
                comfy.step_forward()
            end
            for z = 1, #thing_to_build[x][y] do
                comfy.place_thing(thing_to_build[x][y][z])
                comfy.step_back()
            end
            comfy.step_up()
            height = height+1
        end
        for i = 1, height do
            comfy.step_down()
        end
        comfy.step_right()
    end
    for i = 0, width do
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

local function fetch_model_file(filename)
    local array = comfy.lines_from(filename)

    if array == nil then
        return nil
    end

    table.remove(array, 1)
    table.remove(array, 1)
    table.remove(array, 1)

    return array
end

local function read_exported_model(filename)
    local array = fetch_model_file(filename)
    if array == nil then
        return nil
    end
    for index, row in ipairs(array) do
        local tmp = comfy.split_strings(row)

        array[index] = tmp
    end

    -- find offsets
    local tmp_x = {}
    local tmp_y = {}
    local tmp_z = {}

    for index, row in ipairs(array) do
        tmp_x[index] = tonumber(row[1])
        tmp_y[index] = tonumber(row[2])
        tmp_z[index] = tonumber(row[3])
    end

    local x_offset = comfy.find_offset(tmp_x)
    local y_offset = comfy.find_offset(tmp_y)
    local z_offset = comfy.find_offset(tmp_z)

    -- increase values in array by offset
    for index, row in ipairs(array) do
        array[index][1] = row[1] + x_offset
        array[index][2] = row[2] + y_offset
        array[index][3] = row[3] + z_offset
        array[index][4] = row[4]
    end

    return array
end

local function colour_to_material(value)
    if value == "ffffff" then
        return "minecraft:cobblestone"
    end
end

local function goxel_to_3d_table(goxel_table)
    local converted = comfy.new_auto_table(3)

    local x_list = {}
    local y_list = {}
    local z_list = {}

    for index, row in ipairs(goxel_table) do
        x_list[index] = row[1]
        y_list[index] = row[2]
        z_list[index] = row[3]
    end

    local x_size = comfy.find_max_table(x_list)
    local y_size = comfy.find_max_table(y_list)
    local z_size = comfy.find_max_table(z_list)

    for i = 1, x_size do
        for j = 1, y_size do
            for k = 1, z_size do
                converted[i][j][k] = "x"
            end
        end
    end

    for index, row in ipairs(goxel_table) do
        local x = row[1]
        local y = row[2]
        local z = row[3]
        local colour = row[4]

        converted[x][y][z] = colour_to_material(colour)
    end

    return converted
end


return {
    farm = farm,
    build_stuff = build_stuff,
    build_from_array = build_from_array,
    place_needed = place_needed,
    read_exported_model = read_exported_model,
    goxel_to_3d_table = goxel_to_3d_table,
    colour_to_material = colour_to_material,
}
