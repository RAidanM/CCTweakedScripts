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



function TurtleHelper.checkIf(desired_block,pitch)
    --reading block info from correct pitch
    local has_block, block_info
    if pitch == nil or pitch == "forward" then
        has_block, block_info = turtle.inspect()
    elseif pitch == "up" then
        has_block, block_info = turtle.inspectUp()
    elseif pitch == "down" then
        has_block, block_info = turtle.inspectDown()
    end
    --seeing if block matches desired
    if has_block then
        local block_name = block_info.name
        if string.find(block_name,desired_block) ~= nil then
            return true
        end
    end
    return false
end

---@param desired_block string
---@return boolean
function TurtleHelper.spinFor(desired_block)
    for i = 1, 4, 1 do
        if TurtleHelper.checkIf(desired_block) then
            return true
        elseif (desired_block=="empty") then
            return true
        end
        assert(turtle.turnRight())
    end
    return false
end

-- might break in fluids (water, lava)
function TurtleHelper.calibrate()
    local turtle_loc = Coordinate.new(gps.locate())
    local turtle_new_loc

    if TurtleHelper.spinFor("empty") then
        assert(turtle.forward())
        turtle_new_loc = Coordinate.new(gps.locate())
        resultant = turtle_new_loc - turtle_loc
        if (resultant.z == -1) then
            print("Facing North")
            assert(turtle.back())
            return 0
        elseif (resultant.x == 1) then
            print("Facing East")
            assert(turtle.back())
            return 1
        elseif (resultant.z == 1) then
            print("Facing South")
            assert(turtle.back())
            return 2
        elseif (resultant.x == -1) then
            print("Facing West")
            assert(turtle.back())
            return 3
        else 
            print("calibrattion failed")
        end
        
    else
        print("Can't calibrate. Surrounded by blocks")
    end
    
end

return TurtleHelper