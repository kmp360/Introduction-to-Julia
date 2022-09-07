#  Code examples for Chapter 05 -- Conditionals and Recursion 
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.8.0\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2022\\lectures-1.8")
#---

function countdown(n)
    if n ≤ 0
        println("Blastoff!")
    else
        print(n, " ")
        countdown(n - 1)
    end
end

countdown(5)

#---

function printn(s, n)
    if n ≤ 0
        return
    end
    println(s)
    printn(s, n - 1)
end

printn("spam", 5)

#---

function recurse()
	recurse()
end

#recurse()

#---

signal_power = 9
noise_power = 10

ratio = signal_power ÷ noise_power
decibels = 10 * log10(ratio)

print(decibels)

#---

# Exercise 5-2

function TimeOfDay()
    minute = 60
    hour = 60 * minute
    day = 24 * hour

    t = time()

    number_of_days, seconds_left = divrem(t, day)
    hour_of_day, seconds_left = divrem(seconds_left, hour)
    minute_of_day, seconds_left = divrem(seconds_left, minute)
    second_of_day = round(seconds_left)

    number_of_days = convert(Int, number_of_days)
    hour_of_day = convert(Int, hour_of_day)
    minute_of_day = convert(Int, minute_of_day)
    second_of_day = convert(Int, second_of_day)

    #[hour_of_day, minute_of_day, second_of_day]
    println()
    println("Number of days since the epoch: $number_of_days")
    println("Time of day: $hour_of_day : $minute_of_day : $second_of_day")
end

TimeOfDay()

#---

# Exercise 5-3  # run the whole code block in the Julia REPL
    
function FLT(a, b, c, n)
    if n > 2 && a^n + b^n == c^n
        println("Fermat was wrong.")
    else
        println("It's ok.")
    end
end

function FLTpromt()
    print("Enter a: ")
    a = parse(Int, readline())
    println()
    print("Enter b: ")
    b = parse(Int, readline())
    println()
    print("Enter c: ")
    c = parse(Int, readline())
    println()
    print("Enter n: ")
    n = parse(Int, readline())

    FLT(a, b, c, n)
end

FLTpromt()
#---

# Exercise 5-5

"""
recurse(n, s)
    recurse computes s + n + (n-1) + ... + 1
    n: non-negative Integer
    s: sum offset
"""
function recurse(n, s)
    if n == 0
        println(s)
    else
        println(s)
        recurse(n-1, n+s)
    end
end

recurse(5, 2)
