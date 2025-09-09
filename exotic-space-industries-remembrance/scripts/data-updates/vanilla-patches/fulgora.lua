--====================================================================================================
--Fulgora
--====================================================================================================
local fulgora = {}
local electro = ei_lib.raw["assembling-machine"]["electromagnetic-plant"]
if electro then
    electro.energy_usage = "41.4MW"
    electro.energy_source.emissions_per_minute.pollution = 12 --def 4
    electro.crafting_speed = 1.5
    electro.module_slots = 3
    table.insert(electro.crafting_categories,"ei-waver-factory")
end
--====================================================================================================
--Recycling
--====================================================================================================
--Swap superior data for simulation else nobody will ever do the space crafting chain
local recycler = ei_lib.raw.furnace.recycler
if recycler then
    recycler.result_inventory_size = 24
    ei_lib.raw.recipe["processing-unit-recycling"].results = {
        {type="item",name="ei-electronic-parts", amount_min=0,amount_max=1,probability=0.21},
        {type="item",name="ei-advanced-semiconductor", amount_min=0,amount=1,probability=0.06},
        {type="item",name="ei-simulation-data", amount_min=0,amount=1,probability=0.01},
        {type="item",name="ei-crushed-gold", amount_min=0,amount_max=1,probability=0.16},
    }
    ei_lib.raw.recipe["ei-energy-crystal-recycling"].results = {
        {type="item",name="ei-sand", amount_min=0,amount_max=1,probability=0.18},
        {type="item",name="ei-crushed-sulfur", amount_min=0,amount=1,probability=0.11},
    }
    ei_lib.raw.recipe["ei-coke-recycling"].results = {
        {type="item",name="coal", amount_min=0,amount_max=1,probability=0.17},
    }
    ei_lib.raw.recipe["scrap-recycling"].results = {
        {type="item",name="ei-iron-mechanical-parts", amount_min=0,amount_max=1,probability=0.07},
        {type="item",name="ei-copper-mechanical-parts", amount_min=0,amount_max=1,probability=0.07},
        {type="item",name="ei-steel-mechanical-parts", amount_min=0,amount_max=1,probability=0.07},
        {type="item",name="ei-iron-beam", amount_min=0,amount_max=1,probability=0.04},
        {type="item",name="ei-copper-beam", amount_min=0,amount_max=1,probability=0.03},
        {type="item",name="ei-steel-beam", amount_min=0,amount_max=1,probability=0.02},
        {type="item",name="steel-plate", amount_min=0,amount_max=1,probability=0.02},
        {type="item",name="iron-plate", amount_min=0,amount_max=1,probability=0.025},
        {type="item",name="concrete", amount_min=0,amount_max=1,probability=0.05},
        {type="item",name="ice", amount_min=0,amount_max=1,probability=0.06},
        {type="item",name="battery", amount_min=0,amount_max=1,probability=0.04},
        {type="item",name="stone", amount_min=0,amount_max=1,probability=0.025},
        {type="item",name="ei-slag", amount_min=0,amount_max=1,probability=0.02},
        {type="item",name="electronic-circuit", amount_min=0,amount_max=1,probability=0.04},
        {type="item",name="advanced-circuit", amount_min=0,amount_max=1,probability=0.03},
        {type="item",name="ei-electronic-parts", amount_min=0,amount_max=1,probability=0.03},
        {type="item",name="copper-cable", amount_min=0,amount_max=1,probability=0.02},
        {type="item",name="ei-electron-tube", amount_min=0,amount_max=1,probability=0.02},
        {type="item",name="ei-insulated-wire", amount_min=0,amount_max=1,probability=0.02},
        {type="item",name="low-density-structure", amount_min=0,amount_max=1,probability=0.01},
        {type="item",name="holmium-ore", amount_min=0,amount_max=1,probability=0.01},
        {type="item",name="rp-steam-soul", amount_min=0,amount_max=1,probability=0.005},
        {type="item",name="rp-steam-calculator", amount_min=0,amount_max=1,probability=0.005},
        {type="item",name="ei-module-part", amount_min=0,amount_max=1,probability=0.02}
    }
end
--Fulgora ruins, scrap recycling, previously below, can now be handled with merge_item
-----------------------------------------------------------------------------------------------------
--[[
replaced = {
    ["iron-gear-wheel"] = "ei-iron-mechanical-parts",
    ["iron-stick"] = "ei-iron-beam"
}

for ruin_name, ruin in pairs(data.raw["simple-entity"]) do
  if ruin.minable and ruin.minable.results then
    for i, result in ipairs(ruin.minable.results) do
      if result.type == "item" then
        local replacement = replaced[result.name]
        if replacement then
          log("ei: Replacing '"..result.name.."' with '"..replacement.."' in ruin: " .. ruin_name)
          result.name = replacement
        end
      end
    end
  end
end

for i, result in ipairs(ei_lib.raw.recipe["scrap-recycling"].results) do
    if result.type == "item" then
        local replacement = replaced[result.name]
        if replacement then
            log("ei: Replacing '"..result.name.."' with '"..replacement.."' in scrap: ")
            result.name = replacement
        end
    end
end
]]
--[[
table.insert(data.raw['simple-entity']['fulgurite'].minable.results, {
  amount_max = 1,
  amount_min = 0,
  name = "ei-alien-seed",
  type = "item"
})
]]
return fulgora