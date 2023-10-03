# "Code examples for Chapter 12  -- Tuples"
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.9.3\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2023\\lectures-1.9")
#---

a = 1;
b = 2;
a, b = b, a     # value swap

#---

function minMax(t)
    minimum(t), maximum(t)
end

tpl = ('a', 'b', 'c', 'd', 'e')

minMax(tpl)
extrema(tpl)

#---

function printall(args...)
    println(args)
end

printall(1, 2.0, '3', 4)

#---

sum(1, 2, 3)
sum( (1, 2, 3) )
sum(k for k = 1:3)

(k for k = 1:3)

[k for k = 1:2:10]

#---

s = "abc"
t = [1, 2, 3]

zip(s, t)

for pair in zip(s, t)
    println()
    println(pair)
    println(pair...)
end

#---

t = [('a', 1), ('b', 2), ('c', 3)]

for (letter, number) in t     # note the automatic splitting by (letter, number)
    println(number, " ", letter)
end

#---

z = collect(zip("Anne", "Elk"))

for c in z
    println()
    println(c)
    println(c...)
    println(c[1], " ", c[2])
end

for (a, b) in z
    println()
    println(a, b)
    println(a, " ", b)
end

#---

function hasmatch(t1, t2)
    for (x, y) in zip(t1, t2)
        if x == y
            return true
        end
    end
    return false
end

#---

for (index, element) in enumerate("abc")
    println()
    println(index, " ", element)
end

#---

d = Dict('a' => 3, 'b' => 2, 'c' => 1)

for (key, value) in d
    println()
    println(value, " ", key)
end

ks = sort(collect(keys(d)))
for key in ks
    println(key, " ", d[key])
end

#---

str = "acb"
nar = [3, 2, 1]

d = Dict(zip(str, nar))

ks = collect(keys(d))
vs = collect(values(d))

pind = sortperm(ks)
[ks[pind] vs[pind]]

pind2 = sortperm(vs)
[ks[pind2] vs[pind2]]

# alternatively
str = "acb"
nar = [3, 2, 1]

m1 = sort(collect(zip(str, nar)), by = x -> x[1])
N = length(m1)
M1 = Array{Any,2}(undef,N,2)
for r = 1:N, c = 1:2
    M1[r,c] = m1[r][c]
end
M1

m2 = sort(collect(zip(str, nar)), by = x -> x[2])
M2 = Array{Any,2}(undef,N,2)
for r = 1:N, c = 1:2
    M2[r,c] = m1[r][c]
end
M2

#---

t = [('a', 1), ('c', 3), ('b', 2)]
d = Dict(t)

#---

d = Dict(zip("abc", 1:3))

#---
# "Exercise 12-1"

function sumall_jose(arg...)
    return sum(arg)
end

function sumall(arg...)
    sum = 0
    for number in arg
        sum += number
    end
    return sum
end

sumall(1, 2, 3), sumall_jose(1, 2, 3)
sumall(1, 2, 3, 4), sumall_jose(1, 2, 3, 4)
sumall((1, 2, 3))
sumall((1, 2, 3)...)

sum( (5, 7, 1) )

#---
# "Exercise 12-2"

function lexiconDict()
    fullpth = "E:\\aaa-Julia-course-2023\\lectures-1.9\\words.txt"
    fileIn = open(fullpth)

    lexiconDict = Dict{String, Array{Char,1}}()
    for word in eachline(fileIn)
        lexiconDict[word] = collect(word)
    end
    close(fileIn)
    return lexiconDict
end

function letter_freqDict(lexiconDict)
    d = Dict{Char, Int}()
    for word in keys(lexiconDict)
        for chr in lexiconDict[word]
            d[chr] = get(d, chr, 0) + 1
        end
    end
    return d
end

function mostfrequent(word, letter_freqDict)
    wrd = collect(word)
    lf = []
    for chr in wrd
        push!(lf, letter_freqDict[chr])
    end
    sc_wrd = sort(collect(zip(wrd, lf)), by = x -> x[2], rev = true)
    #@show sc_wrd
    for (chr, nmr) in sc_wrd
        print(chr, " ")
    end
end


wordDict = lexiconDict()
LF = letter_freqDict(wordDict)
mostfrequent("brontosaurus", LF)

#---
# "Exercise 12-3"

using Primes

function slurp()
    """slurp in word list"""
    fhandle = open(
        "E:\\aaa-Julia-course-2023\\lectures-1.9\\words.txt",
        "r",
    )
    words = String[]
    letterFreq = Dict{Char,Int16}()
    for line in eachline(fhandle)
        push!(words, line)
        letter = line[rand(1:length(line))]      # sampling
        letterFreq[letter] = get(letterFreq, letter, 0) + 1
    end
    close(fhandle)
    return words, letterFreq
end

words, letterFreq = slurp()

sortedLet = sort(collect(letterFreq), by = x -> x[2], rev = true)


using BenchmarkTools

#@time begin
#@benchmark begin

function codeLetters()
    """code letters as prime numbers"""

    letterCode = Dict{Char,Int}()
    sortedLet = sort(collect(letterFreq), by = x -> x[2], rev = true)

    prevPrime = 2
    for k = 1:size(sortedLet, 1)
        newPrime = nextprime(prevPrime + 1)
        letterCode[sortedLet[k][1]] = newPrime
        prevPrime = newPrime
    end
    return letterCode
end

letterCode = codeLetters()


function anagramHash()
    """ create a hash table of anagram arrays """

    anaHash = Dict{BigInt,Array{String,1}}()
    for line in words
        goedelRules = 1
        for letter in line
            goedelRules *= letterCode[letter]
        end
        if haskey(anaHash, goedelRules)
            anaHash[goedelRules] = push!(anaHash[goedelRules], line)
        else
            anaHash[goedelRules] = [line]
        end
    end
    return anaHash
end

anaHash = anagramHash()


function anaGrams(anaHash)
    """ create a vector of anagram arrays """
    ana = collect(values(anaHash))
    a_ind = findall(x -> length(x) > 1, ana)
    ana = ana[a_ind]
    sort!(ana, by = x -> length(x), rev = true)
    return ana
end

ana = anaGrams(anaHash)


function printAnagrams(ana::Vector{Array{String,1}}, n::Int64)
    try
        for k = 1:n
            println(sort!(ana[k]))
        end
    catch
        for element in ana
            println(sort!(element))
        end
    end
end

printAnagrams(ana, 20);


# end # end of timing

#---
# "Exercise 12-4"

function anagramCodes(ana)
    """ create an array of word codes arrays """

    anaCode = Array{Array{Vector,1},1}()
    for vector in ana
        v = []
        for word in vector
            w = []
            for letter in word
                push!(w, letterCode[letter])
            end
            push!(v, w)
        end
        push!(anaCode, v)
    end
    return anaCode
end

anaCodes = anagramCodes(ana)


function metaThesis()
    metapairs = Vector{Array{String,1}}()
    for i = 1:length(anaCodes)
        for j = 1:length(anaCodes[i])
            for k = (j+1):length(anaCodes[i])
                d = anaCodes[i][j] - anaCodes[i][k]
                ind = findall(x -> x != 0, d)
                if length(ind) == 2
                    push!(metapairs, [ana[i][j], ana[i][k]])
                end
            end
        end
    end
    return metapairs
end

metapairs = metaThesis()


function printMetapairs(metapairs::Vector{Array{String,1}}, n::Int64)
    try
        for k = 1:n
            println(sort!(metapairs[k]))
        end
    catch
        for element in metapairs
            println(sort!(element))
        end
    end
end

printMetapairs(metapairs, 20)




