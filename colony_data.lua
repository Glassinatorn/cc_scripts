-- API to fetch and present colony data
--local Colony = require("colony")
local debugging = require("debugging")

local function verify_connection()
    if colony.isValid() then
        local id = colony.getInfo().id
        print("Connected to colony: ", id)
    else
        print("Not connected to any colony..")
    end
end

local function general_data()
    local meta_data = colony.getInfo()

    local to_present = {
        name = "Colony name: " .. meta_data.name,
        location = "Location: ", --.. meta_data.location,
        happiness = meta_data.happiness,
        mourning = function ()
            if meta_data.mourning then
                return "Work in the colony is paused due to a recent death"
            else
                return "Work in the colony is not paused due to any recent death...get on it."
            end
        end,
        population = "Population: " .. meta_data.citizens,
    }

    return to_present
end

return {
    verify_connection = verify_connection,
    general_data = general_data
}
