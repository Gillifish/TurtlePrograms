function Refuel()
    local fueled = true
    while fueled do
        fueled = turtle.refuel()
    end
end

Refuel()