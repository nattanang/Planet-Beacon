-- ===========================================================
--  Planet Beacon Mod  |  control.lua
--  จำกัดให้วางได้แค่ 1 อันต่อ planet/surface
-- ===========================================================

local function check_and_remove(entity, player_index)
  -- FIX #1: ตรวจ nil / invalid ก่อนเสมอ
  if not entity or not entity.valid then return end
  if entity.name ~= "planet-beacon" then return end

  local surface  = entity.surface
  -- FIX #2: เก็บ position ก่อน destroy เพื่อป้องกัน access หลัง entity หาย
  local position = entity.position
  local existing = surface.find_entities_filtered{ name = "planet-beacon" }

  if #existing > 1 then
    -- FIX #3: destroy ก่อน แล้วค่อย give item กลับ (ปลอดภัยกว่า)
    entity.destroy()

    if player_index then
      local player = game.players[player_index]
      -- FIX #4: ตรวจ player.valid ด้วย
      if player and player.valid then
        player.insert{ name = "planet-beacon", count = 1 }
        player.print(
          "[Planet Beacon] Only one Planet Beacon is allowed per planet!",
          { r = 1, g = 0.3, b = 0.3 }
        )
      else
        surface.spill_item_stack(
          position,
          { name = "planet-beacon", count = 1 },
          true
        )
      end
    else
      surface.spill_item_stack(
        position,
        { name = "planet-beacon", count = 1 },
        true
      )
    end
  end
end

script.on_event(defines.events.on_built_entity, function(e)
  check_and_remove(e.entity, e.player_index)
end)

script.on_event(defines.events.on_robot_built_entity, function(e)
  check_and_remove(e.entity, nil)
end)

script.on_event(defines.events.script_raised_built, function(e)
  check_and_remove(e.entity, nil)
end)
