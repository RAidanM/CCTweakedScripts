-- required library
local Coordinate = require("coordinate")
local TurtleHelper = require("turtlehelper")
local State = require("state")

-- arguments
local extrema_one = Coordinate.new(arg[1],arg[2],arg[3])
local extrema_two = Coordinate.new(arg[4],arg[5],arg[6])

-- main
local turtle_loc = Coordinate.new(gps.locate())

local extrema_one_distance = turtle_loc:distanceTo(extrema_one)
local extrema_two_distance = turtle_loc:distanceTo(extrema_two)

local start_coordinate = nil
if extrema_one_distance < extrema_two_distance then
    start_coordinate = extrema_one
else
    start_coordinate = extrema_two
end

TurtleHelper.mineTo(turtle_loc, start_coordinate)


print(start_coordinate)