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


    for i = 0, resultant, -1 do
        
    end

