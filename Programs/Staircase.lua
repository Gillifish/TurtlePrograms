function Staircase(y)
    local count = 0
 
    while (count ~= y) do
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