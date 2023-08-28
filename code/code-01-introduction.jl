#  "Code examples for Chapter 01 -- The Way of the Program"
#   C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.9.3\bin\julia.exe
#   cd("E:\\aaa-Julia-course-2023\\lectures-1.9")
#---

println("Hello, World!")

begin

    println()
    println("Hello, World!")
    println()

end

#---

÷     # ÷ is \div<TAB>

div

#---

typeof(2)

typeof(42.0)

typeof("Hello, World!")

#---

typeof(42 / 2)

typeof(42 ÷ 2)

#---

1, 000, 000     # tuple = comma seperated list (1, 0, 0)

typeof( 1, 000, 000 )

typeof( (1, 000, 000) )

1_000_000
typeof(1_000_000)

#---

# Exercise 1-2

sec = 42 * 60 + 42
miles_per_kilometer = 1 / 1.61
miles = 10 * miles_per_kilometer

seconds = 37 * 69 + 48
speed = miles / seconds
pace = 1 / speed   # in seconds per mile

pace_minutes = pace ÷ 60
pace_seconds = pace - pace_minutes * 60

min, sec = divrem(pace, 60)

println("time = $min minutes and $sec seconds")



min = Int(min)
sec = Int(round(sec))
println("time = $min minutes and $sec seconds")

#==============================================================================#
