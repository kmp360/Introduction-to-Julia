"Code examples for Chapter 9 -- Word Processing"

filename = "E:\\aaa-Julia-course-2022\\lectures\\words.txt"

#---
begin
    
    fin = open(filename)
    readline(fin)
    close(fin)
end

begin
    fin = open(filename)

    for line in eachline(fin)
        println(line)
    end

    close(fin)
end

#---
"Exercise 9-1"

function longWords(fin, len=20)
	for line in eachline(fin)
		if sizeof(line) > len
		    println(line)
		end
	end
end


# filename = "E:\\Julia\\a-Pluto-NoteBooks\\ThinkJulia-notebooks\\words.txt"
fileIn = open(filename)

longWords(fileIn, 15)

close(fileIn)

#---
"Exercise 9-2"

function hasno_e(word)
    for letter in word
        if letter == 'e'
            return false
        end
    end
    return true
end

#---
"Exercise 9-3"

function avoids(word, forbidden)
    for letter in word
        if letter ∈ forbidden
            return false
        end
    end
    return true
end

#---
"Exercise 9-4"

function usesonly(word, available)
    for letter in word
        if letter ∉ available
            return false
        end
    end
    true
end

#---
"Exercise 9-5"

function usesall(word, required)
    for letter in required
        if letter ∉ word
            return false
        end
    end
    true
end

#---
"Exercise 9-6"

function isabecedarian(word)
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

function isabecedarian(word)
    if length(word) <= 1
        return true
    end
    i = firstindex(word)
    j = nextind(word, i)
    if word[i] > word[j]
        return false
    end
    isabecedarian(word[j:end])
end

function isabecedarian(word)
    i = firstindex(word)
    j = nextind(word, 1)
    while j <= sizeof(word)
        if word[j] < word[i]
            return false
        end
        i = j
        j = nextind(word, i)
    end
    true
end

function ispalindrome(word)
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

function ispalindrome(word)
    isreverse(word, word)
end

#=============================================================================#
