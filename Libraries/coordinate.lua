Coordinate = {}
Coordinate.__index = Coordinate

-- Constructor
function Coordinate.new(x, y, z)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0}, Coordinate)
end

-- Metamethods
function Coordinate.__add(a, b)
    return Coordinate.new(a.x + b.x, a.y + b.y, a.z + b.z)
end

function Coordinate.__sub(a, b)
    return Coordinate.new(a.x - b.x, a.y - b.y, a.z - b.z)
end

function Coordinate.__tostring(c)
    return string.format("(%d, %d, %d)", c.x, c.y, c.z)
end

-- Methods
function Coordinate:distanceTo(other)
    return math.sqrt( (self.x - other.x)^2 + (self.y - other.y)^2 + (self.z - other.z)^2 )
end

return Coordinate