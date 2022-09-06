""" Square roots and Newton's method
For a given function f = f(x) with known derivative f' = df/dx not equal to 0,
    the Newton step is given by: x = x - f(x)/f'(x).

    Ex: f(x) = x² - a implies that f'(x) = 2x so the Newton step is given by
    x = x - (x² - a)/2x = x - (x - a/x)/2 = (x + a/x)/2

"""
function mysqrt1(a, ϵ=1e-6)
    a = abs(a)
    x = a/2
    #println()
    while true
        #println(x)
        y = (x + a / x) / 2     #Newton step
        if abs(y - x) < ϵ
            b = sqrt(a)
            println()
            println("Numerically the √$a is $x ≈ $b")
            return y
            break
        end
        x = y
    end
end

mysqrt1(3, 1e-12)

#---

function mysqrt2(a)
    x = a/2

    while true

        y = (x + a / x) / 2

        if y ≈ x
            println()
            println("Numerically the √$a is $x ≈ $(sqrt(a))")
            return y
            break
        end
        x = y
    end
end

mysqrt2(3)

#---

using Printf

function mysqrt(a, ϵ=1e-6)
    x = a/2

    while abs(x^2 - a) > ϵ^2
        #println(x)
        x = (x + a / x) / 2
    end
    #println()
    #println("Numerically the √$a is $x ≈ $(sqrt(a))")
    return x
end

function printheader()
    println()
    println("a\t mysqrt\t\t\tsqrt\t\t\tdiff")
    println("-\t ------\t\t\t----\t\t\t----")
end

function printtable()
    printheader()
    for ind in 1:10
        msqrt = mysqrt(ind)
        srt = sqrt(ind)
        diff = abs(msqrt - srt)
        s = @sprintf("%.1f\t %.15f\t%.15f\t%.10e", ind, msqrt, srt, diff);
        println(s)
    end
end

printtable()

#==============================================================================#
