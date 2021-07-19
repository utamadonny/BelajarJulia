using CSV, Plots, DataFrames, PlotlyBase, Dates, StatsBase
# cd("ahrs/")
# dt= DataFrame(CSV.File("2021-07-02 08-47-47.csiv"))
# dt = DataFrame(CSV.File("2021-07-08 22-03-03.csv"))
dt = DataFrame(CSV.File("2021-07-16 21-43-46.csv"))
df = DataFrame(CSV.File("2021-07-16 21-43-46M.csv"))
dx = DataFrame(CSV.File("2021-07-16 21-43-46M1.csv"))
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
p=plot(dt[:,:Time],dt[:,:roll],
	label="ϕ")
plot!(dt[:,:Time],dt[:,:pitch], label="θ")
plot!(dt[:,:Time],dt[:,:aroll], label= "arduinoϕ")
plot!(dt[:,:Time],dt[:,:apitch], label ="arduinoθ")
plot!(dt.Time,dt.yaw,label ="ψ")
plot!(dt.Time,dt.ayaw,label ="arduinoψ")
plot!(dt.Time,dx.mroll,label ="matlabϕ")
plot!(dt.Time,dx.mpitch,label ="matlabθ")
plot!(dt.Time,dx.myaw,label ="matlabψ")
## =================Plot Data from Matlab sample 512 beta 1.2 ===============
plot!(dt.Time,df.mroll,label ="matlabϕ")
plot!(dt.Time,df.mpitch,label ="matlabθ")
plot!(dt.Time,df.myaw,label ="matlabψ")
##===================plot(dt.Time,df.)debug plot================
xticks!(Time(0):Second(20):Time(0,33))
plot(dt.Time[11000:20000],dt.yaw[11000:20000],label ="yaw")
plot!(dt.Time[11000:20000],dt.myaw[11000:20000],label ="myaw",xticks=Time(0):Second(20):Time(0,33))
# dt.Time=Time.(dt.Time, DateFormat("H:M:S"))
## == Save Plots=============
Plots.savefig("2021-07-16 21-43-46(1).html")
Plots.savefig("2021-07-16 21-43-46(1).png")
# PlotlyBase.savefig(p,"s")
## ===============debug2================
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

## Compute RMSE/RMSD
rmsd(dt.roll, dt.mroll)
rmsd(dt.pitch, dt.mpitch)
rmsd(dt.yaw, dt.myaw) # all data will result more RMSD because 360/0 degree change
rmsd(dt.yaw[1:2000], dt.myaw[1:2000]) # all data will result more RMSD because 360/0 degree change
