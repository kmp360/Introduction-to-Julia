#  Chapter 04 – Interface Design

#---

using Pkg
Pkg.add(url = "https://github.com/BenLauwens/ThinkJulia.jl")

using ThinkJulia

#---

# Exercise 4-1

🐢 = Turtle()
@svg forward(🐢, 100)

@svg begin
	forward(🐢, 100)
	turn(🐢, -90)
	forward(🐢, 100)
end

🐢 = Turtle()

@svg begin
    for i in 1:4
        forward(🐢, 100)
        turn(🐢, -90)
    end
end

#---

# Exercise 4-2

function square(t)
	for i in 1:4
		forward(t, 100)
		turn(t, -90)
	end
end

@svg square(🐢)

#---

# Exercise 4-3

function disp(s)
    @svg square(s)
end

#---

# Exercise 4-4

function square2(t, len)
    for i in 1:4
        forward(t, len)
        turn(t, -90)
    end
end

@svg square2(🐢, 100)

#---

# Exercise 4-5

function polygon(t, n, len)
    angle = 360 / n
    for i in 1:n
        forward(t, len)
        turn(t, -angle)
    end
end

@svg polygon(🐢, 5, 50)

#---

# Exercise 4-6

function circle(t, r)
    circumference = 2 * π * r
    n = 50
    len = circumference / n
    polygon(t, n, len)
end

@svg circle(🐢, 50)

"""
    circle2(t, r)

TBW
"""
function circle2(t, r)
    circumference = 2 * π * r
    n = trunc(circumference / 3) + 3
    len = circumference / n
	polygon(t, n, len)
end

@svg circle2(🐢, 30)

#---

# Exercise 4-7

function arc(t, r, angle)
    arc_len = 2 * π * r * angle / 360
    n = trunc(arc_len / 3) + 1
    step_len = arc_len / n
    step_angle = angle / n
    for i = 1:n
        forward(t, step_len)
        turn(t, -step_angle)
    end
end

#---

"""
polyline(t, n, len, angle)
draws n line segments with the given length and angle (in degrees) between them
t: turtle
"""
function polyline(t, n, len, angle)
    for i = 1:n
        forward(t, len)
        turn(t, -angle)
    end
end

@svg polyline(Turtle(), 2, 50, 45)

function polygon(t, n, len)
    angle = 360 / n
    polyline(t, n, len, angle)
end

function arc(t, r, angle)
    arc_len = 2 * π * r * angle / 360
    n = trunc(arc_len / 3) + 1
    step_len = arc_len / n
    step_angle = angle / n
    polyline(t, n, step_len, step_angle)
end

@svg arc(Turtle(), 100, 360)

function circle(t, r)
    arc(t, r, 360)
end

#---

# Exercise 4-8

"""
arc2(t, r, angle)
draws an arc with the given radius and angle:
    t: turtle
    r: radius
    angle: angle subtended by the arc, in degrees
"""
function arc2(t, r, angle)
    arc_len = 2 * π * r * abs(angle) / 360
    n = trunc(arc_len / 4) + 3
    step_len = arc_len / n
    step_angle = angle / n

    # making a slight left turn before starting reduces
    # the error caused by the linear approximation of the arc
    turn(t, -step_angle / 2)
    polyline(t, n, step_len, step_angle)
    turn(t, step_angle / 2)
end

#---

# Exercise 4-12

"""
https://en.wikipedia.org/wiki/Spiral;
https://en.wikipedia.org/wiki/Archimedean_spiral;
r = a + b*θ^(1/c)
ArchimedanSpiral(a, b, n, c=1)

draws a general Archimedan spiral through n turns
	with the given offset and radius:

    a: offset
    b: radius
    n: number of turns
    c: =1
"""

using Plots

function ArchimedanSpiral(a, b, n, m = 10_000, c = 1)
	gr()
    delta_angle = 2 * pi * n / m

	# Polar coordinates
    angle = [(i - 1) * delta_angle for i = 1:m]
    r = a .+ (b .* angle)

	# plot in Cartesian coordinates
	# x = r .* cos.(angle)
	# y = r .* sin.(angle)

    plot(
        r .* cos.(angle),
        r .* sin.(angle),
        title = "Archimedian Spiral: r = $a+$b"*"theta",
        xlabel = "x = rcos(theta)",
        ylabel = "y = rsin(theta)",
        label = false,
    	)
end

ArchimedanSpiral(5, 2, 10)

#==============================================================================#
