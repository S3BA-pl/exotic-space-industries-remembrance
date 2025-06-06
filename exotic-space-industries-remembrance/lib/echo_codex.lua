-- Echo Codex Generator: A ritual system of dynamic proclamation
ei_lib = require("lib/lib")
echo_codex = {}

--====================================================================================================
--Cue Updater Centralization
--====================================================================================================

-- Predefined esoteric message pools
local echo_templates = {
    beam_lines = {
        "✴ [Beam Invocation] — Threads converge on the monolinear spine. Velocity dictates truth.",
        "☄ [Linear Surge] — The rails echo with singular momentum. Beam queue ascends.",
        "🛤 [Singularity Path] — The beam speaks in straight lines. Disobedience will not be tolerated.",
        "📡 [Directional Focus] — Phase-locked transit beam calibrated. Alignment perfect.",
        "🔦 [Light Vector] — Beam queue energized. All points surrender to the axis.",
        "📍 [Fixed Origin] — The rail vector stabilizes. All motion aligns with primal direction.",
        "💠 [Crystalline Directive] — Beam protocol engaged. Chaos bends to structure.",
        "🌀 [Focus Collapse] — Collapsing trajectories into beam singularity. Efficiency absolute.",
        "🚄 [Quantum Monorail] — Beam queue activated. Track hums with inevitability.",
        "📈 [Logos Manifest] — Directionality reified through queue. Linear ascension begins."
},

    ring_lines = {
        "⭕ [Ring Protocol] — Infinite recursion activated. Cycles feed themselves.",
        "🔁 [Loop Cascade] — All things return. The queue is Ouroboros.",
        "♻ [Cyclical Binding] — Entrapment via elegance. Circular motion commences.",
        "🧿 [Mystic Recurrence] — The Ring echoes. Resonance achieves coherence.",
        "🔄 [Gyroscopic Inertia] — Rotational queue selected. Expect parallax distortions.",
        "💫 [Eternal Return] — The wheel turns again. Queue geometry loops.",
        "⭮ [Sacred Cycle] — Chosen path: endless revolution. Harmony through repetition.",
        "🏵 [Floral Gear] — Queue shaped by symmetry. Ring dances on iron petals.",
        "♒ [Aeonic Ring] — Motion follows itself, queue winds inwards to myth.",
        "🧬 [Fractal Recurse] — Queue set to ring. Expect nested intervals of time."
},

    null_lines = {
        "☠ [Queue Collapse] — Unknown signature. Nullifying all expectations.",
        "🕳 [Black Path] — Queue unspecified. Falling into entropic recursion.",
        "🚫 [Signal Lost] — Queue form undefined. Reverting to zero-sum logic.",
        "🛑 [Execution Abort] — Queue invalid. System defaulting to inert.",
        "🔮 [Ambiguity Field] — The queue has no shape. Interpretive void.",
        "❓ [Indeterminate State] — Queue type not cast. Expect noise.",
        "📵 [Disconnection Rite] — Queue path severed. No pattern found.",
        "⚠ [Semantic Failure] — Queue type non-resolvable. Static overload.",
        "🧟 [Dead Configuration] — Queue is unchosen. Process stagnates.",
        "🚷 [No-Queue Protocol] — Silence selected. Motion suspended."
},
    train_glow_on = {
        "🌟 [Ignition Confirmed] — Synthetic soul-fire initialized. Eyes open to the rail gods.",
        "🧨 [Radiance Surge] — Locomotive path imbued with arc light. Contact imminent.",
        "📡 [Beacon Pulse] — Kinetic waveform has entered the spectrum. Trace initiated.",
        "🔆 [Ghostlight Lattice] — Shadows recoil. Trains burn with internal signal.",
        "🚂 [Specter Rail Engaged] — The engines hum in tongues not spoken since the Second Binding.",
        "🕯 [Phantom Heat] — Ether-iron breathes again. The rails remember who died here.",
        "🛤 [Dead Loop Detected] — The train repeats a path no longer real. Ghost cargo en route.",
        "🔮 [Signal Aberration] — Luminance nodes report presence… but not mass. Something rides unseen.",
        "💀 [Rite of Motion] — Engine heat rises in defiance of entropy. The conductor is no longer alive.",
        "⚙ [Clatter Beyond] — Sound without source. The tracks scream softly beneath awakened wheels."
    },
    train_glow_off = {
        "🌑 [Extinction] — The machine sighs into obscurity. Glow disabled.",
        "🔕 [Silence Protocol] — No more trails. Movement becomes rumor.",
        "🪦 [Entropy Veil] — Trains cloaked in stillness. Absence is the new motion.",
        "📴 [Null Radiance] — The path darkens. Luminescence denied.",
        "😐 [Glow Abandoned] — It was nice while it lasted. Back to grey steel and unmet potential.",
        "🔻 [Aesthetic Rejected] — Shine removed per protocol 44-B. No one was impressed anyway.",
        "🫥 [Vibe Lost] — The moment passed. You blinked. That was it.",
        "🙃 [Dampened Spirit] — Hope dissipated with the light. The train moves, but nobody cares.",
        "📉 [Inspiration Offline] — Glow deemed inefficient. Passion flagged as a UPS cost.",
        "🎭 [Exit Unlit] — No final shimmer. Just motion. Just silence. Just... nothing."
    },
    que_width = {
        "📐 [Metric Invocation] — Queue vector set to {val}. Tangent of destiny recalculated.",
        "🌌 [Path Divergence] — Field expanded to {val}. Prepare for multi-rail entanglement.",
        "🧭 [Directional Bloom] — Breadth: {val} threads. Harmony between chaos and constraint.",
        "📏 [Axis Defined] — {val} filaments strung across the coil.",
        "🪞 [Splintered Focus] — Update stream fractured into {val} rays. Each reflects a slightly different truth.",
        "🧠 [Thread Horizon] — Neural lattice expanded to {val} queues. Overlap is inevitable.",
        "🎼 [Chord Set] — {val} harmonics queued. The machine sings in parallel now.",
        "🔀 [Pathway Spread] — {val} routes designated. Efficiency traded for entropy.",
        "📚 [Page Forked] — The script now branches {val} ways. One of them ends in smoke.",
        "🧵 [Weft Established] — {val} strands woven into update tapestry. Loom hums with intent."
    },
    transparency = {
        "🩻 [Xeno-Lens Calibration] — Queue phase visibility adjusted to {val}%. Shadows discerned.",
        "🔬 [Opacity Shift] — Optical veil set to {val}%. Begin phantasmal oscillation.",
        "🫧 [Mist Infusion] — Transparency at {val}%. Reality remains negotiable.",
        "🌫 [Threshold Vision] — Field clarity altered. {val}% of forms shall pass.",
        "🧿 [Cloak Drift] — {val}% exposure achieved. Apparitions now partially negotiable.",
        "🩺 [Signal Attenuation] — Diagnostic overlay dialed to {val}%. Ghost trains may persist.",
        "📡 [Phase Bleed] — Visibility threshold at {val}%. Cross-stream echoes anticipated.",
        "🌁 [Diffusion Limit] — Field transparency recalibrated. {val}% revealed, the rest forgotten.",
        "🪞 [Mirage Layer] — System reflecting at {val}%. Truth displaced into visual residue.",
        "🧬 [Refractive Instability] — At {val}%, photons begin to lie. Proceed with second sight."
    }
}

