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
 
    while (count ~= y) do
        _, block, msg = checkForBlock()

        if block == "minecraft:gravel" then
            print("[TURTLE] Problematic block detected...")
            break
        end

        turtle.dig()
        turtle.forward()
        turtle.digUp()
        turtle.dig()
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