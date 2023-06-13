-- Handler to present data from the colony

local debugging = require("help_functions.debugging")
local chatgpt = require("help_functions.chatgpt")
local Data = require("monitor_scripts.colony_data")

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
--
local gathered_colony_data = format_data()
present_data(gathered_colony_data)


local api_keys = require("keys")
if api_keys == nil then
    print("No api key found")
    return nil
end

local news = chatgpt.gatherResponse("The colony is doing well. The citizens are happy. The colony is not being attacked. Use that to make a story", api_keys["openai_api"])
local test_fetch = chatgpt.get_page("https://www.svd.se")

debugging.print_table(test_fetch)

present_data(news)
