using Random, Distributions, StableRNGs, CorrNoise
using Plots
rng=MersenneTwister()

a= bitrand(rng,100)
# a=sin.(0:0.3:2*pi)
plot(a,line=:stem)
plot(a,line=:steppre)
# plot(a,color=:red)
# plot(a,line=:steppre,color=:green)

uni= Uniform(1,10)
b=rand(uni,100)
plot(b,line=:stem)
plot(b,line=:steppre)

rand(Int,1)

sta=StableRNG(2855090191069476144)
c=randn(sta,100)
plot(c,line=:stem)
plot(c,line=:steppre)
plot(c)

d = OofRNG(GaussRNG(MersenneTwister()), -1.7, 1.15e-5, 0.05, 1.0);
data = [randoof(d) for i in 1:100]
plot(data, line=:stem)
plot(data, line=:step)