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

local function until_file_exists(filename)
    while not fs.exists(filename) do
        os.sleep(1)
    end
    return true
end

return {
    get_number = get_number,
    get_text = get_text,
    until_file_excists = until_file_exists
}
