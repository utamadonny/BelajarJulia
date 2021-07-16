using Plots: label_to_string
using CSV, Plots, DataFrames
# cd("ahrs/")
# dt= DataFrame(CSV.File("2021-07-02 08-47-47.csv"))
dt = DataFrame(CSV.File("2021-07-08 22-03-03.csv"))
# dt = CSV.read("2021-07-02 08-47-47.csv",DataFrame)  #deprecated soon
## 
select!(dt, Not([:"Orientation:",:"Column8",:"Column12",:"Column16",:"Column20"]))
rename!(dt, ["col$i" for i in 1:19])
rename!(dt, [:col1,:col2,:col3] .=> [:roll,:pitch,:yaw])
delete!(dt, 1:26) 
# more : https://discourse.julialang.org/t/change-column-names-of-a-dataframe-previous-methods-dont-work/48026/8
## ========= PLOT DATA ============
# unicodeplots()
# gr()
plotly()
# pyplot()
# plotlyjs()
plot(dt[:,:Time],dt[:,:roll],
	label="roll")
plot!(dt[:,:Time],dt[:,:pitch], label="pitch")
plot!(dt[:,:Time],dt[:,:mroll], label= "mroll")
plot!(dt[:,:Time],dt[:,:mpitch], label = "mpitch")
plot!(dt[:,:Time],dt[:,:yaw],label ="yaw")
plot!(dt[:,:Time],dt[:,:myaw],label ="myaw")
## == Save Plots
savefig("2021-07-08 22-03-03.html")
## ===============debug===============
typeof(dt[!,:Time])
dt[end,:mpitch]
names(dt)
dt
select(dt, :pitch)
df[!,:A]=dt[1:3,:roll]  
df = DataFrame(A = 1:3, B = 100:102)
dt = DataFrame(C=1:3, D = df[:,:A].- 180)
ds=hcat(df,dt)
# ds= crossjoin(df,dt, makeunique=true)
ds[!,:A]=ds[!,:D] # the way to copy paste value!
rename!(ds, :A => :Z)
ds[:,:Z]
ds[!,:Z][ds[!,:Z]].=>[ds[!,:D]]
dt
ds.Z
ds
push!(ds.Z, ds.D)
select!(ds, :A => :Z, :)
typeof(df[:,:A])
c=[1, 2, 3]
c.+1  # use broadcast to manipulate vector
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
