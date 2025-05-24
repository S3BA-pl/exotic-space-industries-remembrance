local hit_effects = require("__base__.prototypes.entity.hit-effects")

local persistent_sound = {
  variations = {
    {
      filename = "__exotic-space-industries-graphics-3__/K2_ASSETS/sounds/buildings/wind-turbine-rotating.ogg",
      volume = 0.55,
    },
    {
      filename = "__exotic-space-industries-graphics-3__/K2_ASSETS/sounds/buildings/wind-turbine-rotating-2.ogg",
      volume = 0.38,
    },
  },
  aggregation = {
    max_count = 3,
    remove = false,
    count_already_playing = true,
  },
}

data:extend({
  {
    type = "recipe",
    name = "kr-wind-turbine",
    energy_required = 5,
    enabled = true,
    ingredients = {
      { type = "item", name = "iron-plate", amount = 6 },
      { type = "item", name = "iron-beam", amount = 2 },
      { type = "item", name = "iron-gear-wheel", amount = 6 },
      { type = "item", name = "copper-cable", amount = 6 },
    },
    results = { { type = "item", name = "kr-wind-turbine", amount = 1 } },
  },
  {
    type = "item",
    name = "kr-wind-turbine",
    icon = "__exotic-space-industries-graphics-3__/K2_ASSETS/icons/entities/wind-turbine.png",
    subgroup = "energy",
    order = "00[solar-panel]-a[wind-turbine]",
    place_result = "kr-wind-turbine",
    stack_size = 50,
  },
  {
    type = "electric-energy-interface",
    name = "kr-wind-turbine",
    icon = "__exotic-space-industries-graphics-3__/K2_ASSETS/icons/entities/wind-turbine.png",
    flags = { "placeable-neutral", "player-creation", "not-rotatable" },
    minable = { mining_time = 0.25, result = "kr-wind-turbine" },
    fast_replaceable_group = "wind-turbine",
    collision_box = { { -1.25, -1.25 }, { 1.25, 1.25 } },
    selection_box = { { -1.45, -1.45 }, { 1.45, 1.45 } },
    drawing_box = { { -0.5, -2 }, { 0.5, 1 } },
    energy_source = {
      type = "electric",
      buffer_capacity = "20kJ",
      usage_priority = "primary-output",
      output_flow_limit = "20kW",
      render_no_power_icon = false,
    },
    max_health = 200,
    corpse = "medium-remnants",
    damaged_trigger_effect = hit_effects.entity(),
    resistances = {
      {
        type = "fire",
        percent = 30,
      },
      {
        type = "physical",
        percent = 60,
      },
      {
        type = "impact",
        percent = 30,
      },
    },
    working_sound = {
      sound = persistent_sound,
      idle_sound = persistent_sound,
      persistent = true,
    },
    energy_production = "20kW",
    animation = {
      layers = {
        {
          filename = "__exotic-space-industries-graphics-3__/K2_ASSETS/buildings/wind-turbine/wind-turbine.png",
          priority = "medium",
          width = 196,
          height = 286,
          scale = 0.5,
          frame_count = 30,
          line_length = 6,
          animation_speed = 0.8,
          shift = { 0, -1.2 },
        },
        {
          filename = "__exotic-space-industries-graphics-3__/K2_ASSETS/buildings/wind-turbine/wind-turbine-shadow.png",
          priority = "medium",
          width = 242,
          height = 100,
          scale = 0.65,
          frame_count = 30,
          line_length = 6,
          animation_speed = 0.5,
          draw_as_shadow = true,
          shift = { 1.15, 0.05 },
        },
      },
    },
    continuous_animation = true,
    water_reflection = {
      pictures = {
        filename = "__exotic-space-industries-graphics-3__/K2_ASSETS/buildings/wind-turbine/wind-turbine-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 25,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false,
    },
  },
})
