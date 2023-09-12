#  Code examples for Chapter 03 – Functions
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.9.3\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2023\\lectures-1.9")
#---

printlyrics()   # function call

# function definition
function printlyrics()
    println("I'm a lumberjack, and I'm okay.")
    println("I sleep all night and I work all day.")
    println()
end

# function call
printlyrics()

printlyrics

#---

function repeatlyrics()
	printlyrics()
	printlyrics()
    printlyrics()
end

repeatlyrics()

#---

function printtwice(bruce)
    println(bruce)
	println(bruce)
    println()
end

printtwice("eva")

printtwice(43)

#---

function cattwice(part1, part2)
    concat = part1 * part2
    printtwice(concat)
end

#---

result = printtwice("Bing")

show(result)

print(result)

println(result)

#---

# Exercise 3-3

function do_twice(f)
    f()
    f()
end

function printspam()
    println("spam")
end

do_twice(printspam)


function do_twice(f, x)
    f(x)
    f(x)
end

function printtwice(bruce)
    println(bruce)
	println(bruce)
end

do_twice(printtwice, "spam")


function do_n(f, x, n)
    for i in n
        f(x)
    end
end

function print_once(bruce)
    println(bruce)
end

do_n(print_once, "spam", 5)

#---

f = () -> printspam()          # named anonymous function
do_twice(f)

do_twice( () -> printspam() )  # unnamed anonymous function passed as an argument

#---

# Exercise 3-4

function do_n_1(f, x, n=2)
    for i in 1:n
        f(x)
    end
end

function do_n_2(f, x, y, n=2)
    for i in 1:n
        f(x, y)
    end
end

function do_n_3(f, x, y, z, n=2)
    for i in 1:n
        f(x, y, z)
    end
end

function print_element(str1, str2)
    print(str1*" ")
    do_n_1(print, str2*" ", 4)
end

function printhorizontal(str1, str2, str3)
    do_n_2(print_element, str1, str2, 2)
    println(str3)
end

function printgrid()
    printhorizontal("+", "-", "+")
    do_n_3(printhorizontal, "|", " ", "|", 4)
    printhorizontal("+", "-", "+")
    do_n_3(printhorizontal, "|", " ", "|", 4)
    printhorizontal("+", "-", "+")
end


print_element("+", "-")

printhorizontal("+", "-", "+")

printhorizontal("|", " ", "|")

do_n_3(printhorizontal, "|", " ", "|")

printgrid()

#---

# a simple alternative
function printgrid1()
    printhorizontal("+", "-", "+")
    for i in 1:4
        printhorizontal("|", " ", "|")
    end
    printhorizontal("+", "-", "+")
    for i in 1:4
        printhorizontal("|", " ", "|")
    end
    printhorizontal("+", "-", "+")
end

printgrid1()

