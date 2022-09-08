# "Code examples for Chapter 06 -- More on Functions"
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.8.0\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2022\\lectures-1.8")
#---

# "Exercise 6-1"

function comp(x, y)
    if x > y
        return 1
    elseif x == y
        return 0
    else
        return -1
    end
end

comp(2, 3)


#---

begin

	function distance(x₁, y₁, x₂, y₂)
		return sqrt( (x₂ - x₁)^2 + (y₂ - y₁)^2 )
	end

	function area(radius)
        return π * radius^2
    end

	function circlearea(xc, yc, xp, yp)
		return area(distance(xc, yc, xp, yp))		# function composition
	end

	circlearea(0, 0, 0, 1)

end

#---

function isdivisible(x, y)
    x % y == 0
end

isdivisible(123, 22)

let
    x = 123
    y = 22

    if isdivisible(x, y)
        println("x is divisible by y")
		println()
	else
		println("x is not divisible by y")
		println()
    end
end


#---

# "Exercise 6-3"

    function isbetween(x, y, z)
        return x ≤ y ≤ z
    end

    isbetween(1, 15, 10)

#---

let
    function fact(n)
        if n == 0
            return 1
        else
            return n * fact(n - 1)
        end
    end

    fact(4)
end

#---

let
    function fib(n)
        if n == 0
            return 0
        elseif n == 1
            return 1
        else
            return fib(n - 1) + fib(n - 2)
        end
    end

    fib(7)
end

#---

let
    function fact(n)
        if !(n isa Int64)			# guardian
            error("Factorial is only defined for integers.")
        elseif n < 0
            error("Factorial is not defined for negative integers.")
        elseif n == 0
            return 1
        else
            return n * fact(n - 1)
        end
    end

    fact(1.5)
end

#---

let
    function fact(n)
        space = " "^(4 * n)
        println(space, "factorial ", n)
        if n == 0
            println(space, "returning 1")
            return 1
        else
            recurse = fact(n - 1)
            result = n * recurse
            println(space, "returning ", result)
            return result
        end
    end

    fact(4)
end

#---

# "Exercise 6-6"

function frst(word)
    first = firstindex(word)
    return word[first]
end

function lst(word)
    last = lastindex(word)
    return word[last]
end

function middle(word)
    first = firstindex(word)
    last = lastindex(word)
    return word[nextind(word, first):prevind(word, last)]
end

# development and testing version
function ispalindrome_preliminary(word, flag = true)

    println("$(length(word))")

    if length(word) <= 1
        println("last $(length(word))")
        return flag

    elseif !(frst(word) == lst(word))
        flag = false
        println("1st $flag")
        return flag
    end

    flag = ispalindrome_preliminary(middle(word), flag)
    println("2nd $flag")
    return flag

end

ispalindrome_preliminary("abccba")


# final version
function ispalindrome(word::String, flag=true)
    word = lowercase(word)
    if length(word) <= 1
        return flag
    elseif !(frst(word) == lst(word))
        flag = false
        return flag
    end
    flag = ispalindrome(middle(word), flag)
    return flag
end

ispalindrome("AbCCBA")

#---

# "Exercise 6-7"

# development and testing version
function ispower_preliminary(a, b, flag=false)

    println("1st $a")

    if a == 1
        flag = true
        return flag

    elseif a % b > 0
        println("2nd $a")
        flag = false
        return flag

    else
        println("3rd $a")
        flag = ispower_prel(a ÷ b, b, flag)
    end

    return flag
end

ispower_preliminary(1, 2)


# final version
function ispower(a, b, flag=false)
    if !(typeof(a)==Int64) || a < 1
        println("Input has to be a positive integer.")
        return flag = nothing
    elseif a == 1
        return flag = true
    elseif a % b > 0
        return flag = false
    else
        flag = ispower(a ÷ b, b, flag)
    end
    return flag
end

ispower(16, 2)

#---

# "Exercise 6-8"

"""
One way to find the GCD of two numbers is based on the observation that
 if r is the remainder when a is divided by b, then gcd(a, b) = gcd(b, r).
     As a base case, we can use gcd(a, 0) = a.
"""
function GCD(a, b)
    if b == 0
        return a
    else
        GCD(b, a % b)
    end
end

GCD(123, 10)
#==============================================================================#
