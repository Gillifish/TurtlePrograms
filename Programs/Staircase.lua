function checkForBlock()
    local id = os.getComputerID()
    local has_block, data = turtle.inspect()
    if has_block then
        return has_block, data.name, "[TURTLE: " .. id .. "] " .. data.name .. " detected..."
    else
        return false, nil, "[TURTLE: " .. id .. "] Item not detected..." 
    end
end

function Staircase(y)
    local count = 0
 
    while true do

        if count == y then
            break
        end

        _, block, msg = checkForBlock()

        turtle.dig()

        while turtle.detect() == true do
            turtle.dig()
        end

        turtle.forward()
        turtle.digUp()
        turtle.dig()

        while turtle.detect() == true do
            turtle.dig()
        end

        turtle.forward()
        turtle.digUp()
        turtle.back()
        turtle.digDown()
        turtle.down()
 
        count = count + 1
    end
end
 
function Main()
    term.clear()
    term.setCursorPos(1, 1)
    io.write("Enter desired Y level: ")
    local y = io.read()
    Staircase(y)
end
 
Main()