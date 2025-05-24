local model = {}

--====================================================================================================
--GAIA
--====================================================================================================

local tile_settings = {
}

local entity_settings = {
    ["tree-01"] = {frequency = 0, size = 0, richness = 0},
    ["tree-02"] = {frequency = 0, size = 0, richness = 0},
    ["tree-05"] = {frequency = 0, size = 0, richness = 0},
    ["tree-09"] = {frequency = 0, size = 0, richness = 0},
}

local decorative_settings = {
    ["green-pita"] = {frequency = 0.1, size = 1, richness = 1},
}

-- buildings that will get destroyed on gaia
model.destroy_gaia = {
    -- ["offshore-pump"] = true,
}

-- buildings that will get destroyed on non gaia
model.destroy_non_gaia = {
    -- ["ei-gaia-pump"] = true,
}

-- buildings that will get swapped to gaia version
model.swap_gaia = {
    ["ei-crystal-accumulator"] = "ei-crystal-accumulator-gaia",
    ["offshore-pump"] = "ei-gaia-pump"
}


-- happens 10 times in total before the entity is destroyed
model.hour = 60 * 60 * 60

model.entity_damage_ticks = {
  
}

local presets = require("lib/spawner_presets")

--====================================================================================================
--UTIL
--====================================================================================================

function model.entity_check(entity)

    if not storage.gaia_surfaces then 
      storage.gaia_surfaces = {}
      storage.gaia_surfaces['gaia'] = true 
    end

    if entity == nil then
        return false
    end

    if not entity.valid then
        return false
    end

    return true
end


--ENTITY LIFETIMES AND REGISTER
------------------------------------------------------------------------------------------------------

function model.register_entity(entity, overload)

    overload = overload or false

    if not model.entity_check(entity) then
        return
    end

    -- this a player built entity?
    if not entity.last_user then
        if not overload then
            return
        end
    end

    if not storage.ei.damage_ticks then
        storage.ei.damage_ticks = {}
    end

    if not model.entity_damage_ticks[entity.name] then
        return
    end

    -- register the entity for lifetime
    table.insert(storage.ei.damage_ticks, {
        ["entity"] = entity,
        ["update_tick"] = game.tick + model.entity_damage_ticks[entity.name],
        ["damage"] = 90
    })

end


function model.update_entity_lifetimes()

    if not storage.ei.damage_ticks then
        return
    end

    local damage_ticks = storage.ei.damage_ticks
    local new_update = {}

    -- apply damage to entities that are registered
    for i,v in ipairs(damage_ticks) do
       local entity = v.entity
       local update_tick = v.update_tick
       local damage = v.damage
        
        if not model.entity_check(entity) then
            goto continue
        end

        if update_tick > game.tick then
            goto continue
        end

        -- apply damage
        if damage > 10 then
            damage = damage - 10
            
            rendering.draw_text{
                text = tostring(damage).."%",
                surface = entity.surface,
                target = entity,
                color = {r=0, g=0.86, b=0.1},
                scale = 1.25,
                target_offset = {0, 0.5},
                alignment = "center",
                scale_with_zoom = false,
                time_to_live = model.entity_damage_ticks[entity.name]+1,
            }
        else
            model.degrade_building(entity)
            goto continue
        end
        

        table.insert(new_update, {
            ["entity"] = entity,
            ["update_tick"] = game.tick + model.entity_damage_ticks[entity.name],
            ["damage"] = damage
        })

        ::continue::

    end

    -- add new entities to the update list
    for i,v in ipairs(new_update) do
        table.insert(damage_ticks, v)
    end
    
    -- remove old entities from the update list
    while true do
        if not model.remove_search_tick(storage.ei.damage_ticks, game.tick) then
            break
        end
    end

end


function model.remove_search_tick(foo, tick)

    for i,v in ipairs(foo) do
        if v.update_tick == tick then
            table.remove(foo, i)
            return true
        end
    end

    return false

end


function model.degrade_building(entity)

    -- if there is an unrepaired version of this building then create it
    -- destroy original building

    if not model.entity_check(entity) then
        return
    end

    -- check if this entity is in ei_data.repair_tools
    for i,v in pairs(ei_data.repair_tools) do
        if v.result == entity.name then
            local new_entity,_ = next(v.targets)
            entity.surface.create_entity({
                name = new_entity,
                position = entity.position,
                force = entity.force,
                direction = entity.direction,
                create_build_effect_smoke = false,
                raise_built = false,
            })
            break
        end
    end

    -- also print warning
    game.print({"exotic-industries.building-degraded", entity.name, entity.position.x, entity.position.y})

    entity.destroy()

end

--GAIA RELATED ENTITY SWAPS
------------------------------------------------------------------------------------------------------

function model.swap_entity(entity)
    -- swap an entity to its gaia version if placed on gaia

    if not model.entity_check(entity) then return end

    if not storage.gaia_surfaces[entity.surface.name] then return end
    if not model.swap_gaia[entity.name] then return end

    local swap_entity = entity.surface.create_entity({
        name = model.swap_gaia[entity.name],
        position = entity.position,
        force = entity.force,
        direction = entity.direction,
        create_build_effect_smoke = false,
        raise_built = false,
    })

    entity.destroy()

end

--NON GAIA BUILDING DESTRUCTION
------------------------------------------------------------------------------------------------------

function model.create_drop(entity)

    if not model.entity_check(entity) then return end

    -- create an item drop of this entity at its pos
    -- that is marked for deconstruction

    local surface = entity.surface
    local pos = entity.position
    local drop_name = entity.name -- only works if item name is the same as entity name

    -- create the drop
    local drop = surface.create_entity({
        name = "item-on-ground",
        position = pos,
        stack = {name = drop_name, count = 1}
    })

    -- mark the drop for deconstruction
    drop.order_deconstruction(entity.force)

end


function model.destroy_building(entity)

    local destroy_gaia = model.destroy_gaia
    local destroy_non_gaia = model.destroy_non_gaia
    local surface = entity.surface

    if destroy_gaia[entity.name] then

        if storage.gaia_surfaces[surface.name] then

            -- game.print(serpent.block(storage.gaia_surfaces))
            -- create flying text
            rendering.draw_text{
                target = entity.position,
                text = "Can't build on Gaia!",
                color = {r=1, g=0, b=0},
                surface = entity.surface,
                scale = 1,
                time_to_live = 120
            }
            model.create_drop(entity)

            entity.destroy()
            return
        end

    end

    if destroy_non_gaia[entity.name] then

        if not storage.gaia_surfaces[surface.name] then

            -- game.print(serpent.block(storage.gaia_surfaces))
            -- create flying text
            rendering.draw_text{
                target = entity.position,
                text = "Can only be built on Gaia!",
                color = {r=1, g=0, b=0},
                surface = entity.surface,
                scale = 1,
                time_to_live = 120
            }
            model.create_drop(entity)

            entity.destroy()
            return
        end

    end
end

--DEV COMMANDS
------------------------------------------------------------------------------------------------------

-- give the player the spawner tool, when creating a new player
function model.spawn_command(event)

    if not event.player_index then
        return
    end

    local player = game.get_player(event.player_index)
    
    if event.command == "gaia" then
        game.print("Spawning Gaia")

        model.create_gaia()
        player.teleport({0,0}, "gaia")
    end
    
end


--====================================================================================================
--HANDLERS
--====================================================================================================

function model.on_built_entity(entity)

    if model.entity_check(entity) == false then
        return
    end

    model.destroy_building(entity)
    model.swap_entity(entity)
    model.register_entity(entity)

end


function model.update()

    model.update_entity_lifetimes()

end


return model