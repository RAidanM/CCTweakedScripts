local Coordinate = require("coordinate")
local TurtleHelper = require("turtlehelper")
local State = require("state")

if TurtleHelper.spinFor("log") then
    turtle.dig()
    if TurtleHelper.spinFor("log") then -- 2x2 tree
        turtle.dig()
    
        local y = 0
        while checkIf("log","up") do
            turtle.digUp()
            if checkIf("log") then
                turtle.dig()
            end
            turtle.up()
            y = y + 1
        end

        --find some way to clear the tops of the tree

        -- mine down while digging 2 collums


    
    
    else -- 1x1 tree
        local y = 0
        while checkIf("log","up") do
            turtle.digUp()
            turtle.up()
            y = y + 1
        end
        while y ~= 0 do
            turtle.down()
            y = y - 1
        end
    end

end
    
