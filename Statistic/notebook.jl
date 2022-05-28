### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ daf2cb30-d33e-11eb-1b32-23c5c5548860
using StatsBase,Random,Plots,CSV,DataFrames

# ╔═╡ 70eb02cf-de41-4366-acc8-34c505865bdf


# ╔═╡ 2eb1c18a-7083-4323-b8f3-e0278cda5071
x=rand(Int,1000);

# ╔═╡ fba344d7-4bf4-4175-addb-6df6314f4b41
y=rand(Int,1000);

# ╔═╡ d3db8c09-b3d2-49f7-ab3e-5d45be7bad1c
f=crosscov(x,y)/10^34/10^17/4;

# ╔═╡ e870f45f-49d2-448e-abb7-1f2f536757a5
plot(x)

# ╔═╡ eb1ccc96-0423-4325-bbd8-178d89fe1ba4
plot(y)

# ╔═╡ acf78c19-f310-466b-b026-0e242a57254d
plot(f)

# ╔═╡ Cell order:
# ╠═daf2cb30-d33e-11eb-1b32-23c5c5548860
# ╠═70eb02cf-de41-4366-acc8-34c505865bdf
# ╠═2eb1c18a-7083-4323-b8f3-e0278cda5071
# ╠═fba344d7-4bf4-4175-addb-6df6314f4b41
# ╠═d3db8c09-b3d2-49f7-ab3e-5d45be7bad1c
# ╠═e870f45f-49d2-448e-abb7-1f2f536757a5
# ╠═eb1ccc96-0423-4325-bbd8-178d89fe1ba4
# ╠═acf78c19-f310-466b-b026-0e242a57254d
