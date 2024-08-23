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
        for slot=1,1 do
            local count = turtle.getItemDetail(slot)
            local name = turtle.getItemDetail(slot)
            print(name["name"])
        end
    end
end

main()