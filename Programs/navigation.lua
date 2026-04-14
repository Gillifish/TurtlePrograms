-- Imports
local facing = require("facing")

-- table for tracking the turtles moved position
local transform = {x = 0, y = 0, z = 0}

-- Initialize the linked list for the facing
facing.initList()
facing.initFacing("north")

local function getTransform()
    return transform
end

local function heuristic(a, b)
    return math.abs(a.x - b.x)
         + math.abs(a.y - b.y)
         + math.abs(a.z - b.z)
end

local function newQueue()
    return {}
end

local function push(queue, node)
    table.insert(queue, node)
    table.sort(queue, function(a, b) return a.f < b.f end)
end

local function pop(queue)
    return table.remove(queue, 1)
end

local function astar(world, start, goal)
    local open = newQueue()
    local cameFrom = {}
    local gScore = {}

    local function key(pos)
        return pos.x..","..pos.y..","..pos.z
    end

    local function isPassable(x, y, z)
        return world[x] and world[x][y] and world[x][y][z] == "air"
    end

    -- 6 possible directions: N/S/E/W/Up/Down
    local neighbors = {
        {x=1,y=0,z=0}, {x=-1,y=0,z=0},
        {x=0,y=1,z=0}, {x=0,y=-1,z=0},
        {x=0,y=0,z=1}, {x=0,y=0,z=-1},
    }

    local startKey = key(start)
    gScore[startKey] = 0
    push(open, {pos=start, f=heuristic(start, goal)})

    while #open > 0 do
        local current = pop(open)
        local curKey = key(current.pos)

        -- reached the goal, reconstruct path
        if current.pos.x == goal.x
        and current.pos.y == goal.y
        and current.pos.z == goal.z then
            local path = {}
            local node = curKey
            while node do
                local parts = {}
                for n in node:gmatch("-?%d+") do
                    table.insert(parts, tonumber(n))
                end
                table.insert(path, 1, {x=parts[1], y=parts[2], z=parts[3]})
                node = cameFrom[node]
            end
            return path
        end

        for _, dir in ipairs(neighbors) do
            local nx = current.pos.x + dir.x
            local ny = current.pos.y + dir.y
            local nz = current.pos.z + dir.z

            if isPassable(nx, ny, nz) then
                local neighborKey = key({x=nx, y=ny, z=nz})
                local tentativeG = gScore[curKey] + 1

                if not gScore[neighborKey]
                or tentativeG < gScore[neighborKey] then
                    gScore[neighborKey] = tentativeG
                    cameFrom[neighborKey] = curKey
                    push(open, {
                        pos = {x=nx, y=ny, z=nz},
                        f = tentativeG + heuristic({x=nx,y=ny,z=nz}, goal)
                    })
                end
            end
        end
    end

    return nil -- no path found
end

local function mineX(target)
    
    if target.x == 0 then
        return
    end
    
    local distance = math.abs(target.x)
    
    if target.x < 0 then
        facing.setFacing("west")
    end
    
    if target.x > 0 then
        facing.setFacing("east")
    end

    for i = 0, distance - 1 do
        turtle.dig()
        turtle.forward() 
    end

end

local function mineY(target)
    
    if target.y == 0 then
        return
    end
    
    local distance = math.abs(target.y)
    
    for i = 0, distance - 1 do
        if target.y > 0 then
            turtle.digUp()
            turtle.up()
        end
        
        if target.y < 0 then
            turtle.digDown()
            turtle.down()
        end
    end
end

local function mineZ(target)
    if target.z == 0 then
        return
    end
    
    local distance = math.abs(target.z)
    
    if target.z < 0 then
        facing.setFacing("north")
    end
    
    if target.z > 0 then
        facing.setFacing("south")    
    end
    
    for i = 0, distance - 1 do
        turtle.dig()
        turtle.forward()
    end
end

local function directMine(target)
    mineX(target)
    mineY(target)
    mineZ(target)
    facing.setFacing("north")
    transform.x = transform.x + target.x
    transform.y = transform.y + target.y
    transform.z = transform.z + target.z  
end

return {
	astar = astar,
    directMine = directMine,
    getTransform = getTransform
}
