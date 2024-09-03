local move = require("build.move")
local build = require("build.build_stuff")
local debugging      = require("help_functions.debugging")
local comfy = require("help_functions.comfy")

-- local model = build.read_exported_model("voxel_model.txt")
-- local converted_model = build.goxel_to_3d_table(model)
-- local material_table = build.color_to_material(converted_model)
-- print(debugging.dump_table(material_table))



function main()
    write("What do you want to do?")
    write("1: build a bridge")
    write("2: print item info")
    local msg = read()

    if msg == "1" then
        build.bridge()
    elseif msg == "2" then
        local model = build.read_exported_model("/cc_scripts/voxel_model.txt")
        local converted_model = build.goxel_to_3d_table(model)
        local material_table = build.color_to_material(converted_model)

        build.build_from_array(material_table)
    end
end

main()