-- ============================================================
-- Planet Beacon Compatibility Fix
-- Prevent crash from missing "minable" field
-- ============================================================

local function item_exists(name)
  if not name then return false end
  return (data.raw["item"] and data.raw["item"][name] ~= nil)
      or (data.raw["tool"] and data.raw["tool"][name] ~= nil)
end

local function ensure_minable(entity)
    if not entity then return end
    if entity.flags and entity.flags["not-deconstructable"] then return end

    -- ตรวจว่ามี item ชื่อนั้นอยู่จริงก่อนเสมอ
    if not entity.minable and item_exists(entity.name) then
        entity.minable = {
            mining_time = 0.1,
            result = entity.name
        }
    end
end


-- ------------------------------------------------------------
-- Fix all beacon prototypes
-- ------------------------------------------------------------

if data.raw["beacon"] then
    for _, beacon in pairs(data.raw["beacon"]) do
        ensure_minable(beacon)
    end
end


-- ------------------------------------------------------------
-- Optional safety: fix simple-entity-with-owner
-- (บาง mod สร้าง beacon clone เป็น type นี้)
-- ------------------------------------------------------------

if data.raw["simple-entity-with-owner"] then
    for _, entity in pairs(data.raw["simple-entity-with-owner"]) do
        if entity.name and string.find(entity.name, "beacon") then
            ensure_minable(entity)
        end
    end
end


log("Planet Beacon minable compatibility patch applied successfully.")
