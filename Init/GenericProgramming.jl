### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 446999ab-c96b-4a42-be23-d198db1328bf
md"""
# Generic programming
"""

# ╔═╡ 74277812-e12e-11eb-2ae4-ef18b2d40b66
md"""
Let's think about random walks again. Suppose we want to calculate the trajectory (path in time) of a random walker that starts at $0$, lives on the integers, and jumps left or right with probability $\frac{1}{2}$ at each time step.

We would probably write something like the following functions:

"""

# ╔═╡ cb99dae0-1b9c-4807-a2fc-32b5dd49f2d3
jump() = rand( (-1, +1) )

# ╔═╡ 51a963f1-4dc3-48ca-b67c-1761a85d2916
rand((-1,+1))

# ╔═╡ 80de5d24-27ab-4070-926a-c7f242de3f6a
function trajectory1D(T)
	x = 0
    traj = [x]  # array containing only `x`
    
    for t in 1:T
        x += jump()
        push!(traj, x)
    end
    
    return traj
end

# ╔═╡ 70159c23-0928-4914-8e3a-e322296b9f6e
md"""
Let's test that it works:
"""

# ╔═╡ aced5107-4ede-490f-b644-720acacf71ba
trajectory1D(20)

# ╔═╡ 04aeb029-7b93-4afc-8f1b-a8cdcc8a6252
md"""
What about if we want a walker in 2D? We could copy and paste the function as follows, and then modify it appropriately:
"""

# ╔═╡ 7905a14e-fcf1-4e20-9acf-816438d899ea
function trajectory2D(T)
    x = 0
    y = 0
    trajx = [x]
    trajy = [y]
    
    for t in 1:T
        x += jump()
        y += jump()

        push!(trajx, x)
        push!(trajy, y)
    end
    
    return trajx, trajy
end

# ╔═╡ e2948a76-f6fc-4d80-b3b0-cc43d9dacc44
trajectory2D(20)

# ╔═╡ 7657d417-7e90-4c7c-9057-cb4ac3684cb3
md"""
Now suppose we also want a walker in 3D. More copying and pasting.

Now suppose that we want to modify the functions so that they can take an optional argument representing the starting position. We would have to go and modify each of the three different versions of the function.

What if we wanted to modify them so that they can jump in different directions with different probabilities. Or have behaviour that depends on the history of how it previously moved, for example be more likely to continue in the same direction (a so-called **persistent** or **correlated** random walk).  

Each modification seems to require us to write a new version of the code with basically the same structure, but changing the details, and changing at least 3 versions of the same code, which easily leads to making mistakes that are hard to spot. And it seems like it's a waste of our (humans') time -- can't the computer do this repetitive work for us?
"""

# ╔═╡ 4c6067cb-69a7-44d1-b052-92a7bad5d7cf
function trajectory3D(T)
    x = 0
    y = 0
	z=0
    trajx = [x]
    trajy = [y]
    trajz = [z]
    for t in 1:T
        x += jump()
        y += jump()
		z += jump()
		
        push!(trajx, x)
        push!(trajy, y)
		push!(trajz, z)
   	end
    
    return trajx, trajy, trajz
end

# ╔═╡ 8e28f6ea-5be9-4fea-9207-6c8563d941e3
trajectory3D(50)

# ╔═╡ 58885adc-a2ff-432f-8918-3d4b1471dee2
md"""
## Abstraction
"""

# ╔═╡ 834a9ba2-a3b5-4ab4-b1d5-becf4bdb8445
md"""
Since all the versions of the code have, in some sense, the *same structure*, we would like to identify that structure and make an *abstraction*. 

Let's go back and look at how we stated the problem in English: we have a "walker" and we want to "calculate its trajectory". We want to make abstractions corresponding to these two ideas. 

A "walker" is a thing or object -- i.e. a *noun* -- which  we can model, or represent, by defining a `struct`, which makes a new *type*.
Different *kinds of* walkers will correspond to defining different `struct`s, and hence *different types*. However, each of those types should somehow "have the same behaviour".

On the other hand, "calculate its trajectory" is an *action*, or *verb*, which we can model using a *function*.

"""

# ╔═╡ 19f20b48-fb22-4bca-bd53-365acf981978
md"""
### Analysing the verb
"""

# ╔═╡ b6854a7c-ebc2-4d53-98b0-a6bd898886ee
md"""
Let's go back to the code for the 1D walker and try to isolate the properties that a walker needs and the actions that we are doing to it. We will do so by breaking out each action into a separate function:
"""

# ╔═╡ 9c0ef6de-ced5-4c85-a65a-82630451f8fe
md"""
We see that the walker needs an initial position, and a way to move:
"""

# ╔═╡ 95b3f8bc-26c5-4845-be71-389d1c4fb9b4
initial_position() = 0

# ╔═╡ 3a9c21ed-f197-4ecc-af41-947de7ae0de4
move(x) = x + jump()

