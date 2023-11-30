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

local function file_exists(filename)
    local file = io.open(filename, "rb")
    if file then
        file:close()
    end
    return file ~= nil
end

local function lines_from(filename)
    if not file_exists(filename)
        return {}
    end

    local lines = {}
    for line in io.lines(filename) do
        lines[#lines+1] = line
end

local function split_strings(input_string)
    local words = {}
    for word in string.match(input_string, "%S+") do
        table.insert(words, word)
    end

    return words
end

return {
    get_number = get_number,
    get_text = get_text,
    until_file_exists = until_file_exists,
    file_exists = file_exists,
    lines_from = lines_from,
    split_strings = split_strings,
}
