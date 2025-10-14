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

print("Travellign to " .. start_coordinate)
TurtleHelper.mineTo(turtle_loc, start_coordinate)

--mine area
local resultant = end_coordinate - start_coordinate
local height = resultant.y
while height >= 0 do
    if height <= 1 then
        --mine square
        -- -y
    else if y >= 2 then
        -- down 1
        -- mine corridor
        -- down 1
        -- -3y

    end
end




end
y == 0
    --cut square























-- first move
if y >= 2 then
    TurtleHelper.mineMove(0,-1,0)
    --dig square corridor
    y = y -2
    TurtleHelper.mineMove(0,-1,0)

end
-- second move
while y > 0 do
    if y >= 3
        TurtleHelper.mineMove(0,-2,0)
        --dig square corridor
        TurtleHelper.mineMove(0,-1,0)
        y = y -3
elseif y == 2 then
    TurtleHelper.mineMove(0,-1,0)
    --dig square corridor
    TurtleHelper.mineMove(0,-1,0)
    y = y - 2
    elseif y == 1 then
        TurtleHelper.mineMove(0,-1,0)
    --dig square
    y = y - 1
end

