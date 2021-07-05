using DataFrames, CSV, Plots

dt= DataFrame(CSV.File("2021-07-02 08-47-47.csv"))
# dt = CSV.read("2021-07-02 08-47-47.csv",DataFrame)  #deprecated soon
select!(dt, Not([:"Orientation:",:"Column8",:"Column12",:"Column16",:"Column20"]))
rename!(dt, ["col$i" for i in 1:19])
rename!(dt, [:col1,:col2,:col3] .=> [:roll,:pitch,:yaw])
# more : https://discourse.julialang.org/t/change-column-names-of-a-dataframe-previous-methods-dont-work/48026/8
## end of data manipulation

plot(dt[:,:roll])
plot!(dt[:,:col13])
dt
## ===============debug===============
dt[:,:"Orientation:"]
dt[:,:col1]
names(dt)
# sum(names(dt))
size(dt)
# for i in 1:19
# 	newname=[:col$i]
# end
# newname=["col$i" for i in 1:19]
# rename!(dt, newname)
# loop : https://stackoverflow.com/questions/38246979/julia-create-an-arrays-in-for-loop
# collect(1:10)
# newname
# skipmissing(dt)
# rename!(dt, :column1)
# delete!(dt, 1:22) # delete row 
select(dt, 1:7)
dt[1,:]
typeof(dt)