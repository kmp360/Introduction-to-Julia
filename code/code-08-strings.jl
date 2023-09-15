# "Code examples for Chapter 8 -- Strings"
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.9.3\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2023\\lectures-1.9")
#---

using Unicode

fruits = "🍌 🍎 🍐"

index = firstindex(fruits)
while index <= sizeof(fruits)
    letter = fruits[index]
    println(index)
    index = nextind(fruits, index)
end

#---

function stringTraversal(str)
    @show index = firstindex(str)
    while index <= sizeof(str)
        letter = str[index]
        println(letter)
        @show index = nextind(str, index)
    end

end

stringTraversal("banana")

stringTraversal(fruits)

#---

function strTraversal(str)
    for letter in str
        println(letter)
    end
end

strTraversal("banana")

#---
# Exercise 8.1

function backward_strTraversal(str)
    for letter in reverse(str)
        print(letter)
    end
end

backward_strTraversal("banana")

#---
# Exercise 8.2

begin

    prefixes = "JKLMNOPQ"
    suffix = "ack"

    for letter in prefixes
        if letter == 'Q'
            println(letter * 'u' * suffix)
        else
            println(letter * suffix)
        end
    end
    
end
#---

function find(word, letter)
    index = firstindex(word)

    while index <= sizeof(word)
        if word[index] == letter
            return index
        end
        index = nextind(word, index)
    end
    return -1
end

function find(word, letter)

    k = 0

    index = firstindex(word)
    for c in word
        k += 1
        if c == letter
            return index, k
        end
        index = nextind(word, index)
    end

    return -1, k
end



ind, cnt = find("abracadabra", 's')

a = find("abracadabra", 's')

#---

function count(word, character)
	counter = 0
	for letter in word
	    if letter == character
	        counter += 1
	    end
	end
	return counter
end

count("abracadabra banana apa", 'a')

#---

firstind = findfirst('c', "abracadabra banana apa")

fin = findfirst("cad", "abracadabra banana apa")

typeof(fin)

dump(fin)

findnext("ana", "bananaanana", 3)

#---

'a' ∈ "banana"      # \in<TAB>

'c' in "banana"

#---

function inboth(word1, word2)
    for letter in word1
        if letter ∈ word2
            print(letter, " ")
        end
    end
end

inboth("apples", "oranges")

#---

function word_comparison(word)
	if word < "banana"
		println("Your word, $word, comes before banana.")
	elseif word > "banana"
		println("Your word, $word, comes after banana.")
	else
		println("All right, bananas.")
	end
end

word_comparison("bananA")

#---

function isreverse(word1, word2)
    if length(word1) != length(word2)
        return false
    end

    i = firstindex(word1)
    j = lastindex(word2)
    while j > 0
        if word1[i] != word2[j]
            return false
        end
        i = nextind(word1, i)
        j = prevind(word2, j)
    end
    true
end

isreverse("banana", "ananab")

#---
# "Exercise 8-9"

function ispalindrome(str)
	return reverse(str) == str
end

ispalindrome("")

#---
# Exercise 8-10

function anylowercase1(s)
    for c in s
        if islowercase(c)
            return true
        else
            return false
        end
    end
end

anylowercase1("APa")


function anylowercase2(s)
    for c in s
        if islowercase('c')
            return "true"
        else
            return "false"
        end
    end
end

anylowercase2("APa")


function anylowercase3(s, flag=false)
    for c in s
        flag = islowercase(c)
    end
    return flag
end

anylowercase3("APa")


function anylowercase4(s)
    flag = false
    for c in s
        flag = flag || islowercase(c)
    end
    return flag
end

anylowercase4("APA")


function anylowercase5(s)
    for c in s
        if !islowercase(c)
            return false
        end
    end
    return true
end

anylowercase5("APa")

#---
# "Exercise 8-11"

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

#========================================================================#
