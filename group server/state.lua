local Coordinate = require("coordinate")

local State = {}
local FILENAME = "turtle_state.txt"

function State.load()
    if not fs.exists(FILENAME) then
        return {x = 0, y = 0, z = 0, facing = 0}  -- default
    end
    local file = fs.open(FILENAME, "r")
    local data = textutils.unserialize(file.readAll())
    file.close()
    return data
end

-- {x = 5, y = 10, z = -2, facing = 1}
function State.save(data)
    local file = fs.open(FILENAME, "w")
    file.write(textutils.serialize(data))
    file.close()
end



return State