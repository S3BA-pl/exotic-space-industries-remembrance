
local resource_autoplace = require("__core__/lualib/resource-autoplace")

--====================================================================================================
--DRILL DEPOSITS
--====================================================================================================

function ei_autoplace(name, rarity)

  -- default to rarity "common", other possible "rare" and "very-rare"

  local base_density = 6 -- how much on average is placed near the starting area
  local base_spots_per_km2 = 1.2 -- number of spots per km^2 near the starting area
  local has_starting_area_placement = true
  local random_spot_size_minimum = 0.5
  local random_spot_size_maximum = 1.25
  local random_probability = 1/48
  local additional_richness = 500000
  local richness_multiplier = 2
  local richness_multiplier_distance_bonus = 2.5

  if rarity == "rare" then
    has_starting_area_placement = false
    base_density = 0.4
    base_spots_per_km2 = 0.2
    random_spot_size_minimum = 0.5
    random_spot_size_maximum = 1.25
    additional_richness = 800000
  end

  if rarity == "very-rare" then
    has_starting_area_placement = false
    base_density = 0.2
    base_spots_per_km2 = 0.1
    random_spot_size_minimum = 0.2
    random_spot_size_maximum = 1
    additional_richness = 1200000
  end

  if rarity == "gaia" then
    local base_density = 1
    local base_spots_per_km2 = 1
    local has_starting_area_placement = true
    local random_spot_size_minimum = 0.5
    local random_spot_size_maximum = 1.25
    local random_probability = 1/48
    local additional_richness = 500000
    local richness_multiplier = 2
    local richness_multiplier_distance_bonus = 2
  end

  autoplace = resource_autoplace.resource_autoplace_settings
	{
		name = name,
		order = "x1",
		base_density = base_density,
		richness_multiplier = richness_multiplier,
		richness_multiplier_distance_bonus = richness_multiplier_distance_bonus,
		base_spots_per_km2 = base_spots_per_km2,
		has_starting_area_placement = has_starting_area_placement,
		random_spot_size_minimum = random_spot_size_minimum,
		random_spot_size_maximum = random_spot_size_maximum,
    random_probability = random_probability,
		regular_blob_amplitude_multiplier = 1,
		richness_post_multiplier = 1.0,
		additional_richness = additional_richness,
		regular_rq_factor_multiplier = 1,
		candidate_spot_count = 22
	}

  return autoplace

end

