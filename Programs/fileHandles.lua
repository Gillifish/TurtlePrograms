function fileInit(filename)
    local body = {}
    local file = fs.open(filename, "w")
    file.write(textutils.serialise(body))
    file.close()
end

function append(filename, d)
    local file = fs.open(filename, "r")
    local data = file.readAll()
    file.close()
    local t = textutils.unserialise(data)
    table.insert(t, d)
    file = fs.open(filename, "w")
    file.write(textutils.serialise(t))
    file.close()
end

function load(filename)
    local file = fs.open(filename, "r")
    local data = file.readAll()
    file.close()

    return textutils.unserialise(data)
end

function search(data, username, id)
    for i = 1, table.maxn(data), 1 
    do
        if (username == data[i].name and id == data[i].id) then
            return data[i].name, data[i].id, data[i].msg 
        end
    end

    return "[ERROR] User not found..."
end
