ei_data = require("lib/data")

--====================================================================================================
--PLASMA HEATER
--====================================================================================================

data:extend({
    {
        name = "ei-neutron-collector",
        type = "recipe-category",
    },
    {
        name = "ei-neutron-collector",
        type = "item",
        icon = ei_graphics_item_path.."neutron-collector.png",
        icon_size = 64,
        subgroup = "ei-nuclear-buildings",
        order = "c-b",
        place_result = "ei-neutron-collector",
        stack_size = 50
    },
    {
        name = "ei-neutron-collector",
        type = "recipe",
        category = "crafting",
        energy_required = 4,
        ingredients =
        {
            {type="item", name="ei-insulated-tank", amount=1},
            {type="item", name="solar-panel", amount=4},
            {type="item", name="ei-magnet", amount=4},
            {type="item", name="ei-steel-mechanical-parts", amount=8}
        },
        results = {{type="item", name="ei-neutron-collector", amount=1}},
        enabled = false,
        always_show_made_in = true,
        main_product = "ei-neutron-collector",
    },
    {
        name = "ei-neutron-container",
        type = "recipe",
        category = "crafting",
        energy_required = 4,
        ingredients =
        {
            {type="item", name="ei-empty-cryo-container", amount=3},
            -- {type="item", name="ei-magnet", amount=2},
            {type="item", name="ei-carbon-structure", amount=1}
        },
        results = {{type="item", name="ei-neutron-container", amount=5}},
        enabled = false,
        always_show_made_in = true,
        main_product = "ei-neutron-container",
    },
    {
        name = "ei-neutron-collector",
        type = "technology",
        icon = ei_graphics_tech_path.."neutron-collector.png",
        icon_size = 256,
        prerequisites = {"ei-fusion-data"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "ei-neutron-collector"
            },
        },
        unit = {
            count = 100,
            ingredients = ei_data.science["fusion-quantum-age"],
            time = 20
        },
        age = "fusion-quantum-age",
    },
    {
        name = "ei-neutron-collector",
        type = "assembling-machine",
        icon = ei_graphics_item_path.."neutron-collector.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {
            mining_time = 1,
            result = "ei-neutron-collector"
        },
        max_health = 300,
        corpse = "big-remnants",
        dying_explosion = "medium-explosion",
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        map_color = ei_data.colors.assembler,
        crafting_categories = {"ei-neutron-collector"},
        crafting_speed = 1,
        energy_source = {
            type = 'electric',
            usage_priority = 'secondary-input',
        },
        energy_usage = "1MW",
        graphics_set = {
            animation = {
                filename = ei_graphics_entity_path.."neutron-collector.png",
                size = {512,512},
                shift = {0,-0.2},
    	        scale = 0.44/2,
                line_length = 1,
                --lines_per_file = 2,
                frame_count = 1,
                -- animation_speed = 0.2,
            },
            working_visualisations = {
                {
                  animation = 
                  {
                    filename = ei_graphics_entity_path.."neutron-collector_animation.png",
                    size = {512,512},
                    shift = {0,-0.2},
    	            scale = 0.44/2,
                    line_length = 1,
                    lines_per_file = 1,
                    frame_count = 1,
                    animation_speed = 1,
                  }
                },
                {
                    light = {
                    type = "basic",
                    intensity = 1,
                    size = 15
                    }
                }
            },
        },
        working_sound =
        {
            sound = {filename = "__base__/sound/electric-furnace.ogg", volume = 0.6},
            apparent_volume = 0.3,
        },
    },
    {
        name = "ei-charged-neutron-container",
        type = "item",
        icon = ei_graphics_item_path.."charged-neutron-container.png",
        icon_size = 64,
        subgroup = "ei-nuclear-processing",
        order = "b-b",
        stack_size = 100,
        pictures = {
            layers =
            {
              {
                size = 64,
                filename = ei_graphics_item_path.."charged-neutron-container.png",
                scale = 0.25
              },
              {
                draw_as_light = true,
                flags = {"light"},
                size = 64,
                filename = ei_graphics_item_path.."charged-neutron-container_light.png",
                scale = 0.25
              }
            }
        },
    },
    {
        name = "ei-neutron-container",
        type = "item",
        icon = ei_graphics_item_path.."neutron-container.png",
        icon_size = 64,
        subgroup = "ei-nuclear-processing",
        order = "b-a",
        stack_size = 50
    },
})

--RECIPES FOR CHARGED NEUTRON CONTAINER
------------------------------------------------------------------------------------------------------

local base_recipe = {
    name = "ei-charged-neutron-container",
    type = "recipe",
    category = "ei-neutron-collector",
    energy_required = 100,
    ingredients = {
        {type = "item", name = "ei-neutron-container", amount = 1},
    },
    results = {
        {type = "item", name = "ei-charged-neutron-container", amount = 1},
    },
    enabled = true,
    hidden = true,
    main_product = "ei-charged-neutron-container",
}

-- make recipes for 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 .. 200 percent efficiency
for i = 10, 300, 10 do
    local recipe = util.table.deepcopy(base_recipe)
    -- ei_charged-neutron-container:percentage
    recipe.name = recipe.name.."-"..i

    -- set time usage -> 100 percent <=> 10s/2, 10 percent <=> 100s
    recipe.energy_required = 1000/(i+i-10)
    data:extend({recipe})
end