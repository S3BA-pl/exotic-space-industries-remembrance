--====================================================================================================
--Aquilo
--====================================================================================================
local aquilo = {}
local cryo = ei_lib.raw["assembling-machine"]["cryogenic-plant"]
if cryo then
    cryo.energy_usage = "31MW"
    cryo.energy_source.emissions_per_minute.pollution = 18 --def 6
    cryo.crafting_speed = 1.5
    cryo.module_slots = 4
    table.insert(cryo.crafting_categories,"ei-cooler")
end

return aquilo

