# "Code examples for Chapter 9 -- Word Processing"
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.8.0\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2022\\lectures-1.8")

filename = "E:\\aaa-Julia-course-2022\\lectures-1.8\\words.txt"

#---
    
fin = open(filename)
readline(fin)
close(fin)

#---

begin
    fin = open(filename)

    for line in eachline(fin)
        println(line)
    end

    close(fin)
end

#---

# "Exercise 9-1"

function longWords(fin, len=20)
	for str in eachline(fin)

        str_no_wspace = filter(chr -> !isspace(chr), str)

		if sizeof(str_no_wspace) > len
		    println(str)
		end
	end
end


filename = "E:\\aaa-Julia-course-2022\\lectures-1.8\\words.txt"
fileIn = open(filename)
longWords(fileIn, 13)
close(fileIn)

#---

# "Exercise 9-2"

function hasno_e(word)
    
    return !('e' in word)

end

#hasno_e("abecd")

function no_e(fin)
    cnt = 0
    cnttot = 0

	for str in eachline(fin)
        cnttot += 1
		if hasno_e(str)
            cnt += 1
		    println(str)
		end
	end
    return cnt/cnttot
end

filename = "E:\\aaa-Julia-course-2022\\lectures-1.8\\words.txt"

begin
    fileIn = open(filename)
    percentage = no_e(fileIn)
    close(fileIn)
end

percentage

#---

# "Exercise 9-3"

function avoids(word, forbidden)
    for letter in word
        return !(letter ∈ forbidden)
    end
end

#---

# "Exercise 9-4"

function usesonly(word, available)
    for letter in word
        if letter ∉ available
            return false
        end
    end

    return true
end

available = "acefhlo"
word = "alfdlfa"
usesonly(word, available)

#---

# "Exercise 9-5"

function usesall(word, required)
    for letter in required
        if letter ∉ word
            return false
        end
    end

    return true
end

#---

# "Exercise 9-6"

function isabecedarian_1(word)
    i = firstindex(word)
    previous = word[i]
    j = nextind(word, i)
    for c in word[j:end]
        if c < previous
            return false
        end
        previous = c
    end
    true
end

function isabecedarian_2(word)
    if length(word) <= 1
        return true
    end
    i = firstindex(word)
    j = nextind(word, i)
    if word[i] > word[j]
        return false
    end
    isabecedarian_2(word[j:end])
end

function isabecedarian_3(word)
    i = firstindex(word)
    j = nextind(word, 1)
    while j <= sizeof(word)
        if word[j] < word[i]
            return false
        end
        i = j
        j = nextind(word, i)
    end
   return  true
end

#---

function ispalindrome_2(word)   # this code does not cover all cases
    i = firstindex(word)
    j = lastindex(word)
    while i < j
        if word[i] != word[j]
            return false
        end
        i = nextind(word, i)
        j = prevind(word, j)
    end
    return true
end

function ispalindrome_1(word)
    lowercase(word) == lowercase(reverse(word))
end

word = "abctCBA"
ispalindrome_1(word)
ispalindrome_2(word)

#=============================================================================#
