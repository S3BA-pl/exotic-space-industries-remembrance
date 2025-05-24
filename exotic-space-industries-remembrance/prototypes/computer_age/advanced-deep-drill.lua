ei_data = require("lib/data")

--====================================================================================================
--ADVANCED DEEP DRILL
--====================================================================================================

data:extend({
    {
        name = "ei-drilling",
        type = "resource-category",
    },
    {
        name = "ei-advanced-deep-drill",
        type = "item",
        icon = ei_graphics_item_path.."advanced-deep-drill.png",
        icon_size = 64,
        subgroup = "extraction-machine",
        order = "a[items]-d",
        place_result = "ei-advanced-deep-drill",
        stack_size = 50
    },
    {
        name = "ei-advanced-deep-drill",
        type = "technology",
        icon = ei_graphics_tech_path.."advanced-deep-drill.png",
        icon_size = 256,
        prerequisites = {"automation-3"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "ei-advanced-deep-drill"
            },
        },
        unit = {
            count = 100,
            ingredients = ei_data.science["advanced-computer-age"],
            time = 20
        },
        age = "alien-computer-age",
    },
    {
        name = "ei-advanced-deep-drill",
        type = "recipe",
        category = "crafting",
        energy_required = 1,
        ingredients =
        {
            {type="item", name="ei-advanced-motor", amount=16},
            {type="item", name="ei-deep-drill", amount=1},
            {type="item", name="ei-steel-mechanical-parts", amount=20}
        },
        results = {{type="item", name="ei-advanced-deep-drill", amount=1}},
        enabled = false,
        always_show_made_in = true,
        main_product = "ei-advanced-deep-drill",
    },
    {
        name = "ei-advanced-deep-drill",
        type = "mining-drill",
        icon = ei_graphics_item_path.."advanced-deep-drill.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {
            mining_time = 1,
            result = "ei-advanced-deep-drill"
        },
        max_health = 300,
        corpse = "big-remnants",
        dying_explosion = "medium-explosion",
        collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        map_color = ei_data.colors.assembler,
        fast_replaceable_group = "ei-deep-drill",
        resource_categories = {"ei-drilling"},
        module_slots = 2,
        allowed_effects = {"consumption", "speed", "productivity", "pollution"},
        energy_source = {
            type = "fluid",
            fluid_box = {   
                filter = "ei-drill-fluid",
                volume = 200,
                pipe_covers = pipecoverspictures(),
                pipe_picture = ei_pipe_big,
                pipe_connections = {
                    {direction = defines.direction.east, position = {2, 0}},
                    {direction = defines.direction.west, position = {-2, 0}},
                    {direction = defines.direction.north, position = {0, -2}},
                },
                production_type = "input-output",
            },
            effectivity = 1,
            burns_fluid = true,
            emissions_per_minute = {pollution = 20 },
            scale_fluid_usage = true,
        },
        energy_usage = "2MW",
        mining_speed = 10,
        resource_searching_radius = 0.49,
        vector_to_place_result = {0, 2.65},
		radius_visualisation_picture = 
		{
			filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-radius-visualization.png",
			width = 12,
			height = 12
		},
        --[[
        input_fluid_box = {   
            volume = 200,
            pipe_covers = pipecoverspictures(),
            pipe_picture = ei_pipe_big,
            pipe_connections = {
                {direction = defines.direction.east, position = {2, 0}},
                {direction = defines.direction.west, position = {-2, 0}},
                {direction = defines.direction.south, position = {0, 2}},
                -- {direction = defines.direction.north, position = {0, -2}},
            },
            production_type = "input-output",
            
        },
        ]]
        graphics_set = {
            animation = {
                filename = ei_graphics_entity_path.."advanced-deep-drill.png",
                size = {512,512},
                shift = {0, 0},
                scale = 0.35,
                line_length = 1,
                -- lines_per_file = 2,
                frame_count = 1,         
                -- animation_speed = 0.2, 
            },
            working_visualisations = {
                {
                    animation = {
                        layers = {
                            --[[
                            {
                                filename = ei_graphics_entity_path.."advanced-deep-drill.png",
                                size = {512,512},
                                shift = {0, 0},
                                scale = 0.35,
                                line_length = 1,
                                -- lines_per_file = 2,
                                frame_count = 1,         
                                -- animation_speed = 0.2,
                                repeat_count = 16,
                            },
                            ]]
                            {
                                filename = ei_graphics_entity_path.."advanced-deep-drill_animation.png",
                                size = {512,512},
                                shift = {0, 0},
                                scale = 0.35,
                                line_length = 4,
                                lines_per_file = 4,
                                frame_count = 16,
                                animation_speed = 0.2,
                                run_mode = "backward",
                            }            
                        }
                    }
                }   
            }
        },
        working_sound =
        {
            sound = {filename = "__base__/sound/electric-mining-drill.ogg", volume = 0.8},
            apparent_volume = 0.3,
        },
    }
})