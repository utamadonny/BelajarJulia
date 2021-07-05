using DifferentialEquations
f(u,p,t)=1.01*u
u0=1/2
tspan=(0.0,1.0)
prob=ODEProblem(f,u0,tspan)
sol=solve(prob)

using Plots; 
plot(sol,
	lw=2,
	ls=:dashdot,
	c=:red,
	title="Solution to the linear ODE",
	xaxis="Time (t)",yaxis="u(t) (in μm)",
	label="Solution") # legend=false
plot!(sol.t, t->0.5*exp(1.01t),
	lw=3,ls=:dash,c=:blue,label="True Solution!")