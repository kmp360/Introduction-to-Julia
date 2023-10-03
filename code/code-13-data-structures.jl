
# "Code examples for Chapter 13 -- Data Structures"
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.9.3\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2023\\lectures-1.9")
#---

alpha1 = ['a':'z'; 'A':'Z']

alpha2 = ['a':'z' 'A':'Z']

begin

    alphabet = ['a':'z'; 'A':'Z']

    chr_index = Dict(zip(alphabet, Int.(alphabet)))

    letterindex = Dict(zip(string.(alphabet), Int.(alphabet)))

end

#---


isletter('B')       # built in
isletter("B")

function is_letter(chr::String)  # our version
    alphabet = string.( ['a':'z'; 'A':'Z'; '-'; ' '] )
    return chr in alphabet
end

#---

using Downloads

em2 = let
    url = "https://ia800303.us.archive.org/24/items/EmmaJaneAusten_753/emma_pdf_djvu.txt"
    raw_text = read(download(url), String)
    lowercase.(raw_text)
end


em2

#==
a = collect(eachmatch(r"[a-zA-Z\s]", em2))
b =  replace(em2, r"[^a-zA-Z\s]" => "")
b = replace(b, r"\s+" => " ")
==#

#---

# "Exercise 13-1"

begin

    function preprocess(text::String)
        # see info on regular expressions
        # https://docs.julialang.org/en/v1/manual/strings/#Regular-Expressions
        # http://www.pcre.org/current/doc/html/pcre2syntax.html

        # clean up whitespace
        text = replace(text, r"\s+" => " ")

        # clean up broken words: "com-", "fortable"
        text = replace(text, r"-\s+" => "")

        # clean up other characters found by random inspection
        text = replace(text, r"(\.|,|;|:|\?|!|'|\-|—|\^|)" => "")
        text = replace(text, r"(\[|\]|\)|\(|\{|\}|•|\*|\<|\>)" => "")
        text = replace(text, r"(°|■|©|»|«|♦|•|\"|£|\$|&|\/)" => "")
        text = replace(text, r"(\+|\#|§)" => "")
        text = replace(text, r"([0-9])" => "")

        #generate a CSV text
        cleantext = replace(text, r"(\s|\b)" => ",")

        return cleantext # sort of ...
    end

    function splt(txt::String)
        # split on whitespace or other word boundaries
        # and type-cast the Array of Substrings from split into an Array of Strings
        #tokens = String.(split(cleantext, r"(\s|\b)"))

        return tokens = String.(split(txt, ","))
    end

    words_em2 = splt(preprocess(em2))


    function word_counts(words::Array{String,1})

        counts = Dict{String,Int}()

        for word in words
            if word == "" || word == "\\"
                # do nothing
            else
                counts[word] = get!(counts, word, 0) + 1
            end
        end

        return counts
    end

    function sort_on_vs(d::Dict, rev = true)
        ks = collect(keys(d))
        vs = collect(values(d))

        if rev
            sindex = sortperm(vs, rev = true)
        else
            sindex = sortperm(vs, rev = false)
        end

        sorted_ks = ks[sindex]# keys, values returned in the same order
        sorted_vs = vs[sindex]

        return collect(zip(sorted_ks, sorted_vs))
    end



    N = 10
    list = sort_on_vs(word_counts(words_em2))[1:N]

    println("List of the $N most common words in ", "EM2")
    println("---------------------------------------")
    for k = 1:length(list)
        println("$k.", "\t ", list[k][1], "   \t\t", list[k][2])
    end
end

#---

# "Exercise 13-2"

