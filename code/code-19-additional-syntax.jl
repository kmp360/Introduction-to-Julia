# "Code example for Chapter 19 -- Additional Syntax"
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.9.3\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2023\\lectures-1.9")
#---

# Named tuples

x = (a = 1, b = 1+1)

x.b

#---

# Short-form function definition

f(x,y) = x + y

# Anonymous functions

function (x)
    x^2 + 2x - 1
end


x -> x^2 + 2x - 1

a = x -> x^2 + 2x - 10

a(2)

# Plotting with anonymous functions

using Plots

plot(x -> x^2 + 2x - 10, 0, 10, xlabel="x", ylabel="y")

plot(a, 0, 10, xlabel="x", ylabel="y")

b = f(x) = x + 2

plot(b, 0, 10, xlabel="x", ylabel="y")

# Keyword Arguments

function myplot(x, y; style="solid", width=1, color="black")
        ###
end
    
myplot(0:10, 0:10, style="dotted", color="blue")

# Closures

foo(x) = ()->x  # anonymous function
  
bar = foo(1)
bar()

#---

# Block types

# begin block

x, y, z = 0, 0, 0

bb = begin   # begin blocks evaluate to values 
             # that can be assigned to variables;
    x = 1    # local let-block variable
    z      
    @show x
    @show y
    @show z
    @show x + z
end

@show x, y, z

# let block

x, y, z = -1, -1, -1

lb = let    # let blocks evaluate to values 
            # that can be assigned to variables;
    x = 1   # local let-block variable
    z      
    @show x
    @show y
    @show z
    @show x + z
end

@show x, y, z

# do block

data = "This here's the wattle,\nthe emblem of our land.\n"

open("output.txt", "w") do fout

        write(fout, data)
end

# functionally equivalent to
g = fout -> begin
            write(fout, data)
        end

open(g, "output.txt", "w")

#---

# Tenary operator

a = 150

a % 2 == 0 ? println("even") : println("odd")

# Short circuiting

function fact(n::Integer)
    n >= 0 || error("n must be non-negative")
    n == 0 && return 1
    n * fact(n-1)
end

fact(0)

# Tasks (coroutines)

function fib(c::Channel)
    a = 0
    b = 1
    put!(c, a)
    while true
        put!(c, b)
        (a, b) = (b, a+b)
    end
end

fib_gen = Channel(fib)  # constructor of Channel objects

take!(fib_gen)
take!(fib_gen)
take!(fib_gen)
take!(fib_gen)
take!(fib_gen)

for val in Channel(fib)
    print(val, " ")
    val > 20 && break
end

# Types 

primitive type Byte 8 end

Byte(val::UInt8) = reinterpret(Byte, val)

b = Byte(0x01)

# Parametric types

struct Point{T<:Real}
    x::T
    y::T
end

Point(0.0, 0.0)

# Type unions

IntOrString = Union{Int64, String}

150 :: IntOrString

typeof(150)

"Julia" :: IntOrString

1.0 :: IntOrString

# Parametric methods

isintpoint(p::Point{T}) where {T} = (T === Int64)

p = Point(1, 2)

# Function-like Objects

struct Polynomial{R}
    coeff::Vector{R}
end

function (p::Polynomial)(x)     # outer constructor
    val = p.coeff[end]
    for coeff in p.coeff[end-1:-1:1]
        val = val * x + coeff
    end
    return val
end

p = Polynomial([1,10,100])

p(3)

# Constructors

Point(1,2)         # implicit T
   
Point{Int64}(1, 2) # explicit T

Point(1,2.5)       # implicit T

Point(x::T, y::T) where {T<:Real} = Point{T}(x,y) # default outer constructor

# Constructors for different type Arguments

Point(x::Real, y::Real) = Point(promote(x,y)...)

Point(1, 2.0)

# Conversion and promotion

x = 12

convert(UInt8, x)

convert(Float64, x)

Base.convert(::Type{Point{T}}, x::Array{T, 1}) where {T<:Real} = Point(x...)

convert(Point{Float64}, [1.0, 2])

# Expressions

prog = "1 + 2"

ex = Meta.parse(prog)

typeof(ex)

dump(ex)

ex = quote
    1 + 2
end

eval(ex)

ex = :(3 * 2)

eval(ex)

# Macros

macro containervariable(container, element)

    return esc(:($(Symbol(container,element)) = $container[$element]))

end

letters = "abcdefg"
@containervariable letters 1

@macroexpand @containervariable letters 1

@generated function square(x)
    #println(x)
    :(x * x)
end


x = square(2)
y = square("spam")

# Missing values

a = [1, missing]
sum(a)


# Regex

function usesonly(word, available)
    @show r = Regex("[^$(available)]")
    !occursin(r, word)
end

usesonly("banana", "abn")

usesonly("bananas", "abn")

m = match(r"[^abn]", "banana")

typeof(m)

m = match(r"[^abn]", "bananas")

m.match

m.captures

m.offset

dump(m)

# Multi-dimensional arrays

s = ones(String, 2, 3)

#---

function squaresum(a::Float64, b::Float64)
    a^2 + b^2
end

using InteractiveUtils

@code_lowered squaresum(3.0, 4.0)

@code_typed squaresum(3.0, 4.0)

@code_llvm squaresum(3.0, 4.0)

@code_native squaresum(3.0, 4.0)