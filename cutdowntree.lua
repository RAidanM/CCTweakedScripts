
---checks for specified content for .inspect()
---@param desired_block string
---@param pitch any 
---@return boolean
function checkIf(desired_block,pitch)
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

---turtle checks sorrounding for certain block
---@param desired_block string
---@return boolean
function spinFor(desired_block)
    for i = 1, 4, 1 do
        if checkIf(desired_block) then
            return true
        end
        turtle.turnRight()
    end
    return false
end

---moves turtle by certain distance repeating
---@param distance integer
---@param pitch any
function move(distance,pitch)
    for i = 1, distance, 1 do
        if pitch == nil or pitch == "forward" then
            turtle.forward()
        elseif pitch == "up" then
            turtle.up()
        elseif pitch == "down" then
            turtle.down()
        elseif pitch == "back" then
            turtle.back()
        end
    end
end

--checks for logs and enters tree
if spinFor("log") then turtle.dig() end
turtle.forward()

--dig up
local height = 0
while checkIf("log","up") do
    turtle.digUp()
    turtle.up()
    height = height + 1
end
move(height,"down")
--dig down
height = 0
while checkIf("log","down") do
    turtle.digDown()
    turtle.down()
    height = height + 1
end
move(height,"up")
--original position
turtle.back()
