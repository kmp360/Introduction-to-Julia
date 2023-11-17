# "Code example for Chapter 17 -- Multiple dispatch"
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.9.3\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2023\\lectures-1.9")
#---

(1 + 2) :: Int64

#(1 + 2) :: Float64

#---

x::Float64 = 100
x

typeof(x)

#x = "str"

#---

x = 3
x
typeof(x)

#---

function returnfloat()
    x::Float64 = 100
    return x
end

y = returnfloat()
typeof(y)

#---

function sinc(x::Number)::Float64
    if x == 0
        return 1
    end
    return sin(x)/(x)
end

sinc(0)
sinc(2/3)
typeof(sinc)

#---

struct MyTime
    hour    ::Int64
    minute  ::Int64
    second  ::Int64
end

#==
Default constructors associated with MyTime
MyTime(hour, minute, second)
MyTime(hour::Int64, minute::Int64, second::Int64)
==#

#---

using Printf

@printf("%.0f %.1f %f\n", 0.5, 0.025, -0.0078125)

function printtime(time::MyTime)

    @printf("%02d:%02d:%02d\n", time.hour, time.minute, time.second)
end

printtime(MyTime(1, 9, 0))


mtime = MyTime(35, 69, 0)

printtime(mtime)

#---

# Exercise 17-1

function timetoint(time::MyTime)::Int64
    return time.second + time.minute * 60 + time.hour * 3600
end


function inttotime(seconds::Int64)::MyTime
    m, s = divrem(seconds, 60)
    h, m = divrem(m, 60)
    d, h = divrem(h, 24)
    return MyTime(h, m, s)
end

#---

function increment(time::MyTime, seconds::Int64)
    seconds += timetoint(time)
    inttotime(seconds)
end

#---

function isafter(t1::MyTime, t2::MyTime)
    (t1.hour, t1.minute, t1.minute) > (t2.hour, t2.minute, t2.second)
end

t1 = MyTime(1,1,0)
t2 = MyTime(0,1,1)
isafter(t1, t2)

#---

function addtime2(t1::MyTime, t2::MyTime)
    m, s = divrem(t1.second + t2.second, 60)
    h, m = divrem(t1.minute + t2.minute + m, 60)
    d, h = divrem(t1.hour + t2.hour + h, 24)
    return MyTime(h, m, s)    
end

start = MyTime(9, 45, 0)
duration = MyTime(1, 35, 0)
done = addtime2(start, duration)
printtime(done)

#---

typeof(2//3)    # Rational number type

#---

function f(c; a = 1, b = 2) # short-form function definition with named defaults
    a + 2b + c
end

f(1)

f(1, b = 3)

f(1, a = 3)

#---

hour = 16
minute = 17
second = 19.0

MyTime(hour, minute, second)
# MyTime(hour::Int64, minute::Int64, second::Int64)

# outer copy constructor
function MyTime(time::MyTime)
    MyTime(time.hour, time.minute, time.second)
end

#---

# inner constructor
struct MyTime2
    hour    :: Int64
    minute  :: Int64
    second  :: Int64

    function MyTime2(hour = 0, minute = 0, second = 0)
        if hour == 24 hour = 0 end
        new(hour, minute, second)
    end
    
    function MyTime2(hour::Int64 = 0, minute::Int64 = 0, second::Int64 = 0)
        @assert(0 ≤ hour ≤ 24, "Minute is not between 0 and 60.")
        @assert(0 ≤ minute < 60, "Minute is not between 0 and 60.")
        @assert(0 ≤ second < 60, "Second is not between 0 and 60.")

        if hour == 24 hour = 0 end

        new(hour, minute, second)
    end
end

#==
The struct MyTime2 has 4 inner constructor methods:
    MyTime2()
    MyTime2(hour::Int64)
    MyTime2(hour::Int64, minute::Int64)
    MyTime2(hour::Int64, minute::Int64, second::Int64)
==#

hour = 16
minute = 17
second = 19

MyTime2()
MyTime2(hour::Int64)
MyTime2(hour::Int64, minute::Int64)
MyTime2(hour::Int64, minute::Int64, second::Int64)


hour = 24.0
MyTime2(hour, minute, second)

#==
hour = 25
MyTime2(hour::Int64, minute::Int64, second::Int64)
==#

mtime = MyTime2(hour, minute, second)

#---

mutable struct MyTime3
    hour    :: Int
    minute  :: Int
    second  :: Int

    function MyTime3(hour::Int64 = 0, minute::Int64 = 0, second::Int64 = 0)
        @assert(0 ≤ hour ≤ 24, "Minute is not between 0 and 60.")
        @assert(0 ≤ minute < 60, "Minute is between 0 and 60.")
        @assert(0 ≤ second < 60, "Second is between 0 and 60.")

        time = new()
        time.hour = hour
        time.minute = minute
        time.second = second
        return time
    end
end

#---

using Printf

function Base.show(io::IO, time::MyTime2)
    @printf(io, "%02d:%02d:%02d\n", time.hour, time.minute, time.second)
end

fout = open("output.txt", "w")
mtime = MyTime2(9, 30, 5)
show(fout, mtime)

close(fout)

#---

show(mtime)

#---

import Base.+

function timetoint2(time::MyTime2)::Int64
    return time.second + time.minute * 60 + time.hour * 3600
end

function inttotime2(seconds::Int64)::MyTime2
    m, s = divrem(seconds, 60)
    h, m = divrem(m, 60)
    d, h = divrem(h, 24)
    return MyTime2(h, m, s)
end


function +(t1::MyTime2, t2::MyTime2)
    seconds = timetoint2(t1) + timetoint2(t2)
    return inttotime2(seconds)
end


start = MyTime2(9, 45)
duration = MyTime2(1, 35, 0)

start + duration

#---

function increment2(time::MyTime2, seconds::Int64)::MyTime2
    s = seconds + timetoint2(time)
    return inttotime2(seconds)
end

function +(time::MyTime2, seconds::Int64)
    increment2(time, seconds)
end

function +(seconds::Int64, time::MyTime2)
    return time + seconds
    end

start + 37

37 + start

#---

t1 = MyTime2(1, 7, 2)
t2 = MyTime2(1, 5, 8)
t3 = MyTime2(1, 5, 0)

# polymorphic function: works because of the + method just defined
sum((t1, t2, t3))   

#---

# Exercises 