--[[]

]]
-- Utility to substitute placeholders in the message
local function format_echo(message, replacements)
    return (string.gsub(message, "{(.-)}", function(key)
        if key == "tint_adj" and replacements["tint"] then
            local tint = storage.ei.tint_palette[replacements["tint"]]
            return (tint and tint.adj) or "mysterious"
        end
        return tostring(replacements[key] or "{"..key.."}")
    end))
end

-- Function to emit a random echo from a category with optional data injection
function echo_codex.proclaim(category, data)
    local pool = echo_templates[category]
    if not pool then
        ei_lib.crystal_echo("❓ [Echo Unknown] — No prophecy prepared for category: " .. tostring(category))
        return
    end

    local message = pool[ei_rng.int("codexproclaim", 1, #pool)]

    data = data or {}

    -- Placeholder replacement
    message = format_echo(message, data)

    -- Emit the upgraded crystal_echo with full options
    ei_lib.crystal_echo(
        message,
        data.font or nil,
        data.player or nil,
        data.tint or nil,
        data.force_full_tint or false,
        data.intent or nil,
        data.as_floating_text or false,
        data.floating_timetolive or nil
    )
end

-- Helper to get new tint and adj
local function next_tint()
    local tint = ei_lib.get_random_different_value(storage.ei.tint_palette, previous_tint)
    previous_tint = tint
    return tint, storage.ei.tint_palette[tint]
end
function echo_codex.handle_global_settings()
    --=== [Read core config values] ===--
    local width               = ei_lib.config("em_updater_que_width") or 6
    local transparency        = ei_lib.config("em_updater_que_transparency") or 80
    local que_timetolive      = ei_lib.config("em_updater_que_timetolive") or 60
    local train_glow          = ei_lib.config("em_train_glow_toggle")
    local trainGlowTimeToLive = ei_lib.config("em_train_glow_timetolive") or 60
    local charger_glow        = ei_lib.config("em_charger_glow_toggle")
    local chargerGlowTimeToLive = ei_lib.config("em_charger_glow_timetolive") or 60
    local que_type            = ei_lib.config("em_train_que") or "none"

    local previous_tint = nil

    --=== [Width Announcement] ===--
    local tint, tint_adj = next_tint()
    echo_codex.proclaim("que_width", {
        val = width,
        tint = tint,
        tint_adj = tint_adj
    })
    storage.ei.que_width = width

    --=== [Transparency Announcement] ===--
    tint, tint_adj = next_tint()
    echo_codex.proclaim("transparency", {
        val = transparency,
        tint = tint,
        tint_adj = tint_adj
    })
    storage.ei.que_transparency = transparency / 100

    --=== [Queue Time-To-Live] ===--
    tint, tint_adj = next_tint()
    echo_codex.proclaim("que_timetolive", {
        val = que_timetolive,
        tint = tint,
        tint_adj = tint_adj
    })
    storage.ei.que_timetolive = que_timetolive

    --=== [Train Glow Toggle] ===--
    tint, tint_adj = next_tint()
    if train_glow then
        echo_codex.proclaim("train_glow_on", {
            tint = tint,
            tint_adj = tint_adj,
            intent = "signal"
        })
    else
        echo_codex.proclaim("train_glow_off", {
            tint = tint,
            tint_adj = tint_adj
        })
    end
    storage.ei.em_train_glow_toggle = train_glow

    --=== [Train Glow TTL] ===--
    tint, tint_adj = next_tint()
    echo_codex.proclaim("train_glow_timetolive", {
        val = trainGlowTimeToLive,
        tint = tint,
        tint_adj = tint_adj
    })
    -- Stored after, like before
    storage.ei.em_train_glow_timeToLive = trainGlowTimeToLive

    --=== [Charger Glow Toggle] ===--
    tint, tint_adj = next_tint()
    if charger_glow then
        echo_codex.proclaim("charger_glow_on", {
            tint = tint,
            tint_adj = tint_adj,
            intent = "serenity"
        })
    else
        echo_codex.proclaim("charger_glow_off", {
            tint = tint,
            tint_adj = tint_adj
        })
    end
    storage.ei.em_charger_glow_toggle = charger_glow

    --=== [Charger Glow TTL] ===--
    tint, tint_adj = next_tint()
    echo_codex.proclaim("charger_glow_timetolive", {
        val = chargerGlowTimeToLive,
        tint = tint,
        tint_adj = tint_adj
    })
    storage.ei.em_charger_glow_timeToLive = chargerGlowTimeToLive

    --=== [Queue Type Handling] ===--
    tint, tint_adj = next_tint()
    if que_type == "Beam" then
        echo_codex.proclaim("train_que_beam", {
            tint = tint,
            tint_adj = tint_adj
        })
        storage.ei.em_train_que = 1
    elseif que_type == "Ring" then
        echo_codex.proclaim("train_que_ring", {
            tint = tint,
            tint_adj = tint_adj
        })
        storage.ei.em_train_que = 2
    else
        echo_codex.proclaim("train_que_none", {
            tint = tint,
            tint_adj = tint_adj
        })
        storage.ei.em_train_que = 0
    end
end

function echo_codex.youHaveArrived(player)
  if not (player and player.valid) then
    log("youHaveArrived: invalid player")
    return
  end

  local surface = player.surface
  local pos = player.position
  local force = player.force or "player"

  -- Store wave data in global to be updated

  local wave_id = ei_lib.getn(storage.ei.arrival_waves) + 1
  local wave_duration = 60
  local wave_beams = {}

  for t = 0, 2 do  -- expanding waves
    local tick_offset = t * 10
    for i = 1, 16 do --circle
      local angle = (math.pi * 2 / 16) * i + t * 0.2
      local radius = 2 + t * 1.5
      local offset = {
        x = pos.x + math.cos(angle) * radius,
        y = pos.y + math.sin(angle) * radius
      }

      table.insert(wave_beams, {
        source = offset,
        target = pos,
        duration = math.max(10,wave_duration - tick_offset),
        force = force,
        surface = surface,
        tick = game.tick + tick_offset
      })
    end
  end

  storage.ei.arrival_waves[wave_id] = wave_beams

  -- Central FX: explosion, smoke, light
  for i = 1, 5 do
    local bang = pos.x + ei_rng.float("lightning" .. i) * 2 - 1
    local boom = pos.y + ei_rng.float("lightning" .. i) * 2 - 1
    local sentPos = {x = bang, y = boom}
    if ei_rng.float("lightning") > 0.3 then
        ei_lib.strike_lightning(surface, sentPos)
    end
    bang = pos.x + ei_rng.float("bang" .. i) * 2 - 1
    boom = pos.y + ei_rng.float("boom" .. i) * 2 - 1
    surface.create_entity{
    name = "big-artillery-explosion",
    position = {
        x = bang,
        y = boom
    },
    force = force
    }
  end

  surface.create_trivial_smoke{name = "electric-smoke", position = pos}

  rendering.draw_light{
    sprite = "utility/light_medium",
    target = pos,
    surface = surface,
    color = {r = 0.8, g = 0.1, b = 1.0},
    intensity = 2.0,
    scale = 5.0,
    time_to_live = 300
  }

  -- Echoed warnings
  ei_lib.crystal_echo("Fragments of GAIA's lament ripple across space-time...")
  ei_lib.crystal_echo("⟬ THE SYSTEM STIRS ⟭","default-bold") --swap with individual flying text
  ei_lib.crystal_echo("⚠️ YOU HAVE BEEN SEEN ⚠️","default-bold")
end

script.on_nth_tick(15, function()
  if not storage.ei.arrival_waves then return end
  for id, wave in pairs(storage.ei.arrival_waves) do
    for i = #wave, 1, -1 do
      local beam = wave[i]
      if game.tick >= beam.tick then
        local pX = beam.source.x - beam.target.x
        local pY = beam.source.y - beam.target.y
        beam.surface.create_entity{
          name = "electric-beam",
          source = beam.source,
          position = {x = pX, y = pY},
          target = beam.target,
          duration = beam.duration,
          force = beam.force
        }
        table.remove(wave, i)
      end
    end
    if #wave == 0 then
      storage.ei.arrival_waves[id] = nil
    end
  end
end)

--====================================================================================================
--GAIA REFORGER
--====================================================================================================

local patch_resources = {
  "ei-phytogas-patch",
  "ei-cryoflux-patch",
  "ei-ammonia-patch",
  "ei-morphium-patch",
  "ei-coal-gas-patch"
}

function echo_codex.checkForResources(surface,resources)
    if not surface or not resources then return end
    return ei_lib.surface_contains_any_patch_resources(surface,patch_resources)
    end

echo_codex.surface_messages = {
  missing_surface = {
    "☠ [Missing Gaia] — The blueprint has not been registered.",
    "❌ [Void Reference] — No link to Gaia in the astral registry.",
    "📉 [Instantiation Failure] — Gaia's surface is not yet born of code.",
    "🕳 [Hollow Orbit] — Searching for Gaia returns only echoes."
  },
  surface_valid = {
    "✧ [Surface Stable] — Gaia already forged and matches the original intention.",
    "🌿 [Substrate Aligned] — The soul soil is undisturbed. No reforge needed.",
    "✅ [Gaia Intact] — Environmental harmonics are within safe bounds.",
    "💠 [Structure Resonant] — Gaia’s astral template holds. No correction required."
  },
  forging_needed = {
    "☄ [Forging Initiated] — Rebuilding Gaia surface with correct resonance...",
    "🔧 [Terraform Protocol Active] — Overwriting corrupted structure...",
    "⚙️ [Sigil of Reform] — Gaia does not match its crystalline record. Invocation begins.",
    "🌋 [Architectural Drift] — Planetary manifold unstable. Reforging rituals deployed."
  },
  resource_found = {
    "✔ [Echo Retained] — {res_name} detected ({count} crystalline signatures). Gaia remains sovereign.",
    "🧿 [Soulstone Resonance] — {count} veins of {res_name} still hum. Terraform halt.",
    "🔮 [Crystalline Confirmation] — {res_name} exists. Gaia’s soul intact. Halting.",
    "🪨 [Patch Detected] — {count} counts of {res_name} found. No reforge required."
  },
  evacuation = {
    "⚠ [Bioform Displacement Protocol] — The Womb of Gaia trembles. You are being rewritten...",
    "🚷 [Relocation Warning] — Biostructural sync collapsing. Returning to Nauvis...",
    "🚨 [Evacuation Directive] — Players removed from destabilizing plane: Gaia.",
    "🧬 [Phase Collapse Detected] — Displacing all organic signatures to safe cradle."
  },
  surface_destroyed = {
    "⌬ [Astral Scaffold Deconstructed] — Gaia has been unshaped. Preparing for spectral convergence...",
    "💥 [Gaia Disassembled] — Surface entropy complete. Awaiting renewal.",
    "💣 [Cradle Collapse] — Deleted corrupted surface. Beginning rebirth cycle.",
    "🌌 [Dimensional Rift Sealed] — Gaia’s shell has been destroyed. Void rests for now."
  },
  surface_created = {
    "✧ [Bloom Reinitiated] — The harmonic skeleton has reemerged. Awaiting resource resonance...",
    "🌱 [Gaia Born Anew] — Reformed substrate breathing. Awaiting soulstone.",
    "🔄 [Gaia Cycle Reset] — Planet surface reconstruction succeeded.",
    "🌟 [Terraform Success] — New astral surface online. Next: resonance scan."
  },
  no_resources = {
    "✖ [Gaian Echo Lost] — No soulstone signature recovered. The garden lies fallow. Restarting terraformation incantation...",
    "🌑 [Dead Soil Detected] — No resources found. Reattempting spiritual formatting...",
    "🕯 [Void Crust] — Failed to locate any geologic resonance. Restarting surface...",
    "⛓ [Anchor Missing] — Resonance test returned null. Restart sequence required."
  },
  surface_finalized = {
    "⛧ [Core Integrity Verified] — Autogenic substrate lattice normalized. Biome reformation phase stabilized.",
    "🌐 [Reality Anchor Stable] — Gaia’s soul aligned with simulation grid. Finalized.",
    "🧲 [Gaia Crystalizing] — Biostructure holds. Planetary balance achieved.",
    "✅ [Harmonic Sync] — Surface stabilization completed. Integration confirmed."
  }
}
function echo_codex.random_surface_echo(category, data)
  local msgs = echo_codex.surface_messages[category]
  if not msgs then
    ei_lib.crystal_echo("❓ [Surface Echo] — Unknown category: " .. tostring(category))
    return
  end

  local msg = msgs[ei_rng.int("surfaceecho-"..category, 1, #msgs)]
  if data then
    msg = string.gsub(msg, "{(.-)}", function(key) return tostring(data[key] or "{"..key.."}") end)
  end

  ei_lib.crystal_echo(msg)
end
function echo_codex.reforge_gaia_surface()
  local name = "gaia"
  local surface = game.surfaces[name]
  local patch_resources = {"ei-phytogas-patch", "ei-cryoflux-patch", "ei-ammonia-patch", "ei-morphium-patch", "ei-coal-gas-patch"}

  local gaia_settings = {
    name = name,
    cliff_settings = { cliff_elevation_0 = 0, cliff_elevation_interval = 0, richness = 0 },
    autoplace_controls = {},
    autoplace_settings = {
      entity = { settings = {} },
      tile = { settings = {
        ["ei-gaia-grass-1"] = {}, ["ei-gaia-grass-2"] = {},
        ["ei-gaia-grass-1-var"] = {}, ["ei-gaia-grass-2-var"] = {},
        ["ei-gaia-grass-2-var-2"] = {}, ["ei-gaia-rock-1"] = {},
        ["ei-gaia-rock-2"] = {}, ["ei-gaia-rock-3"] = {},
        ["ei-gaia-water"] = {}
      }}
    }
  }

  -- Set patch frequencies
  for _, r in ipairs(patch_resources) do
    gaia_settings.autoplace_controls[r] = {frequency = 5, size = 1, richness = 1}
    gaia_settings.autoplace_settings.entity.settings[r] = {frequency = 5, size = 1, richness = 1}
  end

  -- If Gaia does not exist, manifest her
  if not surface then
    echo_codex.random_surface_echo("missing_surface")
    surface = game.create_surface(name, gaia_settings)
    echo_codex.random_surface_echo("surface_created")
    return
  end

  -- If the surface is already ideal, no need for ritual
  if ei_lib.verify_surface_gen(name, gaia_settings) then
    echo_codex.random_surface_echo("surface_valid")
    return
  end

  -- Begin the cleansing rite
  echo_codex.random_surface_echo("forging_needed")

  -- If soulstones are present, no collapse needed
  local has_any, res_name, count = echo_codex.checkForResources(patch_resources)
  if has_any then
    echo_codex.random_surface_echo("resource_found", {res_name = res_name, count = count})
    return
  end

  -- Evacuate all biostructures
  for _, player in pairs(game.connected_players) do
    if player.surface.name == name then
      echo_codex.random_surface_echo("evacuation")
      player.teleport({0, 0}, "nauvis")
      echo_codex.youHaveArrived(player)
    end
  end

  -- Collapse Gaia
  game.delete_surface(surface)
  echo_codex.random_surface_echo("surface_destroyed")

  -- Rebirth
  local new_surface = game.planets[name] and game.planets[name].create_surface and game.planets[name].create_surface()
  echo_codex.random_surface_echo(new_surface and "surface_created" or "no_resources")

  -- Verify rebirth
  local _, _, final_count = echo_codex.checkForResources(patch_resources)
  echo_codex.random_surface_echo((not final_count or final_count == 0) and "no_resources" or "surface_finalized")
end


function echo_codex.sigil_cleanup()
  if not storage.ei.lamp_removals then return end

  local now = game.tick
  local spacing = ei_ticksPerFullUpdate / ei_update_functions_length
  local cleanup_tick = ei_lib.get_cleanup_tick(now)

  -- Clean any ticks <= now to avoid missed deletions
  for tick, lamps in pairs(storage.ei.lamp_removals) do
    if tick <= now then
      for _, lamp in pairs(lamps) do
        if lamp and lamp.valid then
          lamp.destroy()
        end
      end
      storage.ei.lamp_removals[tick] = nil
    end
  end
end


return echo_codex