begin
    url = "https://ia800303.us.archive.org/24/items/EmmaJaneAusten_753/emma_pdf_djvu.txt"
    raw_text = read(download(url), String)
    first_words = "Emma Woodhouse"
    last_words = "THE END"
    start_index = findfirst(first_words, raw_text)[1]
    stop_index = findlast(last_words, raw_text)[end]

    emma = lowercase.(raw_text[start_index:stop_index])

    function splitwords(text::String)
        # see info on regular expressions
        # https://docs.julialang.org/en/v1/manual/strings/#Regular-Expressions
        # http://www.pcre.org/current/doc/html/pcre2syntax.html

        # clean up whitespace
        text = replace(text, r"\s+" => " ")

        # clean up broken words: "com-", "fortable"
        text = replace(text, r"-\s+" => "")
        text = replace(text, r"(\.|,|;|:|\?|!|'|\-|—|\^|§)" => "")
        text = replace(text, r"(\[|\]|\)|\(|\{|\}|•|\*|\<|\>)" => "")
        text = replace(text, r"(°|■|©|»|«|♦|•|\"|£|\$|&|\/)" => "")
        text = replace(text, r"x*" => "")
        text = replace(text, r"([0-9])" => "")
        #text = replace(text, r"(0|1|2|3|4|5|6|7|8|9)" => "")

        #text = replace(text, r"(\s|\b)" => ",")
        cleantext = replace(text, r"(\s|\b)" => ",")
        #cleantext = replace(text, r"\\" => "")

        # split on whitespace or other word boundaries
        # and type-cast the Array of Substrings from split into an Array of Strings
        #tokens = String.(split(cleantext, r"(\s|\b)"))
        tokens = String.(Base.split(cleantext, ","))
    end

    emma_words = splitwords(emma)


    function word_counts(words::Array{String,1})

        counts = Dict{String,Int}()

        for word in words
            if word == "" || word == "\\"
                # do nothing
            else
                counts[word] = get!(counts, word, 0) + 1
            end
        end
        return counts
    end

    emma_dictionary = word_counts(emma_words)


    function reverse_dictionary(d::Dict)
        D = Dict{Int,Array{String,1}}()

        for key in keys(d)
            D[d[key]] = push!(get!(D, d[key], []), key)
        end

        return D
    end

    # an alternative
    function reverse_dictionary2(d::Dict)
        D = Dict{Int,Array{String,1}}()
        ks = collect(keys(d))
        vs = collect(values(d))

        for k = 1:length(ks)
            if haskey(D, vs[k])
                push!(D[vs[k]], ks[k])
            else
                D[vs[k]] = [ks[k]]# ks[k] is a String not an Array{String,1}
            end # [ks[k]] is an Array{String,1} with one element
        end
        return D
    end

    reverse_emma_dictionary = reverse_dictionary(emma_dictionary)


    function sort_on_ks(d::Dict, rev = true)
        ks = collect(keys(d))
        vs = collect(values(d))

        if rev
            srt_index = sortperm(ks, rev = true) # keys, values returned in the same order
        else
            srt_index = sortperm(ks, rev = false)
        end

        sorted_ks = ks[srt_index]
        sorted_vs = vs[srt_index]
        return collect(zip(sorted_ks, sorted_vs))
    end

    sort_on_ks(reverse_emma_dictionary)

end

#---

# "Exercise 13-3"

begin

    function sort_dict_on_vs(d::Dict, rev = true)
        ks = collect(keys(d))
        vs = collect(values(d))

        if rev
            srt_index = sortperm(vs, rev = true) # keys, values returned in the same order
        else
            srt_index = sortperm(vs, rev = false)
        end

        sorted_ks = ks[srt_index]
        sorted_vs = vs[srt_index]

        return collect(zip(sorted_ks, sorted_vs))
    end


    N = 10
    list = sort_dict_on_vs(emma_dictionary)[1:N]

    println("List of the $N most common words in ", "Emma")
    println("----------------------------------------")
    for k = 1:length(list)
        println("$k.", "\t ", list[k][1], "   \t\t", list[k][2])
    end

end

#---

# "Exercise 13-4"

