---makes turtle move in a circle
---@param cw boolean
---@param r integer
function circle(cw,r)

    for i = 1, 4, 1 do
        for j = 1, r, 1 do
            turtle.forward()
        end
        if cw==true then
            turtle.turnRight()
        else
            turtle.turnLeft()
        end
    end
end

circle(arg[1], arg[2])