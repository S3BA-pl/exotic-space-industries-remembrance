data:extend({
    {
        name = modprefix.."burner-quarry",
        type = "item",
        icon = data.raw.item["burner-mining-drill"]["icon"],
        icon_size = 64,
        icon_mipmaps = 4,
        place_result = modprefix.."burner-quarry",
        stack_size = 20,
        subgroup = "extraction-machine",
        order = "a[items]-a[ei-burner-quarry]",
    },
    
    {
        name = modprefix.."burner-quarry",
        type = "recipe",
        enabled = false,
        ingredients = {
          {type = "item", name = "iron-plate", amount = 20},
          {type = "item", name = "ei-iron-mechanical-parts", amount = 20},
          {type="item",name="ei-copper-beam",amount=10},
          {type = "item", name = "burner-mining-drill", amount = 10},
          {type = "item", name = "transport-belt", amount = 10},
        },
        results = {{type = "item", name = modprefix.."burner-quarry", amount = 1}},
        energy_required = 10,
    },

    {
        name = modprefix.."electric-quarry",
        type = "item",
        icon = data.raw.item["electric-mining-drill"]["icon"],
        icon_size = 64,
        icon_mipmaps = 4,
        place_result = modprefix.."electric-quarry",
        stack_size = 20,
        subgroup = "extraction-machine",
        order = "a[items]-b[ei-electric-quarry]",
    },
    
    {
        name = modprefix.."electric-quarry",
        type = "recipe",
        enabled = false,
        ingredients = {
          {type = "item", name = "steel-plate", amount = 20},
          {type = "item", name = "ei-steel-mechanical-parts", amount = 20},
          {type="item",name="ei-copper-beam",amount=10},
          {type = "item", name = "electric-mining-drill", amount = 10},
          {type = "item", name = "transport-belt", amount = 20},
        },
        results = {{type = "item", name = modprefix.."electric-quarry", amount = 1}},
        energy_required = 10,
    }
})

local burner_quarry = table.deepcopy(data.raw["mining-drill"]["burner-mining-drill"])
burner_quarry.name = modprefix.."burner-quarry"
burner_quarry.minable = {mining_time = 1, result = modprefix.."burner-quarry"}
burner_quarry.resource_searching_radius = 15
burner_quarry.energy_source.emissions_per_minute.pollution = burner_quarry.energy_source.emissions_per_minute.pollution * 3
burner_quarry.energy_usage = "1.1MW"
burner_quarry.energy_source.smoke =
    {
      {
        name = "smoke",
        deviation = {1.6, 1.6},
        frequency = 10,
        position = {0, 0},
        starting_frame = 0,
        starting_frame_deviation = 60,
        height = 0.5,
        height_deviation = 1,
        starting_vertical_speed = 0.01,
        starting_vertical_speed_deviation = 0.35,
      }
    }
burner_quarry.module_specification = {module_slots = 0}
burner_quarry.mining_speed = 1.5
burner_quarry.resource_drain_rate_percent = 65
burner_quarry.performance_to_activity_rate = 2.0
data:extend({burner_quarry})

local electric_quarry = table.deepcopy(data.raw["mining-drill"]["electric-mining-drill"])
electric_quarry.name = modprefix.."electric-quarry"
electric_quarry.minable = {mining_time = 1, result = modprefix.."electric-quarry"}
electric_quarry.resource_searching_radius = 15
electric_quarry.energy_usage = "1MW"
electric_quarry.mining_speed = 1.5
electric_quarry.energy_source.emissions_per_minute.pollution = electric_quarry.energy_source.emissions_per_minute.pollution * 3
electric_quarry.performance_to_activity_rate = 2.0
electric_quarry.resource_drain_rate_percent = 65
electric_quarry.icon = ei_graphics_kirazy_path.."icon/electric-mining-drill.png"
data:extend({electric_quarry})

ei_lib.add_unlock_recipe(modprefix.."burner-assembler",modprefix.."burner-quarry")

--[[
--OTHER


 --make electric powered surface miner using steam age ei_stone-quarry

 quarry = table.deepcopy(data.raw["assembling-machine"]["ei-stone-quarry"])
 quarry.name = "ei-electric-stone-quarry"
 quarry.minable.result = "ei-electric-stone-quarry"
 quarry.energy_source = {
     type = "electric",
     usage_priority = "secondary-input",
 }
 quarry.allowed_effects = {"speed", "productivity", "consumption", "pollution"}
 quarry.module_slots = 2

 data:extend({
     {
         name = "ei-electric-stone-quarry",
         type = "item",
         icons = {
             {
                 icon = ei_graphics_kirazy_path.."icon/electric-mining-drill.png",
                 icon_size = 64,
                 icon_mipmaps = 4,
             },
             {
                 icon = ei_graphics_other_path.."power_overlay.png",
                 icon_size = 64,
             }
         },
         place_result = "ei-electric-stone-quarry",
         stack_size = 20,
         subgroup = "extraction-machine",
         order = "a[items]-a[stone-quarry]-a",
     },
     quarry,
 })
 ]]