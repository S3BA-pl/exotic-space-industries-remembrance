
local model = {}
local ei_data = require("lib/data")
local ei_lib = require("lib/lib")
--determines if fluid entities get added to storage.ei.fluid_entity
function model.counts_for_fluid_handling(entity)
    -- checks if given entity should be treated as fluid handling entity
    -- infinity pipe is its own type
    if (entity.type == "pipe" or entity.type == "storage-tank" or entity.type == "pipe-to-ground") then
        return true
    elseif (entity.type == "furnace") then
        if entity.name == "elevated-pipe" then
            return true
        end
    else
        return false
    end
end

--checks for data substrates
local function check_data_count(fluid_contents)
    local data_count = 0
    if not fluid_contents then return 0 end

    for name, amount in pairs(fluid_contents) do
        if ei_lib.table_contains_value(ei_data.computing_types, name) then
            data_count = data_count + amount
            break
        end
    end

    return data_count
end

--individually removes fluids
local function remove_fluids(entity, fluid_contents)
    if not entity or not fluid_contents then return end
    entity.clear_fluid_inside()
--    for name, amount in pairs(fluid_contents) do
--        entity.remove_fluid({ name = name, amount = amount })
--    end
end

--Checks if fluid_entity[fluid_break_index] needs exploded, degraded, etc, advances to next entry in table
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

    --Data pipe?
    local is_data_pipe = string.sub(name, 1, 7) == "ei-data"
    --Data substrates?
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
        -- ☢️ Transform cryo-fluids and destroy heated ones
        if fluids["ei-liquid-nitrogen"] and fluids["ei-liquid-nitrogen"] > 0 then
            local amt = fluids["ei-liquid-nitrogen"]
            remove_fluids(pipe,fluids)
            if not game.is_multiplayer() then
                pipe.insert_fluid({ name = "ei-nitrogen-gas", amount = amt })
            else
                should_destroy = true
            end

        elseif fluids["ei-liquid-oxygen"] and fluids["ei-liquid-oxygen"] > 0 then
            local amt = fluids["ei-liquid-oxygen"]
            remove_fluids(pipe,fluids)
            if not game.is_multiplayer() then
                pipe.insert_fluid({ name = "ei-oxygen-gas", amount = amt })
            else
                should_destroy = true
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
        local pos = pipe.position
        game.print({ "exotic-industries.incompatible-pipe", pipe.surface.name, pos.x, pos.y, name })
        ei_lib.crystal_echo_floating("❌ Incompatible pipe", pipe, 6000, "wrath")
        pipe.die(pipe.force)
    end

    -- 🔁 Advance breakpoint
    local next_index = next(fluid_entities, index)
    storage.ei.fluid_break_index = next_index or next(fluid_entities)

    return true
end


--advances powered beacon breakpoint, updates if beacon and slave fluidbox valid
function model.update()
    local debug = false
    local copper_beacon = storage.ei.copper_beacon

    if not copper_beacon or not copper_beacon.master then
        if debug then game.print("Copper beacon or master table missing") end
        return false
    end

    if debug then
        for k, v in pairs(storage.ei.copper_beacon.master) do
            game.print("Master key: " .. tostring(k) .. " | Entity valid: " .. tostring(v.entity and v.entity.valid))
        end
    end

    local masters = copper_beacon.master
    if not next(masters) then
        if debug then game.print("No registered master entities") end
        return false
    end

    local break_point = copper_beacon.script_break_point

    -- Ensure break point is a valid key in masters
    if not break_point or not masters[break_point] then
        break_point = next(masters)
        copper_beacon.script_break_point = break_point
        if debug then game.print("Reset breakpoint to: " .. tostring(break_point)) end
    end

    local current_master = masters[break_point]
    local entity = current_master and current_master.entity

    if not (entity and entity.valid) then
        if debug then game.print("Current master entity is invalid or missing") end

        -- Skip ahead to next valid entry
        local next_key = next(masters, break_point)
        if not next_key then
            next_key = next(masters) -- restart from beginning
        end
        copper_beacon.script_break_point = next_key

        return false
    end

    if debug then game.print("Processing master entity: " .. entity.name) end

    local slave_id = current_master.slaves and current_master.slaves.slave_assembler
    local slave_data = copper_beacon.slave and copper_beacon.slave[slave_id]

    if slave_data and slave_data.entity and slave_data.entity.valid then
        if debug then game.print("Updating beacon from slave: " .. slave_data.entity.name) end
        update_beacon(slave_data.entity, entity, debug)
    else
        if debug then game.print("Slave data missing or invalid for master: " .. entity.name) end
    end

    -- Advance break point
    local next_key = next(masters, break_point)
    copper_beacon.script_break_point = next_key or next(masters)

    return true
end


function update_beacon(slave_entity, master_entity, debug)
    if not slave_entity or not master_entity then
        if debug then game.print("❌ invalid slave or master") end
        return end

    -- Toggle master active state based on slave activit
    -- only toggle state if necessary
    if slave_entity.energy > 0 then
        if not master_entity.active then
            master_entity.active = true
            if debug then game.print("✅ Beacon ON") end
        else
            if debug then game.print("✅ Beacon remains ON") end
        end
    else
        if master_entity.active then
            master_entity.active = false
            if debug then game.print("❌ Beacon OFF") end
        else
            if debug then game.print("❌ Beacon remains OFF") end
        end
    end
end

return model

--[[
--og code for reference
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
]]
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