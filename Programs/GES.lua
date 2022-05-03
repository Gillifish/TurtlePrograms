-- TurtleOS


function encrypt(msg)
    passArray = {}

    for i = 1, string.len(msg), 1 
    do
        passArray[i] = string.byte(string.sub(msg, i, i))
    end

    return passArray
end

function decrypt(passArray)
    password = ""
    for i = 1, #passArray, 1
    do
        password = password .. string.char(passArray[i])
    end

    return password
end