## sudoku grid -----------------------------------------------------------------
grid = 
[
	4 0 0  0 0 6  3 0 0 
	0 0 0  7 1 0  0 4 9 
	0 0 0  0 8 0  2 0 1 

	0 2 0  0 0 0  8 0 4 
	0 0 6  0 0 0  9 0 0 
	8 0 7  0 0 0  0 2 0 

	1 0 9  0 5 0  0 0 0 
	7 8 0  0 3 9  0 0 0 
	0 0 4  8 0 0  0 0 3
] #http://www.dailysudoku.com/sudoku/today.shtml

using JuMP, GLPK

m = Model(GLPK.Optimizer)

## ------ set binary value sudoku cell
@variable(m, x[i=1:9, j=1:9, k=1:9],Bin)

## Constraint 1 : Each cell can only have 1 value
for i in 1:9, j in 1:9
	@constraint(m,sum(x[i,j,k] for k =1:9)==1)
end

## Constraint 2 : Each value appears once per column and per row
for ind = 1:9, k = 1:9
	@constraint(m, sum(x[ind,:,k]) ==1 )
	@constraint(m, sum(x[i, ind, k] for i =1:9)==1) 
end
#------
# for k in 1:9, j in 1:9
# 	@constraint(m,sum(x[:,j,k])==1)
# end

# for i in 1:9, k in 1:9
# 	@constraint(m,sum(x[i,:,k])==1)
# end

## Constraint 3 Each Value appears once per grid --------
# for i in 1:3:7, j in 1:3:7, k in 1:9
# 	@constraint(m, sum{x[r,c,k],r=i:i+2,c=j:j+2}==1)
# end
#----
for i in 1:3:7, j in 1:3:7, k in 1:9
	@constraint(m, sum(x[i:i+2, j:j+2,k])==1)
end

## ----------------------------------------------------------
# for i =1:9, j=1:9
# 	if grid[i,j] !=0
# 		fix(x[i,j,grid[i,j]],1; force =true)
# 	end
# end

for i in 1:9, j in 1:9
	if grid[i,j] != 0
		@constraint(m, (x[i,j,grid[i,j]])==1)
	end
end
## SOLVE----------------------------------------------------------
# grid[9,1] != 0

optimize!(m)

## DISPLAY-----------------------------------
x_val = value.(x)
# Create a matrix to store the solution
sol = zeros(Int,9,9)  # 9x9 matrix of integers
for i in 1:9, j in 1:9, k in 1:9
# Integer programs are solved as a series of linear programs
# so the values might not be precisely 0 and 1. We can just
# round them to the nearest integer to make it easier
	if round(x_val[i,j,k]) == 1
		sol[i,j] = k
	end
end
# Display the solution
# println(sol)
#-----------------------
# if status == :Infeasible
# 	error("No solution found!")
# else
# 	# Solver returns floats. Convert to int.
	# out = value.(x)
	# sol = zeros(Int,9,9)
	# for i in 1:9, j in 1:9, k in 1:9
	# 	if out[i, j, k] >= 0.9
	# 		sol[i, j] = k
	# 	end
	# end


# value.(x)
# Display solution
println("Solution:")
println("[-----------------------]")
for i in 1:9
	print("[ ")
	for j in 1:9
		print("$(sol[i,j]) ")
		if j % 3 == 0 && j < 9
			print("| ")
		end
	end
	println("]")
	if i % 3 == 0
		println("[-----------------------]")
	end
end