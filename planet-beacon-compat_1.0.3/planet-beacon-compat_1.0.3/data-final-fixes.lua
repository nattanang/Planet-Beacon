-- =========================================================
-- Planet Beacon + TarawindBeacons2 Compatibility Bridge
-- Factorio 2.0 / Space Age Safe Version
-- =========================================================


-- =========================================================
-- 1. Fix ALL removed Factorio logo items (1-64 tiles)
-- =========================================================

local function ensure_dummy_item(name)
    if not data.raw.item[name] then
        data:extend({
        {
            type = "item",
            name = name,
            icon = "__base__/graphics/icons/iron-plate.png",
            icon_size = 64,
            stack_size = 1
        }})
    end
end

-- Generate dummy items for all possible tile sizes
for i = 1, 64 do
    ensure_dummy_item("factorio-logo-" .. i .. "tiles")
end



-- =========================================================
-- 2. Safe minable protection (prevents nil crash)
-- =========================================================

local function safe_minable(entity)
    if not entity then return end
    if entity.flags and entity.flags["not-deconstructable"] then return end

    if not entity.minable then
        entity.minable = {
            mining_time = 0.1,
            result = entity.name
        }
    elseif not entity.minable.result and not entity.minable.results then
        entity.minable.result = entity.name
    end
end



-- =========================================================
-- 3. Fix ALL beacon prototypes
-- =========================================================

if data.raw["beacon"] then
    for _, beacon in pairs(data.raw["beacon"]) do
        safe_minable(beacon)
    end
end



-- =========================================================
-- 4. Extra safety for cloned beacons
-- =========================================================

if data.raw["simple-entity-with-owner"] then
    for _, entity in pairs(data.raw["simple-entity-with-owner"]) do
        if entity.name and string.find(entity.name, "beacon") then
            safe_minable(entity)
        end
    end
end



-- =========================================================
-- 5. Prevent global minable.result nil crash
-- =========================================================

for _, prototype_list in pairs(data.raw) do
    for _, entity in pairs(prototype_list) do
        if entity.minable and not entity.minable.result and not entity.minable.results then
            entity.minable.result = entity.name
        end
    end
end



-- =========================================================
-- 6. Prevent duplicate beacon name crash
-- =========================================================

local seen = {}

if data.raw["beacon"] then
    for name, beacon in pairs(data.raw["beacon"]) do
        if seen[name] then
            local new_name = name .. "-bridge"
            beacon.name = new_name
            if beacon.minable then
                beacon.minable.result = new_name
            end
        else
            seen[name] = true
        end
    end
end


log("Planet + Tarawind 2.0 compatibility bridge loaded successfully.")