# "Code example for Chapter 16 -- Structs and functions"
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.9.3\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2023\\lectures-1.9")
#---

"""
Represents the time of day.
fields: hour, minute, second
"""
struct MyTime
    hour    ::Int64
    minute  ::Int64
    second  ::Int64
end

time = MyTime(11, 59, 30)

dump(time)

#---

# Exercise 16-1

using Printf

@printf("%.0f %.1f %f", 0.5, 0.025, -0.0078125)     #just a reminder

function printtime(time::MyTime)

    @printf("%02d:%02d:%02d", time.hour, time.minute, time.second)
end

printtime(time)

printtime(MyTime(127, 9, 0))

#---

# Exercise 16-2

function isafter(t1::MyTime, t2::MyTime)
    (t1.hour, t1.minute, t1.second) > (t2.hour, t2.minute, t2.second)
end

t1 = MyTime(1,1,0)
t2 = MyTime(0,1,1)
isafter(t1, t2)

#---

function addtime(t1::MyTime, t2::MyTime)
    MyTime(t1.hour + t2.hour, 
        t1.minute + t2.minute, 
        t1.second + t2.second)
end

start = MyTime(9, 45, 0)
duration = MyTime(1, 35, 0)
done = addtime(start, duration)
printtime(done)


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

# Exercise 16-3

mutable struct mMyTime
    hour    ::Int64
    minute  ::Int64
    second  ::Int64
end

function increment!(time::mMyTime, seconds::Int64)
    s = seconds + 
        time.second +
        time.minute * 60 + 
        time.hour * 3600

    m, s = divrem(s, 60)
    h, m = divrem(m, 60)
    d, h = divrem(h, 24)
   
    time.second = s
    time.minute = m
    time.hour = h
end

#---

# Exercise 16-4

function timetoint(time)::Int64
    return time.second + time.minute * 60 + time.hour * 3600
end

function inttotime(seconds::Number)::MyTime
    m, s = divrem(seconds, 60)
    h, m = divrem(m, 60)
    d, h = divrem(h, 24)
    return MyTime(h, m, s)
end

seconds = timetoint(MyTime(1, 1, 10))
inttotime(seconds)

function increment(time::MyTime, seconds::Int64)::MyTime
    s = seconds + timetoint(time)
    return inttotime(s)
end

function addtime3(t1::MyTime, t2::MyTime)::MyTime
    return inttotime(timetoint(t1) + timetoint(t2))
end

#---

# Exercise 16-5

function increment2!(time::mMyTime, seconds::Int64)
    t = inttotime(seconds + timetoint(time))
    time.second = t.second
    time.minute = t.minute
    time.hour = t.hour
end

#---

function isvalidtime(time)
    if time.hour < 0 || time.minute < 0 || time.second < 0
        return false
    end
    if time.minute >= 60 || time.second >= 60
        return false
    end
    return true
end

function addtime4(t1::MyTime, t2::MyTime)::MyTime
    if !isvalidtime(t1) || !isvalidtime(t2) 
        # alternative: !( isvalidtime(t1) && !isvalidtime(t2) )
        error("invalid MyTime object")
    end
    seconds = timetoint(t1) + timetoint(t2)
    return inttotime(seconds)
end

function addtime5(t1::MyTime, t2::MyTime)::MyTime
    @assert(isvalidtime(t1) && isvalidtime(t2), "invalid MyTime object")
    seconds = timetoint(t1) + timetoint(t2)
    return inttotime(seconds)
end

#---

# Exercise 16-6

function multime(t::MyTime, m::Number)::MyTime
    return inttotime(round(m*timetoint(t)))
end

mt = multime(MyTime(1, 33, 47), 0.1)

function pace(t::MyTime, m::Number)

    try
        return multime(t, 1/m)
    catch exc
        println("Something went wrong. Path length: $m")
        println("$exc")
    end
end

p = pace(MyTime(1, 33, 47), 10)

typeof(p)

println("Pace: $(p.minute) minutes and $(p.second) seconds per kilometer")

#---

# Exercise 16-7