begin
    wordlist = Array{String,1}()
    # note the escape character \ in \\
    fullpath = "E:\\Julia\\a-Pluto-NoteBooks\\ThinkJulia-notebooks\\words.txt"
    infile = open(fullpath)

    for line in eachline(infile)
        push!(wordlist, line)
    end
    close(infile)


    function dictionary_difference(book::Dict, list::Array{String,1})
        (ismissing(book) || ismissing(wordlist)) && return missing

        words_not_in_list = Array{String,1}()
        ks = keys(book)

        for k in ks
            if k in list
                # do nothing
            else
                push!(words_not_in_list, k)
            end
        end
        return words_not_in_list
    end


    nonwords = dictionary_difference(emma_dictionary, wordlist)
    sort!(nonwords)

    for nonword in nonwords
        if length(nonword) < 2
            println()
        end
        println(nonword)
    end
end

#---

begin

    println()
    println("Pseudorandom numbers generated by rand()")
    println("----------------------------------------")
    for i = 1:10
        x = rand()
        println(i, ".\t\t", x)
    end
end

begin
    fruits = ['🍌', '🍎', '🍐', '🍓', '🍒', '🍋']

    println()
    println("Pseudorandom numbers generated by rand()")
    println("----------------------------------------")
    for i = 1:10
        x = rand(1:6)
        y = rand('a':'f')
        z = rand(fruits)
        println(i, ".\t", x, "\t", y, "\t", z)
    end
end

#---

# "Exercise 13-5"

function choosefromhist(hist::Dict)
    ks = collect(keys(hist))
    vs = collect(values(hist))

    sindex = sortperm(vs)
    kss = ks[sindex]
    vss = vs[sindex]

    csum = cumsum(vss ./ sum(vss))

    ind = findfirst(n -> n > rand(), csum)
    return ks[ind]
end


# Sanity checks
hist = Dict('a' => 1, 'b' => 1, 'c' => 100, 'd' => 10, 'e' => 5)
vs = collect(values(hist))
ks = collect(keys(hist))

sindex = sortperm(vs)
kss = ks[sindex]
vss = vs[sindex]
csum = cumsum(vss ./ sum(vss))

hist = Dict('a' => 1, 'b' => 1, 'c' => 100, 'd' => 10, 'e' => 5)

N = 1_000_000
w = [choosefromhist(hist) for _ = 1:N]

as = sum([Int(k == 'a') for k in w]) / N
bs = sum([Int(k == 'b') for k in w]) / N
cs = sum([Int(k == 'c') for k in w]) / N
ds = sum([Int(k == 'd') for k in w]) / N
es = sum([Int(k == 'e') for k in w]) / N

cumsum([as, cs, ds, es, bs])

[as, cs, ds, es, bs]

vss ./ sum(vss)
kss

r = rand()
ind = findfirst(n -> n > r, csum)
kss[ind]

#---

begin

    function processfile(filename)
        hist = Dict()

        for line in eachline(filename)
            processline(line, hist)
        end
        return hist
    end


    function processline(line, hist)
        line = replace(line, '-' => ' ')

        for word in Base.split(line)
            word = string(filter(isletter, [word...])...)
            word = lowercase(word)
            hist[word] = get!(hist, word, 0) + 1
        end
    end


    url = "https://github.com/BenLauwens/ThinkJulia.jl/blob/master/data/emma.txt"
    filename = open(download(url))
    em3 = processfile(filename)
    close(filename)

    em3

    function totalwords(hist)
        return sum(values(hist))
    end

    function differentwords(hist)
        return length(hist)
    end

    function mostcommon(hist)
        t = []
        for (key, value) in hist
            push!(t, (value, key))
        end
        return reverse(sort(t))
    end

    mostcommon(em3)


    function clipped_t(hist)
        k = 0

        for j = 1:length(hist)
            if hist[j][1] > 6000
                k += 1
            end
        end
        return hist[k+1:end]
    end

    clipped_t(mostcommon(em3))


    t = mostcommon(em3)
    t = clipped_t(t)
    println("The most common words are:")
    println("----------------------------")
    k = 0
    for (freq, word) in t[1:11]
        if word == ""
            # do nothing
        else
            k += 1
            println("$k.\t\t", word, "   \t\t", freq)
        end
    end
