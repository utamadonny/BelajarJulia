using Printf
using Statistics

i=1
while i<20
    if (i%2)==0
        println(i)
        global i +=1
        continue
    end
    global i +=1
    if i>10
        break
    end
end
