
local M = {}

local ch35
local ch37
local ch36
local ch38

local function onInit()

  electrics.values['fire'] = v.data.variables["$fire"].val

  for nodeID, nodeData in pairs(v.data.nodes) do
        
    -- Appliquer la rotation de 90° sur Z
    local newX = -nodeData.pos.y
    local newY = nodeData.pos.x
    local newZ = nodeData.pos.z

    if newX and newY and newZ then
      -- Appliquer la nouvelle position
      local newPosition = vec3(newX, newY, newZ)
      obj:setNodePosition(nodeData.cid, newPosition)
    end

  end

  for k, node in pairs (v.data.nodes) do
    if node.name == "ch35" then ch35=k  end
    if node.name == "ch37" then ch37=k  end
    if node.name == "ch36" then ch36=k  end
    if node.name == "ch38" then ch38=k  end
  end
   
end

local function onReset()
  electrics.values['steering_car'] = 0
  electrics.values['steering_input'] = 0
  electrics.values['jato_car'] = 0

  
end

local function updateGFX(dt) -- ms
  
  if electrics.values.jato_car == 1 and electrics.values.fire > 0 then
    obj:addParticleByNodesRelative(ch35, ch37, 5, 49, 2, 10)
    obj:addParticleByNodesRelative(ch35, ch37, 5, 29, 2, 10)
    obj:addParticleByNodesRelative(ch35, ch37, 5, 37, 2, 10)

    obj:addParticleByNodesRelative(ch36, ch38, 5, 49, 2, 10)
    obj:addParticleByNodesRelative(ch36, ch38, 5, 29, 2, 10)
    obj:addParticleByNodesRelative(ch36, ch38, 5, 37, 2, 10)
  end
  
  
  
end

local function display_message()
  local steering = electrics.values['steering_car'] or 0
  guihooks.message("Steering angle: " .. steering)

end

local function set_steering(VALUE)
  electrics.values['steering_car'] = VALUE
  electrics.values['steering_input'] = VALUE
end

local function set_THRUSTER()
  if electrics.values.jato_car == 0 then
    electrics.values['jato_car'] = 1
    guihooks.message("JATO ON")
  else
    electrics.values['jato_car'] = 0
    guihooks.message("JATO OFF")
  end

  

end

function set_steering_and_move(value)
  set_steering(value)  -- Applique la direction
  electrics.values.throttle = 1  -- Déplacer la carte en avant
end

function set_steering_and_brake(value)
  set_steering(value)  -- Applique la direction
  --electrics.values['clutch'] = 1 -- Reculer la carte
  electrics.values.brake = 1  -- Activer le frein
end


-- public interface
M.onInit    = onInit
M.onReset   = onReset
M.updateGFX = updateGFX
M.display_message = display_message
M.set_steering = set_steering
M.set_THRUSTER = set_THRUSTER
M.set_steering_and_move = set_steering_and_move
M.set_steering_and_brake = set_steering_and_brake
return M