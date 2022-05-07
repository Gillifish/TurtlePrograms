function Refuel()
    local count = 1
    local fueled = true

    while count ~=16 do
        turtle.select(count)
        while fueled do
            fueled = turtle.refuel()
        end
        count = count + 1
    end
    turtle.select(1)
end

Refuel()