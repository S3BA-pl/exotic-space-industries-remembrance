ei_data = require("lib/data")

--====================================================================================================
--DATA PIPE
--====================================================================================================

data:extend({
    {
        name = "ei-data-pipe",
        type = "item",
        icon = ei_graphics_item_path.."data-pipe.png",
        icon_size = 64,
        icon_mipmaps = 4,
        subgroup = "energy-pipe-distribution",
        order = "b[pipe]-d",
        place_result = "ei-data-pipe",
        stack_size = 100
    },
    {
        name = "ei-data-pipe",
        type = "recipe",
        category = "crafting",
        energy_required = 1,
        ingredients =
        {
            {type="item", name="ei-gold-ingot", amount=2},
            {type="item", name="plastic-bar", amount=4},
            {type="item", name="ei-insulated-wire", amount=6},
        },
        results = {{type="item", name="ei-data-pipe", amount=1}},
        enabled = false,
        always_show_made_in = true,
        main_product = "ei-data-pipe",
    },
})

local pipe = util.table.deepcopy(data.raw.pipe.pipe)
pipe.name = "ei-data-pipe"
pipe.minable.result = "ei-data-pipe"
pipe.fluid_box.filter = "ei-computing-power"

-- loop over pictures and swap first part of filename with ei_graphics_insulated_path
-- if filename has pipe in it, without the path part:
-- set hr version to nil and double scale, size of normal version
for k, v in pairs(pipe.pictures) do
    if v.filename then
        local filename = v.filename:match("^.+/(.+)$")
        if filename ~= "visualization.png" and filename ~= "disabled-visualization.png" then
            if filename == "steam.png" or filename == "fluid-background.png" then
                v.filename = ei_graphics_data_pipe_path.."hr-"..filename
            else
                v.filename = ei_graphics_data_pipe_path..filename
            end
        end
    end
end

data:extend({
    pipe
})
