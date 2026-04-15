-- scanner.lua

local scanner = peripheral.find("geo_scanner")
if not scanner then
    error("No geo scanner found! Make sure one is attached to the turtle.")
end

local world = {}

local function setBlock(x, y, z, state)
    if not world[x] then world[x] = {} end
    if not world[x][y] then world[x][y] = {} end
    world[x][y][z] = state
end

local function isPassable(blockName)
    return blockName == "minecraft:air"
        or blockName == "minecraft:short_grass"
        or blockName == "minecraft:tall_grass"
        or blockName == "minecraft:snow"
end

local function scanIntoMap(turtlePos, radius)
    local results, err = scanner.scan(radius)

    if not results then
        print("Scan failed: " .. err)
        return false
    end

    for _, block in ipairs(results) do
        -- skip the turtle itself
        if not (block.x == 0 and block.y == 0 and block.z == 0) then
            local wx = turtlePos.x + block.x
            local wy = turtlePos.y + block.y
            local wz = turtlePos.z + block.z

            if isPassable(block.name) then
                setBlock(wx, wy, wz, "air")
            else
                setBlock(wx, wy, wz, "solid")
            end
        end
    end

    -- mark turtle's current position as air
    setBlock(turtlePos.x, turtlePos.y, turtlePos.z, "air")
    return true
end

local function getWorld()
    return world
end

local function isScanned(x, y, z)
    return world[x] and world[x][y] and world[x][y][z] ~= nil
end

local function findBlock(blockName, radius)
    local data = {}
    local dataIndex = 1
    local scanRes, err = scanner.scan(radius)

    if scanRes == nil then
        error("Error")
    end

    for _, block in ipairs(scanRes) do
        if block.name == blockName then
            data[dataIndex] = block
            dataIndex = dataIndex + 1
        end
    end

    return data
end

return {
    scanIntoMap = scanIntoMap,
    getWorld    = getWorld,
    isScanned   = isScanned,
    findBlock   = findBlock
}
