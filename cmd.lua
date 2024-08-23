local move = require("build.move")
local build = require("build.build_stuff")

print("test")

function main()
    write("What do you want to do?")
    write("1: build a bridge")
    write("2: print item info")
    local msg = read()

    if msg == "1" then
        build.bridge()
    elseif msg == "2" then
        local chest = peripheral.find("minecraft:chest")
        local item = -1

        for slot=1,16 do
            item = chest.getItemDetail(slot)
            write(item)
        end
    end
end

main()