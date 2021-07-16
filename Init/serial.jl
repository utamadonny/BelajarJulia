using Base: String, readuntil_string, readuntil_vector!
using LibSerialPort

list_ports()

s=LibSerialPort.open("/dev/ttyUSB0",115200)
## read debug
# if bytesavailable(s)>0
	# print(String(read(s)))
# end
print(String(read(s)))
set_read_timeout(s,100)
println(String(nonblocking_read(s))) #nice

# LibSerialPort.open("/dev/ttyUSB0", 115200) do s
# 	#write(s, "input")
# 	ret =  readuntil(s, '\n', 10.0)  #try to readline with a 1 second timeout
# 	@show ret
# end
ret = "1527654 310\r\n"
"1527654 310\r\n"
readuntil(s,'\n',2)
readline(s)

##  Close Serial Port
close(s)

## Test

LibSerialPort.open("/dev/ttyUSB0",115200) do sp
	sleep(2)

	if bytesavailable(sp) > 0
		println(String(read(sp)))
	end

	write(sp, "hello\n")
	sleep(0.1)	
	println(readline(sp))
end

##

using LibSerialPort

function serial_loop(sp::SerialPort)
    user_input = ""
    mcu_message = ""

    println("Starting I/O loop. Press ESC [return] to quit")

    while true
        # Poll for new data without blocking
        @async user_input = readline(keep=true)
        @async mcu_message *= String(nonblocking_read(sp))

        occursin("\e", user_input) && exit()  # escape

        # Send user input to device with ENTER
        if endswith(user_input, '\n')
            write(sp, "$user_input")
            user_input = ""
        end

        # Print response from device as a line
        if occursin("\n", mcu_message)
            lines = split(mcu_message, "\n")
            while length(lines) > 1
                println(popfirst!(lines))
            end
            mcu_message = lines[1]
        end

        # Give the queued tasks a chance to run
        sleep(0.0001)
    end
end

function console(args...)

    if length(args) != 2
        println("Usage: $(basename(@__FILE__)) port baudrate")
        println("Available ports:")
        list_ports()
        return
    end

    # Open a serial connection to the microcontroller
    mcu = open(args[1], parse(Int, args[2]))

    serial_loop(mcu)
end

console(ARGS...)