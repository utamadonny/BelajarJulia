# if you have and array of [1 0 0 1 1] take the output to [1 1] and if [ 1 0 0 0 0] take the output to [1 0]
# A = [1 0 0 1 1]
A = [0 0 1 0 0]
out = zeros(1,2)

# for j in 1:2
j=0;
for i in A
		println(i)
		if i == 1
			j+=1
			out[1,j]=i
			println(out)
		end
	end
# end
println(out)
# # Iterating over a String 
# print("\nString Iteration\n")     
# s = "Geeks"
# for i in s 
#     println(i) 
# end