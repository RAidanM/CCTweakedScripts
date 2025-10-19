-- required library
local Coordinate = require("coordinate")
local TurtleHelper = require("turtlehelper")
local State = require("state")

-- arguments
local extrema_one = Coordinate.new(arg[1],arg[2],arg[3])
local extrema_two = Coordinate.new(arg[4],arg[5],arg[6])

-- main

TurtleHelper.calibrate()

--travel to closest corner
local turtle_loc = Coordinate.new(gps.locate())
local extrema_one_distance = turtle_loc:distanceTo(extrema_one)
local extrema_two_distance = turtle_loc:distanceTo(extrema_two)

local start_coordinate = nil
local end_coordinate = nil
if extrema_one_distance < extrema_two_distance then
    start_coordinate = extrema_one
    end_coordinate = extrema_two
else
    start_coordinate = extrema_two
    end_coordinate = extrema_one
end

--print("Travelling to " .. start_coordinate) points to table index 
TurtleHelper.mineTo(turtle_loc, start_coordinate)

--mine area
local resultant = end_coordinate - start_coordinate

local levels = math.abs(resultant.y)
local updown = (resultant.y >= 0) and 1 or -1
local turtle_level = 0

local distance = math.abs(resultant.x) - 1
local side = (resultant.x >= 0) and 1 or -1

local lap = resultant.z

--reference for layers
TurtleHelper.mineMove(0,0,lap)
for i = 0, distance, 1 do
    lap = lap * -1
    TurtleHelper.mineMove(1,0,lap)
end

local i = 0
while i < levels do
    if i + 2 < levels then --use corridor at i+1

        -- moves to correct level
        while turtle_level < i+1 do
            TurtleHelper.mineMove(0,updown,0)
            turtle_level = turtle_level + 1
        end
        
        -- mines out corridor area
        TurtleHelper.corridorMove(0,0,lap)
        for i = 0, distance, 1 do
            lap = lap * -1
            TurtleHelper.corridorMove(side,0,lap)
        end
        side = side * -1

        --moves to end of cleared area
        TurtleHelper.mineMove(0,updown,0)

        i = i + 3
    else --use path at i

         -- moves to correct level
        while turtle_level < i do
            TurtleHelper.mineMove(0,updown,0)
            turtle_level = turtle_level + 1
        end
        
        -- mines out corridor area
        TurtleHelper.mineMove(0,0,lap)
        for i = 0, distance, 1 do
            lap = lap * -1
            TurtleHelper.mineMove(side,0,lap)
        end
        side = side * -1

        i = i + 1
    end
end




