-- Initializes the nodes
local north = {facing = "north"}
local west = {facing = "west"}
local east = {facing = "east"}
local south = {facing = "south"}

local currentFacing = nil

-- Initializes the current turtle facing
local function initFacing(facing)
    if facing == "north" then
        currentFacing = north
        return
    elseif facing == "east" then
        currentFacing = east
        return
    elseif facing == "west" then
        currentFacing = west
        return
    elseif facing == "south" then
        currentFacing = south
        return
    end
end

local function getCurrentFacing() 
    return currentFacing
end

local function setFacing(facing)
    if currentFacing.facing == facing then
        return
    end       
    
    if currentFacing.right.facing == facing then
        turtle.turnRight()
        currentFacing = currentFacing.right
        return
    elseif currentFacing.left.facing == facing then
        turtle.turnLeft()
        currentFacing = currentFacing.left
        return
    elseif currentFacing.opposite.facing == facing then
        turtle.turnLeft()
        turtle.turnLeft()
        currentFacing = currentFacing.opposite
        return
    end
end

-- Links the direction nodes together
local function initList()
    north.left = west
    north.right = east
    north.opposite = south
    
    west.left = south
    west.right = north
    west.opposite = east
    
    east.left = north
    east.right = south
    east.opposite = west
    
    south.left = east
    south.right = west
    south.opposite = north
end

return {
    initList = initList,    
    initFacing = initFacing,
    getCurrentFacing = getCurrentFacing,
    setFacing = setFacing
}
