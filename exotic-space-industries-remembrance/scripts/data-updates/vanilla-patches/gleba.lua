--====================================================================================================
--Gleba
--====================================================================================================
local gleba = {}
-- Biolab uses nutrients, @StephenB
local originalEnergySource = ei_lib.raw.lab.biolab.energy_source
ei_lib.raw.lab.biolab.energy_source = table.deepcopy(data.raw["assembling-machine"].biochamber.energy_source)
-- Leaving power at 300kW. Biochambers use 500kW.
-- Biochambers have -1/m pollution emission (ie they reduce pollution). Biolabs had 8/m pollution emission, but this changes it to -1/m. Captive biter spawners are also -1/m. Looking at a simple Nauvis base importing most sciences, biolabs are actually the majority of the pollution, so I'm changing it back to 8/m.
ei_lib.raw.lab.biolab.energy_source.emissions_per_minute = originalEnergySource.emissions_per_minute


--Add nutrients to ag science pack
local ag_sci_pack = ei_lib.raw.recipe["agricultural-science-pack"]
if ag_sci_pack then
	table.insert(ag_sci_pack.ingredients,{type = "item", name = "nutrients", amount = 40})
end

return gleba