using DataFrames, CSV, Random, StatsBase, Plots
# ;cd F:\\Git\ Ubuntu\\BelajarJulia\\StatBase\\ 
# need to change REPL jula location
C= CSV.read("monthly-mean-temp.csv",DataFrame)
temp=C[1:200,:Temperature]

D= CSV.read("monthly-sunspots.csv",DataFrame)
sun=D[1:200,:Sunspots]

#default plot
plot(temp,label="Rataaan Temperature")
plot!(sun,color=:green,label="Sunspots")

#acf
atemp=autocor(temp)
plot(atemp)
asun=autocor(sun)
plot(asun)

#ccf
ccf=crosscor(temp,sun)
plot(ccf,color=:red,label="crosscor")


