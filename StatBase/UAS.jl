### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 97dcfe50-d745-11eb-0c18-59b08b86e8d2
using CSV,DataFrames,Plots,StatsBase

# ╔═╡ 2fb53815-44dc-407a-9cf6-f169649ad521
pwd()

# ╔═╡ 1ac78873-1442-4861-aecd-1caa22d9d8c3
md"""
## Tugas UAS Pemodelan
###### Donny Prakarsa Utama (3332170032)
###### Ringga Dwi Raju (3332170029)

sumber data = 
+ Time Series Data Library (citing: O.D. Anderson (1976))
+ Time Series Data Library (citing: Andrews & Herzberg (1985))
"""

# ╔═╡ c52c85fd-95c8-4e23-9e43-54109f66bd71
#Data
#Rata2 Temperature dan Titik Matahari

# ╔═╡ 074c0b44-55c6-46e0-9653-6e94f779079a
C= CSV.read("monthly-mean-temp.csv",DataFrame)

# ╔═╡ ebf1b8b9-3643-45da-b5a0-75d480fc2cb1
temp=C[1:200,:Temperature]

# ╔═╡ d2cb493a-2814-46b1-be3c-7edf7a2e8bd1
D= CSV.read("monthly-sunspots.csv",DataFrame)

# ╔═╡ 8585bb6b-b077-49b5-a4a2-7df9d6d67f26
sun=D[1:200,:Sunspots]

# ╔═╡ c56af65d-6710-465b-bf23-f8b951561d94
#Plot Awal

# ╔═╡ 4b247d08-a6f4-4950-85e3-91c3d90d589f
plot(temp,label="Rataaan Temperature")

# ╔═╡ 6759c317-5cb8-4b89-a8fa-7971ef2d7fe4
plot!(sun,color=:green,label="Sunspots")

# ╔═╡ 8fa6401e-2722-487e-b1d2-fc90ac799f9e
#Autocorrelation (ACF)
#autocorr sunspots dan temperatur

# ╔═╡ aaf476f7-f999-427a-80bb-55ad7e479a78
begin
	atemp=autocor(temp)
	asun=autocor(sun)
end

# ╔═╡ da1b1172-2dd2-483e-a3d8-513948c1fea2
plot(atemp,label="autocor rataan temperatur")

# ╔═╡ 0b9830e3-63c7-4d1a-aa92-a70f739d8a84
plot(asun,label="autocor sunspots",color=:green)

# ╔═╡ ab6ebe9f-0b68-42fd-863c-f1b155fbd9b3
#Crosscorrelation (CCF)

# ╔═╡ bb948791-d646-4d62-8857-201df3eca68c
ccf=crosscor(temp,sun)

# ╔═╡ 73206e37-3f11-4024-9589-4af9892cf3ab
plot(ccf,color=:red,label="crosscorr antara temperatur dan sunspots")

# ╔═╡ 27734775-a2e1-451e-a7c2-b35633c3588a
#see my github : https://github.com/utamadonny/BelajarJulia/tree/master/StatBase

# ╔═╡ Cell order:
# ╠═97dcfe50-d745-11eb-0c18-59b08b86e8d2
# ╠═2fb53815-44dc-407a-9cf6-f169649ad521
# ╠═1ac78873-1442-4861-aecd-1caa22d9d8c3
# ╠═c52c85fd-95c8-4e23-9e43-54109f66bd71
# ╠═074c0b44-55c6-46e0-9653-6e94f779079a
# ╠═ebf1b8b9-3643-45da-b5a0-75d480fc2cb1
# ╠═d2cb493a-2814-46b1-be3c-7edf7a2e8bd1
# ╠═8585bb6b-b077-49b5-a4a2-7df9d6d67f26
# ╠═c56af65d-6710-465b-bf23-f8b951561d94
# ╠═4b247d08-a6f4-4950-85e3-91c3d90d589f
# ╠═6759c317-5cb8-4b89-a8fa-7971ef2d7fe4
# ╠═8fa6401e-2722-487e-b1d2-fc90ac799f9e
# ╠═aaf476f7-f999-427a-80bb-55ad7e479a78
# ╠═da1b1172-2dd2-483e-a3d8-513948c1fea2
# ╠═0b9830e3-63c7-4d1a-aa92-a70f739d8a84
# ╠═ab6ebe9f-0b68-42fd-863c-f1b155fbd9b3
# ╠═bb948791-d646-4d62-8857-201df3eca68c
# ╠═73206e37-3f11-4024-9589-4af9892cf3ab
# ╠═27734775-a2e1-451e-a7c2-b35633c3588a
