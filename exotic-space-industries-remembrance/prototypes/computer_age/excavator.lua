ei_data = require("lib/data")

--====================================================================================================
--EXCAVATOR
--====================================================================================================

data:extend({
    {
        name = "ei-excavator",
        type = "recipe-category",
    },
    {
        name = "ei-excavator",
        type = "item",
        icon = ei_graphics_item_2_path.."excavator.png",
        icon_size = 64,
        subgroup = "extraction-machine",
        order = "a[items]-a[stone-quarry]-b",
        place_result = "ei-excavator",
        stack_size = 50
    },
    {
        name = "ei-excavator",
        type = "recipe",
        category = "crafting",
        energy_required = 2,
        ingredients =
        {
            -- {type="item", name="ei-electric-stone-quarry", amount=4},
            {type="item", name="ei-advanced-motor", amount=8},
            {type="item", name="steel-plate", amount=24},
            {type="item", name="ei-steel-mechanical-parts", amount=40}
        },
        results = {{type="item", name="ei-excavator", amount=1}},
        enabled = false,
        always_show_made_in = true,
        main_product = "ei-excavator",
    },
    {
        name = "ei-excavator",
        type = "technology",
        icon = ei_graphics_tech_2_path.."excavator.png",
        icon_size = 256,
        prerequisites = {"automation-3"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "ei-excavator"
            },
        },
        unit = {
            count = 100,
            ingredients = ei_data.science["alien-computer-age"],
            time = 20
        },
        age = "alien-computer-age",
    },
    {
        name = "ei-excavator",
        type = "assembling-machine",
        crafting_categories = {"ei-bio-chamber", "ei-excavator"},
        icon = ei_graphics_item_2_path.."excavator.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {
            mining_time = 2,
            result = "ei-excavator"
        },
        max_health = 1000,
        fixed_recipe = "ei-excavator-running",
        corpse = "big-remnants",
        dying_explosion = "medium-explosion",
        collision_box = {{-5.4, -5.4}, {5.4, 5.4}},
        selection_box = {{-5.5, -5.5}, {5.5, 5.5}},
        map_color = ei_data.colors.assembler,
        crafting_speed = 1,
        energy_source = {
            type = 'electric',
            usage_priority = 'secondary-input',
        },
        allowed_effects = {"speed", "consumption", "pollution", "productivity"},
        module_slots = 2,
        energy_usage = "3MW",
        fluid_boxes = {
            {   
                filter = "water",
                volume = 200,
                pipe_covers = pipecoverspictures(),
                pipe_picture = ei_pipe_big_round,
                pipe_connections = {
                    {flow_direction = "input", direction = defines.direction.east, position = {5, 0}},
                },
                production_type = "input",
            },
            {   
                filter = "ei-dirty-water",
                volume = 200,
                pipe_covers = pipecoverspictures(),
                pipe_picture = ei_pipe_big_round,
                pipe_connections = {
                    {flow_direction = "output", direction = defines.direction.west, position = {-5, 0}},
                },
                production_type = "output",
            },
        },
        graphics_set = {
            animation = {
                filename = ei_graphics_entity_2_path.."excavator.png",
                size = {512*2,512*2},
                shift = {0, 0},
    	        scale = 0.35,
                line_length = 1,
                --lines_per_file = 2,
                frame_count = 1,
                -- animation_speed = 0.2,
            },
            working_visualisations = {
                {
                  animation = 
                  {
                    filename = ei_graphics_entity_2_path.."excavator_animation.png",
                    size = {512*2,512*2},
                    shift = {0, 0},
    	            scale = 0.35,
                    line_length = 3,
                    lines_per_file = 3,
                    frame_count = 9,
                    animation_speed = 0.5,
                    run_mode = "backward",
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
            apparent_volume = 0.1,
        },
    },
    {
        name = "ei-excavator-running",
        type = "recipe",
        category = "ei-excavator",
        energy_required = 5,
        ingredients = {
            {type = "fluid", name = "water", amount = 2*5},
        },
        results = {
            {type = "fluid", name = "ei-dirty-water", amount = 2*5},
            {type = "item", name = "stone", amount = 15*5}, -- yellow belt
        },
        always_show_made_in = true,
        enabled = true,
        hidden = true,
        main_product = "stone",
    },
})