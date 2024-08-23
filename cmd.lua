local move = require("build.move")
local build = require("build.build_stuff")

print("test")

function main()
    write("What do you want to do?")
    write("1: build a bridge")
    local msg = read()

    if msg == "1" then
        build.bridge()
    end
end

main()