end


begin
    N = 10
    list = sort_dict_on_vs(word_counts(words_em2))[1:N]

    println("List of the $N most common words in ", "EM2")
    println("---------------------------------------")

    for k = 1:length(list)
        println("$k.", "\t ", list[k][1], "   \t\t", list[k][2])
    end
end

function printmostcommon(hist, num = 10)
    t = mostcommon(hist)
    println("The most common words are: ")
    for (freq, word) in t[1:num]
        println(word, "\t", freq)
    end
end

#---

# "Exercise 13-6"

begin
    worddict = Dict{String,Any}()
    # note the escape character \ in \\
    fullpath = "E:\\Julia\\a-Pluto-NoteBooks\\ThinkJulia-notebooks\\words.txt"
    infile = open(fullpath)

    for line in eachline(infile)
        worddict[line] = []
    end
    close(infile)

    function subtract(d1::Dict, d2::Dict)
        result = Dict()
        for key in keys(d1)
            if key ∉ keys(d2)
                result[key] = nothing
            end
        end
        return collect(keys(result))
    end
end

subtract(emma_dictionary, worddict)


begin
    function subtract(book::Array{String,1}, list::Array{String,1})
        return collect(setdiff!(Set(book), list))
    end

    subtract(emma_words, wordlist)
end

#---

# "Exercise 13-7"

begin

	function clr(wordlist:: Array{String, 1})
		cwordlist = Array{String, 1}()

		for k = 1:length(wordlist)

			if !( wordlist[k] == "" || wordlist[k] == "\\")

				push!(cwordlist, wordlist[k])
			end
		end
		return cwordlist
	end


	function wordcounts(book::Array{String, 1})
		counts = Dict{String,Int}()
		for word in book
			if word == "" || word == "\\"
				# do nothing
			else
				counts[word] = get!(counts, word, 0) + 1
			end
		end
		return counts
	end


	function csum_dict(hist::Dict{String, Int})
		cshist = Dict()
		cs = 0
		for key in keys(hist)        # ks and vs are listed in corresponding order
			cs += hist[key]
			cshist[cs] = key
		end
		return cshist
	end


	function rnd_wrd(c_hst::Dict)

		M = maximum(keys(c_hst))
		rnd = rand(1:M)

		sc_hst = sort_on_ks(c_hst, false) 		# see code just prior to Exercise 13-3

		ind = findfirst(k -> r < k[1], sc_hst)

		return sc_hst[ind][2]
	end
end

#---

function letter_frequencies(txt)
    ismissing(txt) && return missing    # guard

    freq = count.(string.(alphabet), txt)
	return freq ./ sum(freq)
end


#---

# another intermezzo with extras

using Markdown

string(rand(alphabet, 40)) |> Text

function Quote(text::AbstractString)
    text |> Markdown.Paragraph |> Markdown.BlockQuote |> Markdown.MD
end

string(rand(alphabet, 400)) |> Quote

#---

alphabet = ['a':'z'; ' ']

#---

function isinalphabet(character)
    return character in alphabet
end

messy_sentence = "#wow 2020 ¥500 (blingbling!)"
cleaned_sentence = filter(chr -> isinalphabet(chr), messy_sentence)

#---

using Unicode

"""
Turn "áéíóúüñ asdf" into "aeiouun asdf"
"""
unaccent(str) = Unicode.normalize(str, stripmark = true)

str = "áéíóúüñ asdf"
unaccent(str)

french_word = "Égalité!"
unaccent(french_word)

#---

function clean(text)
    txt = lowercase(unaccent(text))
    return filter(chr -> isinalphabet(chr), txt)
end

clean("Crème brûlée est mon plat préféré.")

#---

string.(alphabet)