# ╔═╡ 10105a99-2296-4764-8bc7-ffc1cb831238
md"""
Look carefully at the new version of the function `trajectory`. Its purpose now is basically to do the book-keeping of tracking the walker's position and storing it in the array `traj`. The details of how the walker is initialised and how it moves are delegated to the functions `initialise` and `move`.
"""

# ╔═╡ 7e203141-9790-437f-8d60-d479cd9d602c
md"""
Now suppose we wanted a 2D walker instead. What would we need to do? We would somehow need to *replace* `initialise` and `move` by the following 2D versions:
"""

# ╔═╡ 2010815b-b05b-4505-b4ae-d98d06cdc9b8
initialise_2D() = (0, 0)

# ╔═╡ 3d0fcbde-724b-4ed3-8700-e5dac970e2bb
move_2D( (x, y) ) = (x + jump(), y + jump() )

# ╔═╡ 4d9b5416-d6f4-435c-8bde-e34e21d4404a
md"""
But we don't want to overwrite the previous functions -- we might want 1D and 2D walkers.

Instead we would like to say to the `trajectory` function "use these functions instead of `initialise` and `move`. In other words, we should *pass them as parameters to the function*!:
"""

# ╔═╡ 08a01237-4a4a-4201-af7a-6115e70d4bd3
function trajectory(T, initialise, move)
    
    x = initialise()

    traj = [x]  

    for t in 1:T
        x = move(x)
        push!(traj, x)
    end

    return traj
end

# ╔═╡ 48b6d786-6f11-475a-b7cd-e5e640e81feb
md"""
This is an example of **generic programming**: `trajectory` has suddenly become a *completely general* function that can calculate trajectories of "anything that behaves like a walker". And "behaving like a walker" corresponds to "having an `initialise` function and a `move` function.
"""

# ╔═╡ 869f17e2-d26c-41ca-a874-af851407db85
md"""
**Exercise**: For example, make a "walker" that computes the powers of two starting at $2^0$ = 1, by defining suitable `initialise` and `move` functions.
"""

# ╔═╡ e1077b5c-105a-471a-b829-60fa5c382ce2
initialpow() = 1

# ╔═╡ 0d6608b8-03fa-49f2-bdf4-f4b6611f4841
movepow(x)=2x

# ╔═╡ 076fd852-f857-4f2c-9acb-545a69df79c3
md"""
## Analysing the nouns: Types
"""

# ╔═╡ c997cfee-43fc-420b-87f5-a6f53272540c
md"""
In the above versions of the code, we have succeeded in making an abstraction for the verb "calculate a trajectory". But we haven't succeeded in making an abstraction for the noun "walker"; a walker has a position, but it's somehow implicit in the `initialise` function that we define.

Let's try to make it more explicit by defining `struct`s, i.e. user-defined types, and functions that act on them:


"""

# ╔═╡ 1ded8661-e0f6-4995-ac57-e865fbcf3b31
struct Walker1D
    x::Int
end

# ╔═╡ b8aa8824-7bfa-4bbe-9590-4083c666e92b
move(w::Walker1D) = Walker1D( w.x + jump() )

# ╔═╡ e3577174-d50e-4c55-a4dd-389fbe6d3aa5
w = Walker1D(0)

# ╔═╡ 4af0021a-13ee-46fc-be35-ab6eb6d96c25
md"""
Now we can do the same in 2D, by defining a new type `Walker2D` and writing a **new method** of the *same* function `move`, that now acts on objects of type `Walker2D`:
"""

# ╔═╡ 9cd1101b-bf4d-4e4f-ab39-0e9fd275e276
struct Walker2D
    x::Int
    y::Int
end

# ╔═╡ 9081070a-7a22-4b2d-a01b-7eca6a5635c9
move(w::Walker2D) = Walker2D( w.x + jump(), w.y + jump() )

# ╔═╡ 29c3f928-85a4-46f6-9a20-2adc844743f7
function trajectory(T)
    x = initial_position()

    traj = [x]

    for t in 1:T
        x = move(x)
        push!(traj, x)
    end

    return traj
end

# ╔═╡ 52597508-0096-452c-ba75-939cc035e7f1
function trajectory(T, w)   

    traj = [w]

    for t in 1:T
        w = move(w)
        push!(traj, w)
    end

    return traj
end

# ╔═╡ 79b4988f-c672-4fd6-949e-c5b679624c4a
trajectory(10,initialpow,movepow)

# ╔═╡ c7c528cf-80f0-4506-a70f-289f0811b76a
trajectory(20,20)

# ╔═╡ 3d814a6e-2672-44a6-b5b5-8592b4b09aa7
trajectory(20)

# ╔═╡ b28456d2-ba9d-4403-b98d-fb0642ea6779
trajectory(20, initial_position, move)  # uses 1D functions defined previously

