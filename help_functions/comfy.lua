local debugging = require "help_functions.debugging"
-- These are just helper functions to make the code more compact and readable.
local function table_length(table)
    local num = 0
    
    for _ in pairs(table) do
        num = num + 1
    end

    return num
end

local function reverse_table(table)
    if table and #table > 1 then
		local temp = nil
		for n = 1,math.floor(#table/2) do
			temp = table[n]
			table[n] = table[#table-(n-1)]
			table[#table-(n-1)] = temp
		end 
	end

    return table
end

local function search_inventory(search_name)
    local item = {}

    for slot=1,16 do
        item = turtle.getItemDetail(slot)
        if item then
            if item.name == search_name then
                item = slot
                return item
            end
        end
    end

    return item
end

local function fuel_check()
    if turtle.getFuelLevel() <= 5 then
        local slot = search_inventory("minecraft:coal")

        if slot ~= nil then
            turtle.select(slot)
        end
            
        turtle.refuel()
    end
end

local function get_number(prompt)
    local input = io.read()
    return tonumber(input)
end

local function get_text(prompt)
    local input = io.read()
    return input
end

local function until_file_exists(filename)
    while not fs.exists(filename) do
        os.sleep(1)
    end
    return true
end

local function file_exists(filename)
    local file = io.open(filename, "rb")
    if file then
        file:close()
    end
    return file ~= nil
end

local function lines_from(filename)
    if not file_exists(filename) then
        return nil
    end

    local lines = {}
    for line in io.lines(filename) do
        lines[#lines+1] = line
    end

    return lines
end

local function split_strings(input_string, seperator)
    if seperator == nil then
        seperator = "%s"
    end
    local words = {}
    for str in string.gmatch(input_string, "([^"..seperator.."]+)") do
        table.insert(words, str)
    end

    return words
end

local function remove_char(string, char)
    return string:gsub(char, '')
end

local function reorder_map(map)
    local ordered_map = {}

    for index in #map do
        ordered_map[map[index][3]] = map[index]
    end

    return map
end

local function step_forward()
    fuel_check()
    turtle.forward()
end

local function step_back()
    fuel_check()
    turtle.back()
end

local function step_left()
    turtle.turnLeft()
    fuel_check()
    turtle.forward()
    turtle.turnRight()
end

local function step_right()
    turtle.turnRight()
    fuel_check()
    turtle.forward()
    turtle.turnLeft()
end

local function step_down()
    fuel_check()
    turtle.down()
end

local function step_up()
    fuel_check()
    turtle.up()
end

local function place_thing(thing)
    local slot = search_inventory(thing)
    turtle.select(slot)
    local success = turtle.place()
    return success
end

local function new_auto_table(dim)
    local table = {};
    for i=1, dim do
        table[i] = {__index = function(t, k)
            if i < dim then
                t[k] = setmetatable({}, table[i+1])
                return t[k];
            end
        end}
    end

    return setmetatable({}, table[1]);
end

local function find_min_table(table)
    local min = math.huge

    for key, value in pairs(table) do
        if value < min then
            min = value
        end
    end

    return min
end

local function find_max_table(table)
    local max = -100000
    for key, value in pairs(table) do
        if value > max then
            max = value
        end
    end

    return max
end

local function find_offset(table, index)
    local offset = find_min_table(table)
    if offset < 0 then
        offset = offset * -1
    end

    return offset
end


return {
    table_length = table_length,
    reverse_table = reverse_table,
    search_inventory = search_inventory,
    fuel_check = fuel_check,
    get_number = get_number,
    get_text = get_text,
    until_file_exists = until_file_exists,
    file_exists = file_exists,
    lines_from = lines_from,
    split_strings = split_strings,
    reorder_map = reorder_map,
    step_forward = step_forward,
    step_back = step_back,
    step_left = step_left,
    step_right = step_right,
    step_down = step_down,
    step_up = step_up,
    place_thing = place_thing,
    new_auto_table = new_auto_table,
    find_min_table = find_min_table,
    find_max_table = find_max_table,
    find_offset = find_offset,
}
