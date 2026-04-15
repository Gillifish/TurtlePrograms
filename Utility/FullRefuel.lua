function Refuel()
    local count = 1

    while count ~=16 do
        turtle.select(count)
        while turtle.refuel() do
        end
        count = count + 1
    end
    turtle.select(1)
end

Refuel()