function letter_frequencies(txt)
    ismissing(txt) && return missing
    freq = count.(string.(alphabet), txt)
    return freq ./ sum(freq)
end

#---

sample = """
Although the word forest is commonly used, there is no universally recognised precise definition, with more than 800 definitions of forest used around the world.[4] Although a forest is usually defined by the presence of trees, under many definitions an area completely lacking trees may still be considered a forest if it grew trees in the past, will grow trees in the future,[9] or was legally designated as a forest regardless of vegetation type.[10][11]

The word forest derives from the Old French forest (also forès), denoting "forest, vast expanse covered by trees"; forest was first introduced into English as the word denoting wild land set aside for hunting[14] without the necessity in definition of having trees on the land.[15] Possibly a borrowing, probably via Frankish or Old High German, of the Medieval Latin foresta, denoting "open wood", Carolingian scribes first used foresta in the Capitularies of Charlemagne specifically to denote the royal hunting grounds of the King. The word was not endemic to Romance languages, e. g. native words for forest in the Romance languages derived from the Latin silva, which denoted "forest" and "wood(land)" (confer the English sylva and sylvan); confer the Italian, Spanish, and Portuguese selva; the Romanian silvă; and the Old French selve, and cognates in Romance languages, e. g. the Italian foresta, Spanish and Portuguese floresta, etc., are all ultimately derivations of the French word.
"""

cleaned_sample = clean(sample)

sample_freqs = letter_frequencies(cleaned_sample)

(most_common, ind) = findmax(sample_freqs)

alphabet[ind]

#---

z = zip(alphabet, sample_freqs)
dump(z)

letter_index(letter) = findfirst(isequal(letter), alphabet)

unused_letters = let
    zip(alphabet, sample_freqs)
    filter(chr -> sample_freqs[letter_index(chr)] == 0, alphabet)
end

#---

function transition_counts(cleaned_sample)
    [count(string(a, b), cleaned_sample) for a in alphabet, b in alphabet]
end

normalize_array(x) = x ./ sum(x)

transition_frequencies = normalize_array ∘ transition_counts

transition_frequencies(cleaned_sample)

#---

using Compose

function compimg(
    img,
    labels = [
        c * d for c in replace(alphabet, ' ' => "_"),
        d in replace(alphabet, ' ' => "_")
    ],
)
    xmax, ymax = size(img)
    xmin, ymin = 0, 0
    arr = [(j - 1, i - 1) for i = 1:ymax, j = 1:xmax]

    compose(
        context(units = UnitBox(xmin, ymin, xmax, ymax)),
        fill(vec(img)),
        compose(
            context(),
            fill("white"),
            font("monospace"),
            text(first.(arr) .+ 0.1, last.(arr) .+ 0.6, labels),
        ),
        rectangle(
            first.(arr),
            last.(arr),
            fill(1.0, length(arr)),
            fill(1.0, length(arr)),
        ),
    )
end

#---

using Colors

function show_pair_frequencies(A)
    imshow = let
        to_rgb(x) = RGB(0.36x, 0.82x, 0.8x)
        to_rgb.(A ./ maximum(abs.(A)))
    end
    compimg(imshow)
end

sample_freq_matrix = transition_frequencies(cleaned_sample)

show_pair_frequencies(transition_frequencies(cleaned_sample))

th_frequency = sample_freq_matrix[letter_index('t'), letter_index('h')]

ht_frequency = sample_freq_matrix[letter_index('h'), letter_index('t')]

#---
double_letters = filter(
    chr -> sample_freq_matrix[letter_index(chr), letter_index(chr)] > 0,
    alphabet,
)

most_likely_to_follow_w = alphabet[findmax([
    sample_freq_matrix[letter_index('w'), letter_index(chr)] for
    chr in alphabet
])[2]]

most_likely_to_precede_w = alphabet[findmax([
    sample_freq_matrix[letter_index(chr), letter_index('w')] for
    chr in alphabet
])[2]]
