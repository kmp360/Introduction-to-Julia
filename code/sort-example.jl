d = Dict('a' => 3, 'b' => 2, 'c' => 1) # define dictonary

k = collect(keys(d))    # collect keys and values in vectors
v = collect(values(d))

pind = sortperm(k)  # generate permutation for sorting on keys
[k[pind] v[pind]]   # apply permutation and stack in a matrix

pind2 = sortperm(v) # sort on values
[k[pind2] v[pind2]]