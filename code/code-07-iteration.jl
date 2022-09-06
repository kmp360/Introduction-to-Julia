"Code examples for Chapter 07 -- Iteration"

#---
function countdown(n)
    while n > 0
        print(n, " ")
        n = n - 1
    end
    println("Blastoff!")
end

#---
function seq(n)
    while n != 1
        println(n)
        if n % 2 == 0        # n is even
            n = n / 2
        else                 # n is odd
            n = n * 3 + 1
        end
    end
end

#---
while true
    print("> ")
    line = readline()
    if line == "done" || line == "Done"
        break
    end
    println(line)
end

println("Done!")

#---
for i = 1:10
    if i % 3 == 0
        continue
    end
    print(i, " ")
end

#---
let
    a = 2
    x = 5
    ε = 1e-6

    while true
        println(x)
        y = (x + a / x) / 2
        if abs(y - x) < ε
            break
        end
        x = y
    end

    println()

    while true
        println(x)
        y = (x + a / x) / 2
        if y ≈ x                # \approx<tab>
            break
        end
        x = y
    end
end

#---
"Exercise 7-2"


Pkg.add("Printf")
using Printf

println()
@printf("%.0f %.1f %f\n", 0.5, 0.025, -0.0078125)
println()
s = @sprintf("this is a %s %15.1f", "test", 34.567)
println(s)


function mysqrt(a)
    a = abs(a)
    x = 1
    while true
        #println(x)
        y = (x + a / x) / 2
        if y ≈ x
            return y
            break
        end
        x = y
    end
end

 mysqrt(100)

function printheader()
    println("a\t mysqrt\t\t\tsqrt\t\t\tdiff")
    println("-\t ------\t\t\t----\t\t\t----")
end


function printtable()
    printheader()
    for ind in 1:10
        msrt = mysqrt(ind)
        srt = sqrt(ind)
        diff = abs(msrt - srt)
        s = @sprintf("%.1f\t %.15f\t%.15f\t%.10e", ind, msrt, srt, diff);
        println(s)
    end
end

printtable()

#---
"Exercise 7-3"

function evalloop()
    expr = ""
    while true
        println("Enter an expression: ")
        str = readline()
        if str == "done" || str == "Done"
            println("Ciao! $expr")
            break
        else
            expr = eval(Meta.parse(str))
            println(expr)
        end
    end
end

evalloop()

#---
"Exercise 7-4"

function estimatepi()
    ϵ = 1e-15
    α = 2*sqrt(2)/9801
    sum = 0
    term = 1
    k = 0
    while term >= ϵ
            println("$k")
        factor1 = (1103+26390k) / 396^(4k)
        factor2 = factorial(4k) / factorial(k)^4
        term = factor1 * factor2
        sum = sum + α*term
        k += 1
    end
    return 1/sum
end

estimatepi()
pi - estimatepi()
println(pi - estimatepi())
#==============================================================================#
