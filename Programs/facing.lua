local north = {facing = "north"}
local west = {facing = "west"}
local east = {facing = "east"}
local south = {facing = "south"}

local currentFacing = nil

function initFacing(facing)
    if facing == "north" then
        currentFacing = north
        return
    end
    
    if facing == "east" then
        currentFacing = east
        return
    end
    
    if facing == "west" then
        currentFacing = west
        return
    end
    
    if facing == "south" then
        currentFacing = south
        return
    end
end

function setFacing(facing)
    if currentFacing.facing == facing then
        return
    end       
    
    while currentFacing.facing ~= facing do
        turtle.turnLeft()
        currentFacing = currentFacing.left
    end
end

function initList()
    north.left = west
    north.right = east
    
    west.left = south
    west.right = north
    
    east.left = north
    east.right = south
    
    south.left = east
    south.right = west
end

return {
    initList = initList,    
    initFacing = initFacing,
    setFacing = setFacing
}
