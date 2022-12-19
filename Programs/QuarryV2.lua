x = tonumber(arg[1])
y = tonumber(arg[2])
z = tonumber(arg[3])

currentProgress = 1

function UpdateProgress(current, total)
    local progress = (current / total) * 100

    progress = math.ceil(progress)

    term.setCursorPos(1, 2)
    term.clearLine()
    print(progress .. "% Completed")
end

function ShiftPosition(num)
    if num == 0 then
        turtle.turnRight()
        turtle.dig()
        turtle.forward()
        turtle.turnRight()
    end
    if num == 1 then
        turtle.turnLeft()
        turtle.dig()
        turtle.forward()
        turtle.turnLeft()
    end
end

function ResetLayer(num)
    if num == 0 then
        turtle.turnRight()

        for r = 1, z, 1
        do
            turtle.forward()
        end

        turtle.turnRight()
    end
    if num == 1 then
        turtle.turnRight()
        turtle.turnRight()

        for r = 1, x, 1 do
            turtle.forward()
        end

        turtle.turnRight()

        for r = 1, z, 1 do
            turtle.forward()
        end

        turtle.turnRight()
    end
end

function Quarry()
    local totalBlocks = x * y * z
    local orientation = 0

    term.clear()
    term.setCursorPos(1, 1)
    print("[GN] Beginning Quarry Protocol...")

    for h=1, y, 1 
    do
        for i = 1, z, 1
        do
            for j = 1, x - 1, 1
            do
                turtle.dig()
                turtle.forward()
                currentProgress = currentProgress + 1
                UpdateProgress(currentProgress, totalBlocks)
            end

            if i == z then
                break
            else
                ShiftPosition(orientation)
                currentProgress = currentProgress + 1
                UpdateProgress(currentProgress, totalBlocks)
            end
        
        
            if orientation == 0 then
                orientation = 1
            else
                orientation = 0
            end
        end

        if z % 2 == 0 then
            ResetLayer(0)
            orientation = 0
        else
            ResetLayer(1)
            orientation = 0
        end

        if h == y then
            break
        else
            turtle.digDown()
            currentProgress = currentProgress + 1
            UpdateProgress(currentProgress, totalBlocks)
            turtle.down()
        end

    end

    
end

Quarry()