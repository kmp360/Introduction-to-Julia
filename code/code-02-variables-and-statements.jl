#  Code examples for Chapter 02 – Variables, Expressions and Statements
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.9.3\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2023\\lectures-1.9")
#---

# Exercise 2-2

n = 17
println(n)

x = y = z = 10

typeof(y)

x = 10.
typeof(x)

z

y = "string".

y = "string"

y = "string"


z = 5; xz
x*z

#---

# Exercise 2-3

r = 5
volume = 4π*r^3/3

n = 60
cost = (24.95*0.60)*n + 3 + 0.75*(n-1)

leave = [6, 52, 0]
sec = 3600*leave[1] + 60*leave[2] + leave[3]

run = 2*[0, 8, 15] + 3*[0, 7, 12]

runtime_sec = sec + 3600*run[1] + 60*run[2] + run[3]

hour = runtime_sec ÷ 3600
minute = (runtime_sec - hour*3600) ÷ 60
second = runtime_sec - hour*3600 - minute*60

home = [hour; minute; second]

home1 = [hour minute second]

home2 = [hour, minute, second]
#==============================================================================#
