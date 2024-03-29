# "Code example for Chapter 15 -- Structs and objects"
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.9.3\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2023\\lectures-1.9")
#---

struct Point
    x::Float64
    y::Float64
end

p = Point(3.0, 4.0)

p.y

x = p.x

distance = sqrt(p.x^2 + p.y^2)

p.y = 1.0

#---

mutable struct MPoint
    x::Float64
    y::Float64
end

blank = MPoint(0.0, 0.0)

blank.x = 3.0

dump(blank)

#---
"""
Represents a rectangle.
fields: width, height, corner.
"""
struct Rectangle
    width::Float64
    height::Float64
    corner::MPoint
end

origin = MPoint(0.0, 0.0)

box = Rectangle(100.0, 200.0, origin)

#---

function printpoint(p)
    println("($(p.x), $(p.y))")
end

printpoint(blank)

#---

# Exercise 15-1

function distancebetweenpoints(p1, p2) 
    return sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2)
end

#---

function movepoint!(p::MPoint, dx::Float64, dy::Float64)
    p.x += dx
    p.y += dy
    return nothing
end

q = movepoint!(origin, 1.0, 2.0)

typeof(q)

dump(origin)

#---

movepoint!(p, 1.0, 2.0)

dump(p)

#---

function moverectangle!(rect::Rectangle, dx::Float64, dy::Float64)
    movepoint!(rect.corner, dx, dy)
    return nothing
end

box = Rectangle(100.0, 200.0, MPoint(0.0, 0.0))

dump(box)

moverectangle!(box, 1.0, 2.0)

dump(box)

#---

box.corner = MPoint(1.0, 2.0)

box.corner.x = 1.0

#---

function findcenter(rect::Rectangle)
    Point(rect.corner.x + rect.width / 2, rect.corner.y + rect.height / 2)
end

center = findcenter(box)

#---

p1 = MPoint(3.0, 4.0)

p2 = p1

typeof(p2)

p1 == p2, p1 === p2

p2 = deepcopy(p1)

p1 == p2, p1 === p2

#---

# Exercise 15-2

p1 = Point(3.0, 4.0)

p2 = p1

p2 == p1, p2 === p1

p2 = deepcopy(p1)

p2 == p1, p2 === p1

#---

r1 = Rectangle(100, 200, MPoint(3,4))

r2 = r1

r2 == r1, r2 === r1

r2 = deepcopy(r1)

r2 == r1, r2 === r1

#---

typeof(p)

p isa Point

fieldnames(Point)

isdefined(p, :x), isdefined(p, :z)

#---

# Exercise 15-3

