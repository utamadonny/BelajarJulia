using JuMP, GLPK, Cbc

model= Model(Cbc.Optimizer)

@variable(model,pennies >=0,Int)
@variable(model,nickels >=0,Int)
@variable(model, dimes>=0,Int)
@variable(model,quarters>=0,Int)

@constraint(model, 1*pennies+5*nickels+10*dimes+25*quarters >= 92)

@objective(model,Min,2.5*pennies + 5*nickels + 2.268*dimes+5.678*quarters)

optimize!(model)

println("Minimum Weight:", objective_value(model), "  grams")
println("using")
println(round(value(pennies)), "  pennies")
println(round(value(nickels)), "  nickels")
println(round(value(dimes)), "  dimes")
println(round(value(quarters)), "  quarters")