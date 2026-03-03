-- ===========================================================
--  Planet Beacon Mod  |  data.lua (Verified Fix)
-- ===========================================================

-- 1. สร้าง Item และ Entity พื้นฐาน
data:extend({
  {
    type         = "item",
    name         = "planet-beacon",
    icon         = "__planet-beacon__/graphics/icons/planet-beacon.png",
    icon_size    = 64,
    subgroup     = "module",
    order        = "z[planet-beacon]",
    place_result = "planet-beacon",
    stack_size   = 1,
    weight       = 50000
  },
  {
    type      = "beacon",
    name      = "planet-beacon",
    icon      = "__planet-beacon__/graphics/icons/planet-beacon.png",
    icon_size = 64,
    supply_area_distance     = 50,
    distribution_effectivity = 2.5,
    module_slots             = 15,
    allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
    
    animation = {
      filename = "__base__/graphics/entity/beacon/beacon-antenna.png",
      width = 54,
      height = 50,
      line_length = 8,
      frame_count = 32,
      shift = {0, -1.2},
      animation_speed = 0.5
    },
    base_picture = {
      filename = "__base__/graphics/entity/beacon/beacon-base.png",
      width = 116,
      height = 93,
      shift = {0.1, 0.2}
    },
    radius_visualisation_picture = {
      filename = "__base__/graphics/entity/beacon/beacon-radius-visualization.png",
      width = 12,
      height = 12
    },

    flags         = {"placeable-player", "player-creation"},
    collision_box = {{-1.7, -1.7}, {1.7, 1.7}},
    selection_box = {{-2.0, -2.0}, {2.0, 2.0}},
    drawing_box   = {{-2.0, -2.5}, {2.0, 2.0}},
    energy_source = {
      type = "electric",
      usage_priority = "primary-input"
    },
    energy_usage  = "50MW"
  }
})

-- 2. ส่วนของ Recipe และ Technology
local item_to_check = "twBeacon7"

if data.raw["item"] and data.raw["item"][item_to_check] then
    data:extend({
      {
        type            = "recipe",
        name            = "planet-beacon",
        enabled         = false,
        category        = "electromagnetic-plant",
        energy_required = 60,
        ingredients     = {
          { type = "item", name = item_to_check,       amount = 20  },
          { type = "item", name = "superconductor",    amount = 100 },
          { type = "item", name = "supercapacitor",    amount = 100 },
          { type = "item", name = "quantum-processor", amount = 100 }
        },
        results = {{ type = "item", name = "planet-beacon", amount = 1 }}
      },
      {
        type      = "technology",
        name      = "planet-beacon",
        icon      = "__planet-beacon__/graphics/technology/planet-beacon.png",
        icon_size = 256,
        prerequisites = {"tweffect-transmission7", "promethium-science-pack"},
        unit = {
          count       = 10000,
          ingredients = {
            {"automation-science-pack", 1}, {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}, {"production-science-pack", 1},
            {"utility-science-pack", 1}, {"space-science-pack", 1},
            {"metallurgic-science-pack", 1}, {"electromagnetic-science-pack", 1},
            {"agricultural-science-pack", 1}, {"cryogenic-science-pack", 1},
            {"aquatic-science-pack", 1}, {"promethium-science-pack", 1}
          },
          time = 60
        },
        effects = {{ type = "unlock-recipe", recipe = "planet-beacon" }}
      }
    })
end