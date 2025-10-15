-- required library
local Coordinate = require("coordinate")
local State = require("state")
--
TurtleHelper = {}


function TurtleHelper.turnTowards(x, z)
    local state = State.load()
    local facing = state["facing"]
    local goal = facing
    if z < 0  then
        print("Turning North (-z)")
        goal = 0
    elseif x > 0 then
        print("Turning East (+x)")
        goal = 1
    elseif z > 0 then
        print("Turning South (+z)")
        goal = 2
    elseif x < 0 then
        print("Turning West (-x)")
        goal = 3
    else
        print("No need to turn")
        return false
    end

    if goal == facing then
        print("No need to turn")
        return false
    elseif goal == 3 and facing == 0 then
        turtle.turnLeft()
    elseif goal == 0 and facing == 3 then
        turtle.turnRight()
    elseif goal > facing then
        for i = facing, goal-1, 1 do
            turtle.turnRight()
        end
    elseif goal < facing then
        for i = facing, goal+1, -1 do
            turtle.turnLeft()
        end
    end

    state["facing"] = goal
    State.save(state)
end

-- @param 
function TurtleHelper.mineTo(origin, destination)
    local resultant = destination - origin

    -- y
    if resultant.y > 0 then
        for i = 0, resultant.y-1, 1 do
            if turtle.detectUp() then
                assert(turtle.digUp())
            end
            assert(turtle.up())
        end
    else
        for i = 0, resultant.y+1, -1 do
            if turtle.detectDown() then
                assert(turtle.digDown())
            end
            assert(turtle.down())
        end
    end

    -- x
    TurtleHelper.turnTowards(resultant.x,0)
    for i = 0, math.abs(resultant.x)-1, 1 do
        if turtle.detect() then
            assert(turtle.dig())
        end
        assert(turtle.forward())
    end

    -- z
    TurtleHelper.turnTowards(0,resultant.z)
    for i = 0, math.abs(resultant.z)-1, 1 do
        if turtle.detect() then
            assert(turtle.dig())
        end
        assert(turtle.forward())
    end


end

function TurtleHelper.mineMove(x,y,z)
    local turtle_loc = Coordinate.new(gps.locate())
    local turtle_relative = turtle_loc + Coordinate.new(x,y,z)
    TurtleHelper.mineTo(turtle_loc,turtle_relative)
end

function TurtleHelper.corridorTo(origin, destination)
    local resultant = destination - origin
    local state = State.load()

    -- y
    if resultant.y > 0 then
        for i = 0, resultant.y-1, 1 do
            if turtle.detectUp() then
                assert(turtle.digUp())
            end
            assert(turtle.up())
        end
    else
        for i = 0, resultant.y+1, -1 do
            if turtle.detectDown() then
                assert(turtle.digDown())
            end
            assert(turtle.down())
        end
    end
    state["y"] = destination.y

    -- x
    TurtleHelper.turnTowards(resultant.x,0)
    for i = 0, math.abs(resultant.x)-1, 1 do
        if turtle.detect() then
            assert(turtle.dig())
        end
        if turtle.detectUp() then
            assert(turtle.digUp())
        end
        if turtle.detectDown() then
            assert(turtle.digDown())
        end
        assert(turtle.forward())
    end
    if turtle.detectUp() then
        assert(turtle.digUp())
    end
    if turtle.detectDown() then
        assert(turtle.digDown())
    end
    state["x"] = destination.x

    -- z
    TurtleHelper.turnTowards(0,resultant.z)
    for i = 0, math.abs(resultant.z)-1, 1 do
        if turtle.detect() then
            assert(turtle.dig())
        end
        if turtle.detectUp() then
            assert(turtle.digUp())
        end
        if turtle.detectDown() then
            assert(turtle.digDown())
        end
        assert(turtle.forward())
    end
    if turtle.detectUp() then
        assert(turtle.digUp())
    end
    if turtle.detectDown() then
        assert(turtle.digDown())
    end
    state["z"] = destination.z

    State.save(state)

end

function TurtleHelper.corridorMove(x,y,z)
    local turtle_loc = Coordinate.new(gps.locate())
    local turtle_relative = turtle_loc + Coordinate.new(x,y,z)
    TurtleHelper.corridorTo(turtle_loc,turtle_relative)
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
    elseif desired_block=="empty" then
        return true
    end
    return false
end

---@param desired_block string
---@return boolean
function TurtleHelper.spinFor(desired_block)
    for i = 1, 4, 1 do
        if TurtleHelper.checkIf(desired_block) then
            return true
        end
        assert(turtle.turnRight())
    end
    return false
end

-- might break in fluids (water, lava)
function TurtleHelper.calibrate()
    local state = State.load()
    local turtle_loc = Coordinate.new(gps.locate())
    local turtle_new_loc

    if TurtleHelper.spinFor("empty") then
        assert(turtle.forward())
        turtle_new_loc = Coordinate.new(gps.locate())
        local resultant = turtle_new_loc - turtle_loc
        if (resultant.z == -1) then
            print("Facing North")
            assert(turtle.back())
            state["facing"] = 0
        elseif (resultant.x == 1) then
            print("Facing East")
            assert(turtle.back())
            state["facing"] = 1 
        elseif (resultant.z == 1) then
            print("Facing South")
            assert(turtle.back())
            state["facing"] = 2
        elseif (resultant.x == -1) then
            print("Facing West")
            assert(turtle.back())
            state["facing"] = 3
        else 
            print("calibrattion failed")
        end
        
    else
        print("Can't calibrate. Surrounded by blocks")
    end
    State.save(state)
end

return TurtleHelper