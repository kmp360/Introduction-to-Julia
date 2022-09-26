
include("Srch.jl")

using Main.Srch
using BenchmarkTools

@time intrloc = interlock_dict();
@time intrloc = interlock_bisect();
@time intrloc = interlock_linsrch();

#==
@btime intrloc = interlock_dict();
@btime intrloc = interlock_bisect();
@btime intrloc = interlock_linsrch();
==#


