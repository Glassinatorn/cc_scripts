-- Handler to present data from the colony

local debugging = require("help_functions.debugging")
local help_chatgpt = require("help_functions.chatgpt")
local comfy = require("help_functions.comfy")
local Data = require("monitor_scripts.colony_data")

local function chatgpt(prompt)
    -- enables requests to chatgpt by writing prompt to a file and then running 
    -- a python script that reads the file and sends a request to the chatgpt 
    -- api and then returns the result to a file that this function then reads
    -- and returns the result

    -- running python script
    print("running python script")
    shell.run("python3 chatgpt.py", prompt)

    -- waiting for the file to be written by the python script
    comfy.until_file_exists("reply.txt")

    -- reading the result from the file 
    local file = io.open("reply.txt", "r")
    print("reading result from file")
    local result = file:read("*a")
    print("closing file...")
    file:close()

    return result
end

local function format_data()
    local data = Data.general_data()
    local mourning = "no"
    local attacked = "no"
    if data["mourning"] then
        mourning = "yes"
    end
    if data["raid"] then
        attacked = "yes"
    end

    return {
        data["name"],
        "Happiness: " .. tostring(data["happiness"]),
        "Recent death: " .. mourning,
        "Being attacked: " .. attacked,
        "Citizens: " .. tostring(data["curr_population"]) .. "/" .. tostring(data["max_population"]),
    }
end

local function connect_monitor()
    local directions = { "left", "down", "up", "right" }

    for i=1,#directions do
        local dir_type = peripheral.getType(directions[i])

        if dir_type == "monitor" then
            return peripheral.wrap(directions[i])
        end
    end

    return nil
end

local function print_to_monitor(monitor, to_print)
    local prev_output = term.redirect(monitor)
    monitor.clear()
    sleep(1)

    -- catching errors
    if to_print == nil then
        to_print = { "No data to display" }
    else
        if #to_print > monitor.getSize() then
            to_print = { "Too much data to display on monitor" }
        elseif #to_print == 0 then
            to_print = { "No data to display" }
        end
    else

    for i=1,#to_print do
        monitor.setCursorPos(1,i)
        print(to_print[i])
    end
    term.redirect(prev_output)
end

local function present_data(text)
    local monitor = connect_monitor()
    if monitor ~= nil then
        print_to_monitor(monitor, text)
    else
        return nil
    end
end



---------------------
-- running the code
---------------------
local gathered_colony_data = format_data()
present_data(gathered_colony_data)
local api_key = require("keys")


local prompt = "The colony is doing well. The citizens are happy and the population is panicing, write this as a story"
local story = help_chatgpt.test(prompt, api_key["openai_key"])

present_data(story)
