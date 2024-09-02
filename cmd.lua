local move = require("build.move")
local build = require("build.build_stuff")
local loader = require("help_functions.obj_loader")
local help_functions = require("help_functions.debugging")

-- print("test")
-- 
-- function main()
--     write("What do you want to do?")
--     write("1: build a bridge")
--     write("2: print item info")
--     local msg = read()
-- 
--     if msg == "1" then
--         build.bridge()
--     elseif msg == "2" then
--         local thing = {
--             {
--                 {"x", "x", "y", "x", "y", "x", "y", "x", "x"},
--                 {"x", "x", "y", "x", "y", "x", "y", "x", "x"},
--                 {"x", "x", "y", "x", "y", "x", "y", "x", "x"},
--                 {"x", "x", "y", "x", "x", "x", "y", "x", "x"},
--                 {"x", "x", "x", "x", "x", "x", "x", "x", "x"},
--                 {"x", "x", "x", "x", "x", "x", "x", "x", "x"},
--             },
--             {
--                 {"x", "y", "y", "y", "x", "y", "y", "y", "x"},
--                 {"x", "y", "y", "y", "x", "y", "y", "y", "x"},
--                 {"x", "y", "y", "y", "x", "y", "y", "y", "x"},
--                 {"x", "x", "y", "x", "x", "x", "y", "x", "x"},
--                 {"x", "x", "x", "x", "x", "x", "x", "x", "x"},
--                 {"x", "x", "x", "x", "x", "x", "x", "x", "x"},
--             },
--             {
--                 {"x", "y", "y", "y", "x", "y", "y", "y", "x"},
--                 {"x", "x", "y", "x", "x", "x", "y", "x", "x"},
--                 {"x", "x", "y", "x", "x", "x", "y", "x", "x"},
--                 {"x", "x", "y", "x", "x", "x", "y", "x", "x"},
--                 {"x", "x", "x", "x", "x", "x", "x", "x", "x"},
--                 {"x", "x", "x", "x", "x", "x", "x", "x", "x"},
--             },
--         }
--         build.build_from_array(thing)
--     end
-- end
-- 
-- main()