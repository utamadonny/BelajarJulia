using JuMP, Ipopt, Gadfly

N = 100
L = 1
h = 2*L/N

m= Model(Ipopt.Optimizer)

@variable(m, x[0:N])
@variable(m, y[0:N])

@constraint(m, x[0] == 0)
@constraint(m, y[0] == 0)
@constraint(m, x[N] == L)
@constraint(m, y[N] == 0)

for j in 0:N
	setvalue(x[j],0)
	setvalue(y[j],0)
end

for j in 1:N
	@constraint(m,
		(x[j] - x[j-1])^2 + (y[j] - y[j-1])^2 <= h^2)
end

optimize!(m)

# value.(x)
# value.(x)[1]

x_clean = Float64[]
y_clean = Float64[]
for j in 0:N
	push!(x_clean, value.(x)[j])
	push!(y_clean, value.(y)[j])
end

catenary = plot(x=x_clean, y=y_clean, Coord.Cartesian(xmin=0, xmax=1,))
draw(SVG("catenary.svg", 6inch, 6inch), catenary)