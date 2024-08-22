local excavate = require("Excavate.excavate")

-- main loop for the diggeers
function main()
    write("hi what do you want to do?")
    write("1: dig tunnel")
    write("> ")
    local msg = read()
    if msg == "1" then
        excavate.grid_of_tunnels(2, 2, 2)
    end
end

main()
