words = ["bail", "ace", "act", "bait"]

wordD = Dict{Char, Array{String, 1}}()

chrs = first.(words)

for (ind, chr) in enumerate(chrs)

    wordD[chr] = push!(get(wordD, chr, []), words[ind])

end

wordD

#---

uchrs = sort(unique(first.(words)))

Dict(chr => filter(startswith(chr), words) for chr in uchrs)