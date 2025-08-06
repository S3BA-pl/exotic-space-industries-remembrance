
local model = {}
local ei_data = require("lib/data")
local ei_lib = require("lib/lib")
local function check_data_count(fluid_contents)
    local data_count = 0
    if not fluid_contents then return 0 end

    for name, amount in pairs(fluid_contents) do
        if ei_lib.table_contains_value(ei_data.computing_types, name) then
            data_count = data_count + amount
        end
    end

    return data_count
end

local function remove_fluids(entity, fluid_contents)
    if not entity or not fluid_contents then return end

    for name, amount in pairs(fluid_contents) do
        entity.remove_fluid({ name = name, amount = amount })
    end
end
function model.update_fluid_storages()
    local debug = false
    local fluid_entities = storage.ei.fluid_entity

    if not fluid_entities then
        if debug then game.print("❌ No fluid entities.") end
        return false
    end

    -- Initialize break index if necessary
    if not storage.ei.fluid_break_index or next(fluid_entities) == nil then
        storage.ei.fluid_break_index = next(fluid_entities)
    end

    local index = storage.ei.fluid_break_index
    local pipe = fluid_entities[index]

    if not (index and pipe and pipe.valid) then
        -- Advance to next valid entry
        local next_index = next(fluid_entities, index)
        storage.ei.fluid_break_index = next_index or next(fluid_entities)
        return
    end

    local name = pipe.name
    local fluids = pipe.get_fluid_contents()
    local should_destroy = false

    if debug then
        game.print("🔍 Processing fluid entity: " .. name)
    end

    local is_data_pipe = string.sub(name, 1, 7) == "ei-data"

    local data_count = check_data_count(fluids)

    -- ❌ Data in wrong pipe
    if data_count > 0 and not is_data_pipe then
        remove_fluids(pipe, fluids)
        should_destroy = true

    -- ❌ Non-data in data pipe
    elseif is_data_pipe then
        for fname, famount in pairs(fluids) do
            if famount > 0 and not ei_lib.table_contains_value(ei_data.computing_types, fname) then
                remove_fluids(pipe, fluids)
                should_destroy = true
                break
            end
        end

    -- ✅ Insulated pipe, ignore
    elseif string.sub(name, 1, 12) == "ei-insulated" then
        -- No action

    else
        local fluidboxes = pipe.fluids_count
        local i = 1
        -- ☢️ Transform cryo-fluids and destroy heated ones
        if fluids["ei-liquid-nitrogen"] and fluids["ei-liquid-nitrogen"] > 0 then
            local amt = fluids["ei-liquid-nitrogen"]
            while i<=fluidboxes do
                pipe.remove_fluid({ name = "ei-liquid-nitrogen", amount = amt })
                pipe.set_fluid(i,{ name = "ei-nitrogen-gas", amount = amt })
                i=i+1
            end

        elseif fluids["ei-liquid-oxygen"] and fluids["ei-liquid-oxygen"] > 0 then
            local amt = fluids["ei-liquid-oxygen"]
            while i<=fluidboxes do
                pipe.remove_fluid({ name = "ei-liquid-oxygen", amount = amt })
                pipe.set_fluid(i,{ name = "ei-oxygen-gas", amount = amt })
                i=i+1
            end
        else
            for fname, _ in pairs(fluids) do
                if string.sub(fname, 1, 10) == "ei-heated-" then
                    remove_fluids(pipe, fluids)
                    should_destroy = true
                    break
                end
            end
        end
    end

    -- 💥 Destroy pipe if marked
    if should_destroy then
        local is_infinite = string.sub(name, 1, 13) == "infinity-pipe"
        if not is_infinite then
            local pos = pipe.position
            game.print({ "exotic-industries.incompatible-pipe", pipe.surface.name, pos.x, pos.y, name })
            ei_lib.crystal_echo_floating("❌ Incompatible pipe", pipe, 6000, "wrath")
            pipe.die(pipe.force)
        end
    end

    -- 🔁 Advance breakpoint
    local next_index = next(fluid_entities, index)
    storage.ei.fluid_break_index = next_index or next(fluid_entities)

    return true
end



function model.update()
    if not storage.ei.copper_beacon.master then
        return false
    end
    
    if not storage.ei.copper_beacon.script_break_point and next(storage.ei.copper_beacon.master) then
        storage.ei.copper_beacon.script_break_point,_ = next(storage.ei.copper_beacon.master)
    end

    local i = storage.ei.copper_beacon.script_break_point

    if storage.ei.copper_beacon.master[i] then
        if storage.ei.copper_beacon.master[i].entity then
            local id = storage.ei.copper_beacon.master[i].slaves.slave_assembler

            update_beacon(storage.ei.copper_beacon.slave[id].entity, storage.ei.copper_beacon.master[i].entity)
        end
    end 

    if next(storage.ei.copper_beacon.master, i) then
        storage.ei.copper_beacon.script_break_point,_ = next(storage.ei.copper_beacon.master, i)
    else 
        storage.ei.copper_beacon.script_break_point,_ = next(storage.ei.copper_beacon.master)
    end
    return true
end

--next usage
--[[
foo = {}
foo[1] = "a"
foo[2] = "b"
foo[3] = "c"
foo[4] = "d"
foo[5] = "e"
foo[6] = "f"

function update(foo, i, l)
    local k = i
    for m=1,l do
        print(foo[k])
        k,_ = next(foo, k)
        if k == nil then k,_ = next(foo) end
    end

    return k
end

print(update(foo,next(foo) ,12))
--]]


function update_beacon(slave_entity, master_entity)
    --game.print(slave_entity.energy)
    if slave_entity.energy > 0 then
        --storage.ei.copper_beacon.master[master_entity.unit_number].state = false
        master_entity.active = true
        --game.print("on")
    else
        --storage.ei.copper_beacon.master[master_entity.unit_number].state = true
        master_entity.active = false
        --game.print("off")
    end
end


function model.counts_for_fluid_handling(entity)
    -- checks if given entity should be treated as fluid handling entity
    if (entity.type == "pipe" or entity.type == "storage-tank" or entity.type == "pipe-to-ground") then
        -- dont count special pipes
        --may need this to return true since the additional data substrates required 
        --removing the filter only allowing computing power meaning technically
        --any fluid can get into the data pipe
        --if string.sub(entity.name, 1, 7) == "ei-data" then
        --    return false
        --end

        return true
    end

    return false
end

return model