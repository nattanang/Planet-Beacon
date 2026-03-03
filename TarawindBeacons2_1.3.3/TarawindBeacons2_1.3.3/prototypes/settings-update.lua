--expensive mode
if settings.startup["TBRE-Expensive"].value == true then
data.raw["recipe"]["twBeacon1"]["ingredients"] = {
      {type="item", name="beacon", amount=10},
      {type="item", name="processing-unit", amount=10}
}
data.raw["recipe"]["twBeacon2"]["ingredients"] = {
      {type="item", name="twBeacon1", amount=10},
      {type="item", name="processing-unit", amount=15}
}
data.raw["recipe"]["twBeacon3"]["ingredients"] = {
      {type="item", name="twBeacon2", amount=10},
      {type="item", name="processing-unit", amount=20}
}
data.raw["recipe"]["twBeacon4"]["ingredients"] = {
      {type="item", name="twBeacon3", amount=10},
      {type="item", name="processing-unit", amount=25}
}
data.raw["recipe"]["twBeacon5"]["ingredients"] = {
      {type="item", name="twBeacon4", amount=10},
      {type="item", name="processing-unit", amount=30}
}
data.raw["recipe"]["twBeacon6"]["ingredients"] = {
      {type="item", name="twBeacon5", amount=10},
      {type="item", name="processing-unit", amount=35}
}
data.raw["recipe"]["twBeacon7"]["ingredients"] = {
      {type="item", name="twBeacon6", amount=10},
      {type="item", name="processing-unit", amount=40}
}
end

--power hunger mode
if settings.startup["TBRE-PowerHungry"].value == true then
data.raw["beacon"]["twBeacon1"]["energy_usage"] = "1.2MW"
data.raw["beacon"]["twBeacon2"]["energy_usage"] = "1.6MW"
data.raw["beacon"]["twBeacon3"]["energy_usage"] = "2MW"
data.raw["beacon"]["twBeacon4"]["energy_usage"] = "2.4MW"
data.raw["beacon"]["twBeacon5"]["energy_usage"] = "2.8MW"
data.raw["beacon"]["twBeacon6"]["energy_usage"] = "3.2MW"
data.raw["beacon"]["twBeacon7"]["energy_usage"] = "8MW"
end 

--accept or deny productivity modules
if settings.startup["TBRE-Productivity"].value == false then
table.remove(data.raw["beacon"]["twBeacon1"]["allowed_effects"],"productivity")
table.remove(data.raw["beacon"]["twBeacon2"]["allowed_effects"],"productivity")
table.remove(data.raw["beacon"]["twBeacon3"]["allowed_effects"],"productivity")
table.remove(data.raw["beacon"]["twBeacon4"]["allowed_effects"],"productivity")
table.remove(data.raw["beacon"]["twBeacon5"]["allowed_effects"],"productivity")
table.remove(data.raw["beacon"]["twBeacon6"]["allowed_effects"],"productivity")
table.remove(data.raw["beacon"]["twBeacon7"]["allowed_effects"],"productivity")
end

--accept or deny quality modules
if settings.startup["TBRE-Quality"].value == false then
  local function removeEffect(beaconName, effectName)
    local effects = data.raw["beacon"][beaconName]["allowed_effects"]
    if effects then
      for i, effect in ipairs(effects) do
        if effect == effectName then
          table.remove(effects, i)
          break
        end
      end
    end
  end
  
      removeEffect("taBeacon", "quality")
      removeEffect("taBeacon2", "quality")
      removeEffect("taBeacon3", "quality") 
      removeEffect("taBeacon4", "quality")
      removeEffect("taBeacon5", "quality")
      removeEffect("taBeacon6", "quality")
      removeEffect("taBeacon7", "quality")

  end
