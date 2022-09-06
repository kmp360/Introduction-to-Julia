"Code example for Chapter 10 -- Arrays"

#---

let
    cheeses = ["Cheddar", "Edam", "Gouda"]

    for cheese in cheeses
        println(cheese)
    end
end

#---
let
    numbers = [42, 123]

    for i in eachindex(numbers)
        numbers[i] = numbers[i] * 2
    end

    numbers
end

#---
t = ['a', 'b', 'c']
push!(t, 'd')

#---
t1 = ['a', 'b', 'c']
t2 = ['d', 'e']
append!(t1, t2)

#---
t3 = ['d', 'c', 'e', 'b', 'a']
sort!(t3)

#---
function addall(t)
    total = 0
    for x in t
        total += x
    end
    total
end

#---
function capitalizeall(t)
    res = []
    for s in t
        push!(res, uppercase(s))
    end
    return res
end

capitalizeall("banana")

#---
function onlyupper(t)
    res = []
    for s in t
        if s == uppercase(s)
            push!(res, s)
        end
    end
    return res
end

onlyupper("bAnAnA")

#---
t = uppercase.(["abc", "def", "ghi"])
print(t)

#---
t = ['a', 'b', 'c']
splice!(t, 2)
print(t)

#---
t = ['a', 'b', 'c']
pop!(t)
print(t)

#---
t = ['a', 'b', 'c']
popfirst!(t)
print(t)
pushfirst!(t, 'd')
print(t)
push!(t, 'c')
print(t)
print(deleteat!(t, 2))
print(insert!(t, 2, 'x'))

#---
t = collect("spam")
print(t)
t = split("pining for the fjords")
print(t)
t = split("spam-spam-spam", '-')
print(t)

#---
t = ["pining", "for", "the", "fjords"]
s = join(t, ' ')
print(s)

#---
a = [1, 2, 3]
b = a
b ≡ a

b[1] = 42
print(a)

#---
t1 = [1, 2]
t2 = push!(t1, 3);
print(t1)

t3 = vcat(t1, [4]);
print(t1)
print(t3)

#---
insert!(t, 4, x)
push!(t, x)
append!(t, [x])

#---
"Exercise 10-1"

function nestedsum(array)
    sum = 0
    for element in array
        for number in element
            sum = sum + number
        end
    end
    return sum
end

nestedsum([4 5])
nestedsum([4 5; 6 7])
nestedsum([[1 2], [3], [4 5; 6 7]])

#---
"Exercise 10-2"

function cumulsum(array)
    len = length(array)
    CS = zeros(len)
    sum = 0
    for k = 1:len
        sum = sum + array[k]
        CS[k] = sum
    end
    return CS
end

cumulsum([4 5])
cumulsum([4 5; 6 7])

#---
"Exercise 10-3"

function interior(array)
    a = array[:]
    return a[2:end-1]
end

interior([4 5; 6 7])
interior([6 7])
interior([4 5 6 7])

#---
"Exercise 10-4"

function interior!(b)
    global b = b[2:end-1]
    return nothing
end

b = [4 5 6 7]
interior!(b)
b

#---
"Exercise 10-5"

function issort(array)
    a = sort(array, dims = 2)
    return a == array
end

issort([1 2 2])
issort([1 3 2])
issort(['b' 'a'])
issort(['a' 'b'])

#---
"Exercise 10-6"

function isanagram(word1::String, word2::String)::Bool
    if sizeof(word1) != sizeof(word2)
        return false
    else
        set1 = join(sort(collect(word1)))
        set2 = join(sort(collect(word2)))
        return set1 == set2
    end
end

isanagram("apa", "pap")

#---
"Exercise 10-7"

function hasduplicates(array)
    return !(sizeof(union(array)) == sizeof(array))
end

hasduplicates(['a' 'p' 'a'])
hasduplicates([1 2 1])
hasduplicates([1 2 3])

#---
"Exercise 10-8"

function relfreq(n = 1e6)
    sum = 0
    for k = 1:n
        if hasduplicates(rand(1:364, 23))
            sum += 1
        end
    end
    return sum / n
end

relfreq()
relfreq(1000)

#---
"Exercise 10-9"

function createArray()

    filename = "E:\\aaa-Julia-course-2022\\lectures\\words.txt"
    fileIn = open(filename)
    lexicon = []
    for word in eachline(fileIn)
        push!(lexicon, word)
    end
    close(fileIn)
    return lexicon
end


function createArray2()
    filename = "E:\\aaa-Julia-course-2022\\lectures\\words.txt"
    fileIn = open(filename)
    lexicon = []
    for word in eachline(fileIn)
        lexicon = [lexicon..., word]
    end
    close(fileIn)
    return lexicon

end


begin
    lexicon = createArray()
    lexicon2 = createArray2()
end


#---
"Exercise 10-10"

function inbisect(array, word, flag = false)
    len = length(array) ÷ 2
    if len < 1
        return flag = false
    elseif len == 1
        return flag = (word in array)
    elseif word > array[len]
        flag = inbisect(array[len+1:end], word, flag)
    else
        flag = inbisect(array[1:len], word, flag)
    end
    return flag
end

array = createArray()

inbisect(array, "aadvark")

#---
"Exercise 10-11"

function reversepairs()
    array = createArray()
    pairarray = []
    for word in array
        reverseword = word[end:-1:1]
        if inbisect(array, reverseword)
            push!(pairarray, [word, reverseword])
        end
    end
    return pairarray
end

pairs = reversepairs()

#---
"Exercise 10-12"

function interlock()

    array = createArray()
    intrlock_1 = Array{Array{String, 1}, 1}()
    intrlock_2 = Array{Array{String, 1}, 1}()

    for word in array
        w1 = word[1:2:end]
        w2 = word[2:2:end]

        if inbisect(array, w1) && inbisect(array, w2)

            push!(intrlock_1, [w1, w2, word])

            if length(w1) == length(w2)
                push!(intrlock_2, [w1, w2, word])
            end
        end
    end
    return intrlock_1, intrlock_2
end


using BenchmarkTools

@btime begin

    intrloc_1, intrloc_2 = interlock()

end

#=============================================================================#
