-- These are just helper functions to make the code more compact and readable.

local function get_number(prompt)
    print(prompt)
    local input = io.read()
    return tonumber(input)
end

local function get_text(prompt)
    print(prompt)
    local input = io.read()
    return input
end
