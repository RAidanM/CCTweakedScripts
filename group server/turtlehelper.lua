-- required library
local Coordinate = require("coordinate")
local State = require("state")
--
TurtleHelper = {}

-- @param 
function TurtleHelper.mineTo(origin, destination)
    local resultant = destination - origin

    -- y
    if y > 0 then
        for i = 0, resultant.y, 1 do
            if turtle.detectUp() then
                assert(turtle.digUp())
            end
            assert(turtle.up())
        end
    else
        for i = 0, resultant.y, -1 do
            if turtle.detectDown() then
                assert(turtle.digDown())
            end
            assert(turtle.down())
        end
    end
    -- x

    -- z
    
end

return TurtleHelper