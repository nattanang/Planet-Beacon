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
-- FIX #9: ป้องกัน crash ใน loop - ตรวจ type เป็น table ก่อน
-- และตรวจ entity เป็น table + มี minable ก่อน access fields
-- ------------------------------------------------------------

for type_name, prototype_list in pairs(data.raw) do
    if type(prototype_list) == "table" then
        for _, entity in pairs(prototype_list) do
            if type(entity) == "table"
              and entity.minable
              and type(entity.minable) == "table"
              and not entity.minable.result
              and not entity.minable.results
              and entity.name
            then
                entity.minable.result = entity.name
            end
        end
    end
end


log("Planet Beacon minable compatibility patch applied successfully.")
