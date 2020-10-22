### A Pluto.jl notebook ###
# v0.12.4

using Markdown
using InteractiveUtils

# ╔═╡ 447d88b0-147c-11eb-0bd4-df25aca24f92
# Pkg.add("ControlSystems")
using ControlSystems

# ╔═╡ d67d7050-147b-11eb-051b-93ec8f772b94
# import Pkg

# ╔═╡ d52f9e20-147c-11eb-1fde-bff40cc5f980
sys = tf(1, [1,1])*delay(1)

# ╔═╡ 74f2b4f0-147e-11eb-184c-517803412b05
stepplot(sys)

# ╔═╡ 1aefbaa0-1480-11eb-004e-7d1302fdc9df
bodeplot(sys)

# ╔═╡ 4224f5e0-1480-11eb-1c86-eff55f9efc6a
nyquistplot(sys)

# ╔═╡ Cell order:
# ╠═d67d7050-147b-11eb-051b-93ec8f772b94
# ╠═447d88b0-147c-11eb-0bd4-df25aca24f92
# ╠═d52f9e20-147c-11eb-1fde-bff40cc5f980
# ╠═74f2b4f0-147e-11eb-184c-517803412b05
# ╠═1aefbaa0-1480-11eb-004e-7d1302fdc9df
# ╠═4224f5e0-1480-11eb-1c86-eff55f9efc6a
