-- ============================================================
-- Planet Beacon Compatibility Fix
-- Prevent crash from missing "minable" field
-- ============================================================

local function ensure_minable(entity)
    if not entity then return end
    if entity.flags and entity.flags["not-deconstructable"] then return end

    if not entity.minable then
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


-- ------------------------------------------------------------
-- Extra safety: prevent other mods from crashing when
-- accessing entity.minable.result directly
-- ------------------------------------------------------------

for type_name, prototype_list in pairs(data.raw) do
    for _, entity in pairs(prototype_list) do
        if entity.minable and not entity.minable.result and not entity.minable.results then
            entity.minable.result = entity.name
        end
    end
end


log("Planet Beacon minable compatibility patch applied successfully.")
-- ตรวจ nil ก่อนเสมอ
local base_item = data.raw["item"]["iron-plate"]
if base_item ~= nil then
  -- ทำต่อ
end