data:extend({
    {
        type = "resource",
        name = "ei-gold-patch",
        icon = ei_graphics_item_path.."gold-patch.png",
        icon_size = 64,
        flags = {"placeable-neutral"},
        category = "ei-drilling",
        order = "a-b-a",
        infinite = false,
        highlight = true,
        minimum = 600000,
        normal = 1200000,
        --infinite_depletion_amount = 10,
        resource_patch_search_radius = 12,
        tree_removal_probability = 1,
        tree_removal_max_distance = 32 * 32,
        minable =
        {
            mining_time = 1,
            result = "ei-gold-chunk",
        },
        collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
        --collision_mask = {"item-layer", "water-tile"},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        autoplace = ei_autoplace("ei-gold-patch", "rare"),
        stage_counts = {0},
        stages =
        {
          sheet =
          {
            filename = ei_graphics_entity_path.."gold-patch.png",
            priority = "extra-high",
            width = 975,
            height = 664,
            scale = 0.2,
            frame_count = 1,
            variation_count = 1
          }
        },
        map_color = {r=1, g=0.82, b=0.28},
        map_grid = false
    },
    {
		type = "autoplace-control",
		name = "ei-gold-patch",
		richness = true,
		order = "x1",
		category = "resource"
	},
    {
        type = "resource",
        name = "ei-lead-patch",
        icon = ei_graphics_item_path.."lead-patch.png",
        icon_size = 64,
        flags = {"placeable-neutral"},
        category = "ei-drilling",
        order = "a-b-a",
        infinite = false,
        highlight = true,
        minimum = 600000,
        normal = 1200000,
        --infinite_depletion_amount = 10,
        resource_patch_search_radius = 12,
        tree_removal_probability = 1,
        tree_removal_max_distance = 32 * 32,
        minable =
        {
            mining_time = 1,
            result = "ei-lead-chunk",
        },
        collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
        --collision_mask = {"item-layer", "water-tile"},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        autoplace = ei_autoplace("ei-lead-patch", "common"),
        stage_counts = {0},
        stages =
        {
          sheet =
          {
            filename = ei_graphics_entity_path.."lead-patch.png",
            priority = "extra-high",
            width = 594,
            height = 634,
            scale = 0.2,
            frame_count = 1,
            variation_count = 1
          }
        },
        map_color = {r=0.36, g=0.2, b=0.84},
        map_grid = false
    },
    {
		type = "autoplace-control",
		name = "ei-lead-patch",
		richness = true,
		order = "x1",
		category = "resource"
	},
    {
        type = "resource",
        name = "ei-neodym-patch",
        icon = ei_graphics_item_path.."neodym-patch.png",
        icon_size = 64,
        flags = {"placeable-neutral"},
        category = "ei-drilling",
        order = "a-b-a",
        infinite = false,
        highlight = true,
        minimum = 600000,
        normal = 1200000,
        --infinite_depletion_amount = 10,
        resource_patch_search_radius = 12,
        tree_removal_probability = 1,
        tree_removal_max_distance = 32 * 32,
        minable =
        {
            mining_time = 1,
            result = "ei-neodym-chunk",
        },
        collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
        --collision_mask = {"item-layer", "water-tile"},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        autoplace = ei_autoplace("ei-neodym-patch", "very-rare"),
        stage_counts = {0},
        stages =
        {
          sheet =
          {
            filename = ei_graphics_entity_path.."neodym-patch.png",
            priority = "extra-high",
            width = 519,
            height = 331,
            scale = 0.3,
            frame_count = 1,
            variation_count = 1
          }
        },
        map_color = {r=0.76, g=0.25, b=0.79},
        map_grid = false
    },
    {
		type = "autoplace-control",
		name = "ei-neodym-patch",
		richness = true,
		order = "x1",
		category = "resource"
	},
    {
        type = "resource",
        name = "ei-iron-patch",
        icon = ei_graphics_item_path.."iron-patch.png",
        icon_size = 64,
        flags = {"placeable-neutral"},
        category = "ei-drilling",
        order = "a-b-a",
        infinite = false,
        highlight = true,
        minimum = 600000,
        normal = 1200000,
        --infinite_depletion_amount = 10,
        resource_patch_search_radius = 12,
        tree_removal_probability = 1,
        tree_removal_max_distance = 32 * 32,
        minable =
        {
            mining_time = 1,
            result = "ei-iron-chunk",
        },
        collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
        --collision_mask = {"item-layer", "water-tile"},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        autoplace = ei_autoplace("ei-iron-patch", "common"),
        stage_counts = {0},
        stages =
        {
          sheet =
          {
            filename = ei_graphics_entity_path.."iron-patch.png",
            priority = "extra-high",
            width = 285,
            height = 243,
            scale = 0.55,
            frame_count = 1,
            variation_count = 1
          }
        },
        map_color = {r=0.25, g=0.48, b=0.79},
        map_grid = false
    },
    {
		type = "autoplace-control",
		name = "ei-iron-patch",
		richness = true,
		order = "x1",
		category = "resource"
	},
    {
        type = "resource",
        name = "ei-copper-patch",
        icon = ei_graphics_item_path.."copper-patch.png",
        icon_size = 64,
        flags = {"placeable-neutral"},
        category = "ei-drilling",
        order = "a-b-a",
        infinite = false,
        highlight = true,
        minimum = 600000,
        normal = 1200000,
        --infinite_depletion_amount = 10,
        resource_patch_search_radius = 12,
        tree_removal_probability = 1,
        tree_removal_max_distance = 32 * 32,
        minable =
        {
            mining_time = 1,
            result = "ei-copper-chunk",
        },
        collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
        --collision_mask = {"item-layer", "water-tile"},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        autoplace = ei_autoplace("ei-copper-patch", "common"),
        stage_counts = {0},
        stages =
        {
          sheet =
          {
            filename = ei_graphics_entity_path.."copper-patch.png",
            priority = "extra-high",
            width = 233,
            height = 197,
            scale = 0.6,
            frame_count = 1,
            variation_count = 1
          }
        },
        map_color = {r=0.86, g=0.50, b=0.16},
        map_grid = false
    },
    {
		type = "autoplace-control",
		name = "ei-copper-patch",
		richness = true,
		order = "x1",
		category = "resource"
	},
    {
        type = "resource",
        name = "ei-coal-patch",
        icon = ei_graphics_item_path.."coal-patch.png",
        icon_size = 64,
        flags = {"placeable-neutral"},
        category = "ei-drilling",
        order = "a-b-a",
        infinite = false,
        highlight = true,
        minimum = 600000,
        normal = 1200000,
        --infinite_depletion_amount = 10,
        resource_patch_search_radius = 12,
        tree_removal_probability = 1,
        tree_removal_max_distance = 32 * 32,
        minable =
        {
            mining_time = 1,
            result = "ei-coal-chunk",
        },
        collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
        --collision_mask = {"item-layer", "water-tile"},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        autoplace = ei_autoplace("ei-coal-patch", "common"),
        stage_counts = {0},
        stages =
        {
          sheet =
          {
            filename = ei_graphics_entity_path.."coal-patch.png",
            priority = "extra-high",
            width = 1016,
            height = 720,
            scale = 0.2,
            frame_count = 1,
            variation_count = 1
          }
        },
        map_color = {r=0.20, g=0.20, b=0.20},
        map_grid = false
    },
    {
		type = "autoplace-control",
		name = "ei-coal-patch",
		richness = true,
		order = "x1",
		category = "resource"
	},
    {
        type = "resource",
        name = "ei-uranium-patch",
        icon = ei_graphics_item_path.."uranium-patch.png",
        icon_size = 64,
        flags = {"placeable-neutral"},
        category = "ei-drilling",
        order = "a-b-a",
        infinite = false,
        highlight = true,
        minimum = 600000,
        normal = 1200000,
        --infinite_depletion_amount = 10,
        resource_patch_search_radius = 12,
        tree_removal_probability = 1,
        tree_removal_max_distance = 32 * 32,
        minable =
        {
            mining_time = 1,
            result = "ei-uranium-chunk",
        },
        collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
        --collision_mask = {"item-layer", "water-tile"},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        autoplace = ei_autoplace("ei-uranium-patch", "rare"),
        stage_counts = {0},
        stages =
        {
          sheet =
          {
            filename = ei_graphics_entity_path.."uranium-patch.png",
            priority = "extra-high",
            width = 567,
            height = 565,
            scale = 0.3,
            frame_count = 1,
            variation_count = 1
          }
        },
        map_color = {r=0.12, g=0.77, b=0.10},
        map_grid = false
    },
    {
		type = "autoplace-control",
		name = "ei-uranium-patch",
		richness = true,
		order = "x1",
		category = "resource"
	},
  {
    type = "resource",
    name = "ei-sulfur-patch",
    icon = ei_graphics_item_path.."sulfur-patch.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    category = "ei-drilling",
    order = "a-b-a",
    infinite = false,
    highlight = true,
    minimum = 600000,
    normal = 1200000,
    --infinite_depletion_amount = 10,
    resource_patch_search_radius = 12,
    tree_removal_probability = 1,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
        mining_time = 1,
        result = "ei-sulfur-chunk",
    },
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    --collision_mask = {"item-layer", "water-tile"},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    autoplace = ei_autoplace("ei-sulfur-patch", "common"),
    stage_counts = {0},
    stages =
    {
      sheet =
      {
        filename = ei_graphics_entity_path.."sulfur-patch.png",
        priority = "extra-high",
        width = 870,
        height = 781,
        scale = 0.2,
        frame_count = 1,
        variation_count = 1
      }
    },
    map_color = {r=0.69, g=0.81, b=0.45},
    map_grid = false
  },
  {
  type = "autoplace-control",
  name = "ei-sulfur-patch",
  richness = true,
  order = "x1",
  category = "resource"
  },
  --[[
  {
    type = "resource",
    name = "ei-core-patch",
    icon = ei_graphics_item_path.."core-patch.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    category = "ei-drilling",
    order = "a-b-a",
    infinite = true,
    highlight = true,
    minimum = 600000,
    normal = 1200000,
    infinite_depletion_amount = 100,
    resource_patch_search_radius = 12,
    tree_removal_probability = 1,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
        mining_time = 1,
        result = "ei-neodym-chunk",
    },
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    --collision_mask = {"item-layer", "water-tile"},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    autoplace = ei_autoplace("ei-core-patch", "gaia"),
    stage_counts = {0},
    stages =
    {
      sheet =
      {
        filename = ei_graphics_entity_path.."ground-source.png",
        priority = "extra-high",
        width = 332,
        height = 240,
        scale = 0.5,
        frame_count = 1,
        variation_count = 1
      }
    },
    map_color = {r=0.69, g=0.81, b=0.45},
    map_grid = false
  },
  {
  type = "autoplace-control",
  name = "ei-core-patch",
  richness = true,
  order = "y3",
  category = "resource"
  },
  {
  type = "noise-layer",
  name = "ei-core-patch"
  },
  ]]
  {
    type = "resource",
    name = "ei-cryoflux-patch",
    icon = ei_graphics_item_path.."cryoflux-patch.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    category = "ei-pumping",
    order = "a-b-a",
    infinite = false,
    highlight = true,
    minimum = 600000,
    normal = 1200000,
    --infinite_depletion_amount = 10,
    resource_patch_search_radius = 12,
    tree_removal_probability = 1,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_time = 1,
			results =
			{
				{
					type = "fluid",
					name = "ei-cryoflux",
					amount_min = 20,
					amount_max = 20,
					probability = 1,
				}
			},
      fluid_amount = 1,
      required_fluid = "steam"
    },
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    --collision_mask = {"item-layer", "water-tile"},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    autoplace = ei_autoplace("ei-cryoflux-patch", "gaia"),
    stage_counts = {0},
    stages =
    {
      sheet =
      {
        filename = ei_graphics_entity_path.."alien-hole-1.png",
        priority = "extra-high",
        width = 512,
        height = 512,
        scale = 0.3,
        frame_count = 1,
        variation_count = 1
      }
    },
    map_color = {r=0.0, g=0.86, b=1},
    map_grid = false
  },
  {
  type = "autoplace-control",
  name = "ei-cryoflux-patch",
  richness = true,
  order = "y2",
  category = "resource"
  },
  {
    type = "resource",
    name = "ei-phytogas-patch",
    icon = ei_graphics_item_path.."phytogas-patch.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    category = "ei-pumping",
    order = "a-b-a",
    infinite = false,
    highlight = true,
    minimum = 600000,
    normal = 1200000,
    --infinite_depletion_amount = 10,
    resource_patch_search_radius = 12,
    tree_removal_probability = 1,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_time = 1,
			results =
			{
				{
					type = "fluid",
					name = "ei-phythogas",
					amount_min = 20,
					amount_max = 20,
					probability = 1,
				}
			},
      fluid_amount = 1,
      required_fluid = "ei-acidic-water"
    },
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    --collision_mask = {"item-layer", "water-tile"},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    autoplace = ei_autoplace("ei-phytogas-patch", "gaia"),
    stage_counts = {0},
    stages =
    {
      sheet =
      {
        filename = ei_graphics_entity_path.."alien-hole-2.png",
        priority = "extra-high",
        width = 512,
        height = 512,
        scale = 0.3,
        frame_count = 1,
        variation_count = 1
      }
    },
    map_color = {r=0.23, g=1, b=0.06},
    map_grid = false
  },
  {
  type = "autoplace-control",
  name = "ei-phytogas-patch",
  richness = true,
  order = "y1",
  category = "resource"
  },
  {
    type = "resource",
    name = "ei-morphium-patch",
    icon = ei_graphics_item_2_path.."morphium-patch.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    category = "basic-fluid",
    order = "a-b-a",
    infinite = false,
    highlight = true,
    minimum = 600000,
    normal = 1200000,
    --infinite_depletion_amount = 10,
    resource_patch_search_radius = 12,
    tree_removal_probability = 1,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_time = 1,
			results =
			{
				{
					type = "fluid",
					name = "ei-morphium",
					amount_min = 20,
					amount_max = 20,
					probability = 1,
				}
			},
    },
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    --collision_mask = {"item-layer", "water-tile"},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    autoplace = ei_autoplace("ei-morphium-patch", "gaia"),
    stage_counts = {0},
    stages =
    {
      sheet =
      {
        filename = ei_graphics_entity_2_path.."morphium-patch.png",
        priority = "extra-high",
        width = 473,
        height = 267,
        scale = 0.4,
        frame_count = 1,
        variation_count = 1
      }
    },
    map_color = {r=0.04, g=0.3, b=0.3},
    map_grid = false
  },
  {
  type = "autoplace-control",
  name = "ei-morphium-patch",
  richness = true,
  order = "z1",
  category = "resource"
  },
  {
    type = "resource",
    name = "ei-ammonia-patch",
    icon = ei_graphics_item_2_path.."ammonia-patch.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    category = "ei-pumping",
    order = "a-b-a",
    infinite = false,
    highlight = true,
    minimum = 600000,
    normal = 1200000,
    --infinite_depletion_amount = 10,
    resource_patch_search_radius = 12,
    tree_removal_probability = 1,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_time = 1,
			results =
			{
				{
					type = "fluid",
					name = "ei-ammonia-gas",
					amount_min = 20,
					amount_max = 20,
					probability = 1,
				}
			},
      fluid_amount = 1,
      required_fluid = "steam"
    },
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    --collision_mask = {"item-layer", "water-tile"},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    autoplace = ei_autoplace("ei-ammonia-patch", "gaia"),
    stage_counts = {0},
    stages =
    {
      sheet =
      {
        filename = ei_graphics_entity_2_path.."ammonia-patch.png",
        priority = "extra-high",
        width = 473,
        height = 267,
        scale = 0.4,
        frame_count = 1,
        variation_count = 1
      }
    },
    map_color = {r=0.04, g=0.3, b=0.3},
    map_grid = false
  },
  {
  type = "autoplace-control",
  name = "ei-ammonia-patch",
  richness = true,
  order = "z2",
  category = "resource"
  },
  {
    type = "resource",
    name = "ei-coal-gas-patch",
    icon = ei_graphics_item_2_path.."coal-gas-patch.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    category = "ei-pumping",
    order = "a-b-a",
    infinite = false,
    highlight = true,
    minimum = 600000,
    normal = 1200000,
    --infinite_depletion_amount = 10,
    resource_patch_search_radius = 12,
    tree_removal_probability = 1,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_time = 1,
			results =
			{
				{
					type = "fluid",
					name = "ei-coal-gas",
					amount_min = 20,
					amount_max = 20,
					probability = 1,
				}
			},
      fluid_amount = 1,
      required_fluid = "steam"
    },
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    --collision_mask = {"item-layer", "water-tile"},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    autoplace = ei_autoplace("ei-coal-gas-patch", "gaia"),
    stage_counts = {0},
    stages =
    {
      sheet =
      {
        filename = ei_graphics_entity_2_path.."coal-gas-patch.png",
        priority = "extra-high",
        width = 504,
        height = 358,
        scale = 0.35,
        frame_count = 1,
        variation_count = 1
      }
    },
    map_color = {r=0.04, g=0.3, b=0.3},
    map_grid = false
  },
  {
  type = "autoplace-control",
  name = "ei-coal-gas-patch",
  richness = true,
  order = "z3",
  category = "resource"
  },
})

for _, resource_name in pairs({
  "ei-gold-patch",
  "ei-lead-patch",
  "ei-neodym-patch",
  "ei-iron-patch",
  "ei-copper-patch",
  "ei-coal-patch",
  "ei-uranium-patch",
  "ei-sulfur-patch",
}) do
  -- enable placing and control. I think.
  data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["entity"]["settings"][resource_name] = {}
  data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls[resource_name] = {}
end