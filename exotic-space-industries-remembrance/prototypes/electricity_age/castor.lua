ei_data = require("lib/data")

--====================================================================================================
-- CASTOR
--====================================================================================================

data:extend({
    {
        name = "ei-castor",
        type = "recipe-category",
    },
    {
        name = "ei-castor",
        type = "item",
        icon = ei_graphics_item_path.."castor.png",
        icon_size = 64,
        subgroup = "ei-nuclear-buildings",
        order = "c-a",
        place_result = "ei-castor",
        stack_size = 50
    },
    {
        name = "ei-castor",
        type = "recipe",
        category = "crafting",
        energy_required = 1,
        ingredients =
        {
            {type="item", name="advanced-circuit", amount=5},
            {type="item", name="ei-tank-2", amount=1},
            {type="item", name="ei-lead-ingot", amount=50},
            {type="item", name="steel-plate", amount=12}
        },
        results = {{type="item", name="ei-castor", amount=1}},
        enabled = false,
        always_show_made_in = true,
        main_product = "ei-castor",
    },
    {
        name = "ei-castor",
        type = "technology",
        icon = ei_graphics_tech_path.."castor.png",
        icon_size = 256,
        prerequisites = {"nuclear-power"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "ei-castor"
            }
        },
        unit = {
            count = 100,
            ingredients = ei_data.science["electricity-age"],
            time = 20
        },
        age = "electricity-age",
    },
    {
        name = "ei-castor",
        type = "assembling-machine",
        circuit_connector =  circuit_connector_definitions.create_vector(
        universal_connector_template,
        {
            { variation = 28, main_offset = util.by_pixel( 28.125, -24.5), shadow_offset = util.by_pixel( 28.125, -24.5), show_shadow = true },
            { variation = 28, main_offset = util.by_pixel( 28.125, -24.5), shadow_offset = util.by_pixel( 28.125, -24.5), show_shadow = true },
            { variation = 28, main_offset = util.by_pixel( 28.125, -24.5), shadow_offset = util.by_pixel( 28.125, -24.5), show_shadow = true },
            { variation = 28, main_offset = util.by_pixel( 28.125, -24.5), shadow_offset = util.by_pixel( 28.125, -24.5), show_shadow = true }
        }
        ),
        circuit_wire_max_distance = default_circuit_wire_max_distance,
        icon = ei_graphics_item_path.."castor.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {
            mining_time = 1,
            result = "ei-castor"
        },
        max_health = 300,
        corpse = "big-remnants",
        dying_explosion = "medium-explosion",
        collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        map_color = ei_data.colors.assembler,
        crafting_categories = {"ei-castor"},
        crafting_speed = 1,
        energy_source = {
            type = 'electric',
            usage_priority = 'tertiary',
            emissions_per_minute = { pollution = 5 }
        },
        energy_usage = "5MW",
        fixed_recipe = "ei-store-nuclear-waste",
        graphics_set = {
            animation = {
                filename = ei_graphics_entity_path.."castor.png",
                size = {512,512},
                width = 512,
                height = 512,
                shift = {0, -0.1},
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
                    filename = ei_graphics_entity_path.."castor_animation.png",
                    size = {512,512},
                    width = 512,
                    height = 512,
                    shift = {0, -0.1},
    	            scale = 0.44/2,
                    line_length = 1,
                    lines_per_file = 1,
                    frame_count = 1,
                    animation_speed = 0.6,
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
        allowed_effects = {"speed", "consumption", "pollution"},
        module_slots = 1,
    },
    {
        name = "ei-store-nuclear-waste",
        type = "recipe",
        category = "ei-castor",
        energy_required = 60,
        ingredients = {
            {type = "item", name = "ei-nuclear-waste", amount = 1},
        },
        results = {
        },
        always_show_made_in = true,
        enabled = true,
        hidden = true,
        icon = ei_graphics_item_path.."nuclear-waste.png",
        icon_size = 64,
        subgroup = "intermediate-product",
        order = "a[ei_nuclear-waste]",
    },
})