# ╔═╡ 0aee711e-2de0-4924-9484-ace9c9ae2ca3
trajectory(20, initialise_2D, move_2D)  # uses 2D functions defined previously

# ╔═╡ cad38693-d05f-4abd-9a4a-1634d59a608f
trajectory(20, w)

# ╔═╡ 6389489b-2e4e-4eb9-af86-168435b23f7d
w2 = Walker2D(3, 4)

# ╔═╡ 8f4c3c23-cb48-46f5-993b-fa9a3905f639
trajectory(20, w2)

# ╔═╡ b4296e12-9963-45b4-99d5-01e6a97788db
md"""
**Exercise**: How could you write a walker in $n$ dimensions? What data structure could you use for the walker's position? A good solution for this is the [`StaticArrays` package](https://github.com/JuliaArrays/StaticArrays.jl).
"""

# ╔═╡ Cell order:
# ╟─446999ab-c96b-4a42-be23-d198db1328bf
# ╟─74277812-e12e-11eb-2ae4-ef18b2d40b66
# ╠═cb99dae0-1b9c-4807-a2fc-32b5dd49f2d3
# ╠═51a963f1-4dc3-48ca-b67c-1761a85d2916
# ╠═80de5d24-27ab-4070-926a-c7f242de3f6a
# ╟─70159c23-0928-4914-8e3a-e322296b9f6e
# ╠═aced5107-4ede-490f-b644-720acacf71ba
# ╟─04aeb029-7b93-4afc-8f1b-a8cdcc8a6252
# ╠═7905a14e-fcf1-4e20-9acf-816438d899ea
# ╠═e2948a76-f6fc-4d80-b3b0-cc43d9dacc44
# ╟─7657d417-7e90-4c7c-9057-cb4ac3684cb3
# ╠═4c6067cb-69a7-44d1-b052-92a7bad5d7cf
# ╠═8e28f6ea-5be9-4fea-9207-6c8563d941e3
# ╟─58885adc-a2ff-432f-8918-3d4b1471dee2
# ╟─834a9ba2-a3b5-4ab4-b1d5-becf4bdb8445
# ╟─19f20b48-fb22-4bca-bd53-365acf981978
# ╟─b6854a7c-ebc2-4d53-98b0-a6bd898886ee
# ╟─9c0ef6de-ced5-4c85-a65a-82630451f8fe
# ╠═95b3f8bc-26c5-4845-be71-389d1c4fb9b4
# ╠═3a9c21ed-f197-4ecc-af41-947de7ae0de4
# ╟─10105a99-2296-4764-8bc7-ffc1cb831238
# ╟─7e203141-9790-437f-8d60-d479cd9d602c
# ╠═2010815b-b05b-4505-b4ae-d98d06cdc9b8
# ╠═3d0fcbde-724b-4ed3-8700-e5dac970e2bb
# ╟─4d9b5416-d6f4-435c-8bde-e34e21d4404a
# ╠═08a01237-4a4a-4201-af7a-6115e70d4bd3
# ╟─48b6d786-6f11-475a-b7cd-e5e640e81feb
# ╟─869f17e2-d26c-41ca-a874-af851407db85
# ╠═e1077b5c-105a-471a-b829-60fa5c382ce2
# ╠═0d6608b8-03fa-49f2-bdf4-f4b6611f4841
# ╠═79b4988f-c672-4fd6-949e-c5b679624c4a
# ╠═c7c528cf-80f0-4506-a70f-289f0811b76a
# ╟─076fd852-f857-4f2c-9acb-545a69df79c3
# ╟─c997cfee-43fc-420b-87f5-a6f53272540c
# ╠═1ded8661-e0f6-4995-ac57-e865fbcf3b31
# ╠═b8aa8824-7bfa-4bbe-9590-4083c666e92b
# ╠═e3577174-d50e-4c55-a4dd-389fbe6d3aa5
# ╟─4af0021a-13ee-46fc-be35-ab6eb6d96c25
# ╠═9cd1101b-bf4d-4e4f-ab39-0e9fd275e276
# ╠═9081070a-7a22-4b2d-a01b-7eca6a5635c9
# ╠═29c3f928-85a4-46f6-9a20-2adc844743f7
# ╠═52597508-0096-452c-ba75-939cc035e7f1
# ╠═3d814a6e-2672-44a6-b5b5-8592b4b09aa7
# ╠═b28456d2-ba9d-4403-b98d-fb0642ea6779
# ╠═0aee711e-2de0-4924-9484-ace9c9ae2ca3
# ╠═cad38693-d05f-4abd-9a4a-1634d59a608f
# ╠═6389489b-2e4e-4eb9-af86-168435b23f7d
# ╠═8f4c3c23-cb48-46f5-993b-fa9a3905f639
# ╟─b4296e12-9963-45b4-99d5-01e6a97788db
