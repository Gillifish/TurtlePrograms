function checkForBlock()
    local id = os.getComputerID()
    local has_block, data = turtle.inspect()
    if has_block then
        return has_block, data.name, "[TURTLE: " .. id .. "] " .. data.name .. " detected..."
    else
        return false, nil, "[TURTLE: " .. id .. "] Item not detected..." 
    end
end

function lineDig(length)
    local count = 0
    repeat
        local block = turtle.detect()
        if block then
           turtle.dig()
           turtle.forward()
        else
            turtle.forward()
        end
        fuelCheck()
        count = count + 1
    until(count == length)
end

function digPositionRight()
    turtle.turnRight()
    turtle.dig()
    turtle.forward()
    turtle.turnRight()
end

function digPositionLeft()
    turtle.turnLeft()
    turtle.dig()
    turtle.forward()
    turtle.turnLeft()
end

function layerReset(x, z)
    local xCount = 0
    local zCount = 0

    if (z % 2 == 0) then
        turtle.turnRight()
        turtle.turnRight()
        repeat
            turtle.forward()
            xCount = xCount + 1
        until(xCount == x)
        turtle.turnRight()
        repeat
            turtle.forward()
            zCount = zCount + 1
        until(zCount == z)
        turtle.turnRight()
    end
    xCount = 0
    zCount = 0
    if (z % 2 ~= 0) then
        turtle.turnRight()
        repeat
            turtle.forward()
            zCount = zCount + 1
        until(zCount == z)
        turtle.turnRight()
    end
end

function digPlane(x, z)
    local lineCount = 0
    lineDig(x)
    repeat
        if (lineCount % 2 == 0) then
            digPositionRight()
        else
            digPositionLeft()
        end
        lineDig(x)
        lineCount = lineCount + 1
    until(lineCount == z)
    layerReset(x, z)
end

function fuelCheck()
    local fuel = turtle.getFuelLevel()

    if (fuel < 10) then
        turtle.refuel()
    end
    turtle.select(1)
end

function Quarry(x, y, z)
    local yCount = 0
    if (y == 0) then
        digPlane(x, z)
    else
        repeat
            digPlane(x, z)
            if (yCount ~= y - 1) then
                turtle.digUp()
                turtle.up()
                yCount = yCount + 1
            else
                yCount = yCount + 1
            end
        until(yCount == y)
    end
end

function Main()
    term.clear()
    term.setCursorPos(1, 1)
    io.write("Enter X: ")
    local x = tonumber(io.read())
    term.setCursorPos(1, 2)
    io.write("Enter Y: ")
    local y = tonumber(io.read())
    term.setCursorPos(1, 3)
    io.write("Enter Z: ")
    local z = tonumber(io.read())
    term.clear()
    term.setCursorPos(1, 1)
    print("[TURTLE".. os.getComputerID() .. "] Quarry Active...")
    Quarry(x, y, z)
    term.clear()
    term.setCursorPos(1, 1)
    print("[TURTLE ".. os.getComputerID() .. "] Quarry Completed...")
end

Main()