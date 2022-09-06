"Code examples for Chapter 11 -- Dictionaries"

#---
function histogram(s)
    d = Dict()
    for c in s
        if c ∉ keys(d)
            d[c] = 1
        else
            d[c] += 1
        end
    end
    return d
end

#---
"Exercise 11-1"

function histogram2(s)
    d = Dict()
    for c in s
        d[c] = get(d, c, 0) + 1
    end
    return d
end

h = histogram2("brontosaurus")

#---
function printhist(h)
    for c in keys(h)
        println(c, " ", h[c])
    end
end

printhist(h)

#---
function printhist2(h)
    for c in sort(collect(keys(h)))
        println(c, " ", h[c])
    end
end

printhist2(h)

#---
function reverselookup(d, v)
    for k in keys(d)
        if d[k] == v
            return k
        end
    end
    error("LookupError - value v is not in the dictionary d")
end

h = histogram2("parrot")
reverselookup(h, 2)
reverselookup(h, 3)

findall(x -> x == 2, h)

#---
function invertdict(d)
    inverse = Dict()
    for key in keys(d)
        val = d[key]
        if val ∉ keys(inverse)
            inverse[val] = [key]
        else
            push!(inverse[val], key)
        end
    end
    inverse
end

hist = histogram("parrot")
inverse = invertdict(hist)

#---
known = Dict(0 => 0, 1 => 1)

function fibonacci(n)
    if n in keys(known)
        return known[n]
    end
    res = fibonacci(n - 1) + fibonacci(n - 2)
    known[n] = res
    res
end

fibonacci(1000)
fibonacci(10000)  # is negative, what happend?

#---
known = Dict(0 => 0, 1 => 1);
println(known)

function example4()
    known[2] = 1
    println("\nrunning example4\n")
end

example4()

println(known)

#---
known2 = Dict(0 => 0, 1 => 1);
println(known2)

function example5()
    global known2 = Dict()
    println("\nrunning example5\n")
end

example5()

println(known2)

#---
const known3 = Dict(0 => 0, 1 => 1)
println(known3)

function example6()
    known3[2] = 1
end

example6()

println(known3)

#---
function createDict()
    fileIn = open(
        "E:\\aaa-Julia-course-2022\\lectures\\words.txt")
    wrdDct = Dict{String, Int}()
    M = 0; W = ""
    for word in eachline(fileIn)
        len = length(word)
        wrdDct[word] = len
        if M < len
            M = len
            W = word
        end
    end
    close(fileIn)

    return wrdDct
end


function interlock()
    wrdDct = createDict()
    intrlock_1 = Array{Array{String, 1}, 1}()
    intrlock_2 = Array{Array{String, 1}, 1}()

    for word in keys(wrdDct)
        w1 = word[1:2:end]
        w2 = word[2:2:end]

        if (w1 in keys(wrdDct)) && (w2 in keys(wrdDct))
            push!(intrlock_1, [w1, w2, word])

            if length(w1) == length(w2)
                push!(intrlock_2, [w1, w2, word])
            end
        end
    end
    return [intrlock_1, intrlock_2]
end

using BenchmarkTools

@btime begin

    intrloc = interlock()

end

#---

intrloc = interlock()
intrloc_1 = intrloc[1]

for k = 1:length(intrloc_1)
    println(
        "$(intrloc_1[k][1]) + $(intrloc_1[k][2]) : $(intrloc_1[k][3])"
        )

end


#---
"Exercise 11-3"

function invertdict(d::Dict)
    inverse = Dict()

    for key in keys(d)
        push!(get!(inverse, d[key], []), key)
    end
    return inverse
end

d = Dict("a"=>1, "b"=>2, "c"=>3, 'e'=>3)

invd = invertdict(d)

#---
"Exercise 11-5"

function createArray()
    fileIn = open(
        "E:\\aaa-Julia-course-2022\\lectures\\words.txt")
    wrdDct = Array{String, 1}()

    for word in eachline(fileIn)
        push!(wrdDct, word)
            end
    close(fileIn)

    return wrdDct
end

wrdArray = createArray()

function new_hasduplicates(array)
    d = Dict()
    for k = 1:length(array)
        d[array[k]] = get!(d, array[k], 0) + 1
    end

    return Bool(1 in (values(d) .> 1))
end

using BenchmarkTools
@btime begin
    new_hasduplicates(wrdArray)
end

# from Exercise 10-7
function hasduplicates(array)
    return !(sizeof(union(array)) == sizeof(array))
end

@btime begin
    hasduplicates(wrdArray)
end

#---
"Exercise 11-6"

# from "Exercise 8-11"
function rotatedword(word::String, offset::Int64)
    offset = abs(offset) % 26
    len = sizeof(word)
    rotated_char_array = Array{Char, 1}(undef, len)

    for (k, c) in enumerate(word)

        if c ≥ 'a'
            rotated_char_array[k] = Char(
            Int('a') + (Int(c) - Int('a') + offset) % 26
            )
        else
            rotated_char_array[k] = Char(
            Int('A') + (Int(c) - Int('A') + offset) % 26
            )
        end
    end
    return String(rotated_char_array)
end

arstr = rotatedword("baNaNa", 32)

wrdArray = createArray()

function rotated_pairs(words::Array{String, 1})
    wordDict = Dict(word => [] for word in words)
    rotatedPairs = Dict{String, Array{String, 1}}()

    for word in keys(wordDict)
        for k = 1:25
            if rotatedword(word, k) in keys(wordDict)
                push!(
                    get!(rotatedPairs, word, []),
                        rotatedword(word, k))
            end
        end
    end
    return rotatedPairs
end

@btime begin
    rotatedPairs = rotated_pairs(wrdArray)
end
