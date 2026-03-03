-- รายชื่อ recipe ทั้งหมดของ Tarawind Beacons 2
local tw_recipes = {
    "twBeacon1",
    "twBeacon2",
    "twBeacon3",
    "twBeacon4",
    "twBeacon5",
    "twBeacon6",
    "twBeacon7",
}

for _, recipe_name in pairs(tw_recipes) do
    local recipe = data.raw["recipe"][recipe_name]
    if recipe then
        -- เพิ่ม category "electromagnetics" ถ้ายังไม่มี
        if recipe.category == nil then
            recipe.category = "electromagnetics"
        elseif recipe.category ~= "electromagnetics" then
            -- ถ้า recipe มี category เดิมอยู่แล้ว ให้เปลี่ยนเป็น electromagnetics
            recipe.category = "electromagnetics"
        end
    end
end
