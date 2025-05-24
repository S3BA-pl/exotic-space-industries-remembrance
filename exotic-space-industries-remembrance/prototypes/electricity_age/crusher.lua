ei_data = require("lib/data")

--====================================================================================================
--CRUSHER
--====================================================================================================

data:extend({
    {
        name = "ei-crusher",
        type = "item",
        icon = ei_graphics_item_path.."crusher.png",
        icon_size = 64,
        subgroup = "production-machine",
        order = "d-a-a-1",
        place_result = "ei-crusher",
        stack_size = 50
    },
    {
        name = "ei-crusher",
        type = "recipe",
        category = "crafting",
        energy_required = 1,
        ingredients =
        {
            {type="item", name="electronic-circuit", amount=2},
            {type="item", name="electric-engine-unit", amount=4},
            {type="item", name="ei-iron-mechanical-parts", amount=2},
            {type="item", name="ei-copper-mechanical-parts", amount=6}
        },
        results = {{type="item", name="ei-crusher", amount=1}},
        enabled = false,
        always_show_made_in = true,
        main_product = "ei-crusher",
    },
    {
        name = "ei-crusher",
        type = "technology",
        icon = ei_graphics_tech_path.."crusher.png",
        icon_size = 256,
        prerequisites = {"ei-electricity-power"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "ei-crusher"
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
        name = "ei-crusher",
        type = "assembling-machine",
        icon = ei_graphics_item_path.."crusher.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {
            mining_time = 0.5,
            result = "ei-crusher"
        },
        max_health = 300,
        corpse = "big-remnants",
        dying_explosion = "medium-explosion",
        collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        map_color = ei_data.colors.assembler,
        crafting_categories = {"ei-crushing"},
        crafting_speed = 1,
        energy_source = {
            type = 'electric',
            usage_priority = 'secondary-input',
        },
        energy_usage = "900kW",
        graphics_set = {
            animation = {
                filename = ei_graphics_entity_path.."crusher.png",
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
                    filename = ei_graphics_entity_path.."crusher_animation.png",
                    size = {512,512},
                    width = 512,
                    height = 512,
                    shift = {0,-0.2},
    	            scale = 0.44/2,
                    line_length = 4,
                    lines_per_file = 4,
                    frame_count = 16,
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
        fast_replaceable_group = "ei-crusher",
        next_upgrade = "ei-advanced-crusher",
        allowed_effects = {"speed", "productivity", "consumption", "pollution"},
        module_slots = 2,
        working_sound =
        {
            sound = {filename = "__base__/sound/electric-mining-drill.ogg", volume = 0.8},
            apparent_volume = 0.3,
        },
    }
})