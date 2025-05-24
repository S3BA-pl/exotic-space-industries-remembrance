ei_data = require("lib/data")

--====================================================================================================
--STEAM CRUSHER
--====================================================================================================

data:extend({
    {
        name = "ei-crushing",
        type = "recipe-category",
    },
    {
        name = "ei-steam-crusher",
        type = "item",
        icon = ei_graphics_item_path.."steam-crusher.png",
        icon_size = 64,
        subgroup = "production-machine",
        order = "a",
        place_result = "ei-steam-crusher",
        stack_size = 50
    },
    {
        name = "ei-steam-crusher",
        type = "recipe",
        category = "crafting",
        energy_required = 1,
        ingredients =
        {
            {type="item", name="pipe", amount=6},
            {type="item", name="ei-iron-mechanical-parts", amount=4},
            {type="item", name="ei-steam-engine", amount=4},
            {type="item", name="ei-copper-mechanical-parts", amount=2}
        },
        results = {{type="item", name="ei-steam-crusher", amount=1}},
        enabled = false,
        always_show_made_in = true,
        main_product = "ei-steam-crusher",
    },
    {
        name = "ei-steam-crusher",
        type = "technology",
        icon = ei_graphics_tech_path.."steam-crusher.png",
        icon_size = 256,
        prerequisites = {"ei-steam-power", "ei-coke-processing"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "ei-steam-crusher"
            },
            {
                type = "unlock-recipe",
                recipe = "ei-crushed-iron-plate"
            },
            {
                type = "unlock-recipe",
                recipe = "ei-crushed-iron-mechanical-parts"
            },
            {
                type = "unlock-recipe",
                recipe = "ei-crushed-coke"
            },
            {
                type = "unlock-recipe",
                recipe = "ei-crushed-iron"
            }
        },
        unit = {
            count = 100,
            ingredients = ei_data.science["steam-age"],
            time = 20
        },
        age = "steam-age",
    },
    {
        name = "ei-steam-crusher",
        type = "assembling-machine",
        icon = ei_graphics_item_path.."steam-crusher.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {
            mining_time = 0.5,
            result = "ei-steam-crusher"
        },
        max_health = 300,
        corpse = "big-remnants",
        dying_explosion = "medium-explosion",
        collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        map_color = ei_data.colors.assembler,
        crafting_categories = {"ei-crushing"},
        crafting_speed = 0.5,
        energy_source = {
            type = "fluid",
            fluid_box = {   
                filter = "steam",
                volume = 200,
                pipe_covers = pipecoverspictures(),
                pipe_picture = ei_pipe_steam,
                pipe_connections = {
                    {flow_direction = "input-output", direction = defines.direction.north, position = {0, -1}},
                    {flow_direction = "input-output", direction = defines.direction.south, position = {0, 1}}
                },
                production_type = "input-output",
            },
            effectivity = 0.3,
            scale_fluid_usage = true,
        },
        fast_replaceable_group = "ei-crusher",
        next_upgrade = "ei-crusher",
        energy_usage = "50kW",
        graphics_set = {
            animation = {
                filename = ei_graphics_entity_path.."steam-crusher.png",
                size = {512,512},
                width = 512,
                height = 512,
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
                    filename = ei_graphics_entity_path.."steam-crusher_animation.png",
                    size = {512,512},
                    width = 512,
                    height = 512,
                    shift = {0,-0.2},
    	            scale = 0.44/2,
                    line_length = 4,
                    lines_per_file = 4,
                    frame_count = 16,
                    animation_speed = 0.6,
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
            sound = {filename = "__base__/sound/electric-mining-drill.ogg", volume = 0.8},
            apparent_volume = 0.3,
        },
    }
})