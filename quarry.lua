--Goal: Dig out circular

X = 0
Y = 0
Z = 0
Slot = 1
-- "-z" north
-- "z" south
-- "x" east
-- "-x" west
Facing = "east"
Turn_Table={
    ["north"] = {
        ["north"]   = {turn = 0 },
        ["east"]    = {turn = 1 },
        ["south"]   = {turn = 2 },
        ["west"]    = {turn = 3 }
    },
    ["east"] = {
        ["north"]   = {turn = 3 },
        ["east"]    = {turn = 0 },
        ["south"]   = {turn = 1 },
        ["west"]    = {turn = 2 }
    },
    ["south"] = {
        ["north"]   = {turn = 2 },
        ["east"]    = {turn = 3 },
        ["south"]   = {turn = 0 },
        ["west"]    = {turn = 1 }
    },
    ["west"] = {
        ["north"]   = {turn = 1 },
        ["east"]    = {turn = 2 },
        ["south"]   = {turn = 3 },
        ["west"]    = {turn = 0 }
    }
}

function findCirclePoints(radius)
    local x,z
    local points = {}
    for i = 1, 360, 1 do
        x = round(radius * math.cos(i * math.pi / 180))
        z = round(radius * math.sin(i * math.pi / 180))
        points[x..","..z] = {x=x, z=z}
    end
    return points
end

function round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

function spin(j)
    if j==1 then
        turtle.turnRight()
    elseif j==2 then
        turtle.turnRight()
        turtle.turnRight()
    elseif j==3 then
        turtle.turnLeft()
    end
end

function move(direction)
    if direction ~= Facing then
        spin(Turn_Table[Facing][direction].turn)
        Facing = direction
    end

    local has_block, _ = turtle.inspect()
    if has_block then
        turtle.dig()
    end

    turtle.forward()
    if direction == "east" then
        X = X + 1
    elseif direction == "west" then
        X = X - 1
    elseif direction == "north" then
        Z = Z - 1
    elseif direction == "south" then
        Z = Z + 1
    end
end

function goTo(x,z)
    if(X<=0) then
        while x~=X do
            if X < x then
                move("east")
            elseif X > x then
                move("west")
            end
        end
        while z~=Z do
            if Z < z then
                move("south")
            elseif Z > z then
                move("north")
            end
        end
    elseif (X>0) then
        while z~=Z do
            if Z < z then
                move("south")
            elseif Z > z then
                move("north")
            end
        end
        while x~=X do
            if X < x then
                move("east")
            elseif X > x then
                move("west")
            end
        end
    end
end

function findInteriorPoints(points,radius)
    local mining_points = {}
    local flip = false
    for i = -radius, radius, 1 do
        local hit = false
        local inner = false
        local first_point = {}
        local last_point = {}
        for j = -radius, radius, 1 do
            if points[i..","..j] == nil and hit == true then
                first_point = {x=i,z=j}
                inner = true
                hit = false
            elseif points[i..","..j] ~= nil  then
                hit = true
                if inner == true then 
                    last_point = {x=i,z=j-1}
                    if flip then
                        flip = false
                        mining_points[i.."-1"] = first_point
                        mining_points[i.."-2"] = last_point
                    else
                        flip = true
                        mining_points[i.."-1"] = last_point
                        mining_points[i.."-2"] = first_point
                    end
                    break
                end
            end
        end
    end
    return mining_points
end


local depth = 0 + arg[1]
local radius = arg[2]
local step_height = arg[3]
local step_width = arg[4]

repeat
    local rad = radius - math.floor(Y*-1/step_height)*step_width
    local points = findInteriorPoints(findCirclePoints(rad),rad)

    turtle.digDown()
    turtle.down()
    Y = Y - 1

    for i = -rad+1, rad-1, 1 do
        goTo(points[i.."-1"].x,points[i.."-1"].z)
        goTo(points[i.."-2"].x,points[i.."-2"].z)
    end
    goTo(0,0)


    local bookmark = Y
    while Y ~= 0 do
        turtle.up()
        Y = Y + 1
    end

    for i = 1, 16, 1 do
        Slot = i
        turtle.select(Slot)
        turtle.dropUp()
    end

    while Y ~= bookmark do
        turtle.down()
        Y = Y - 1
    end

until Y <= depth