using ControlSystems, Plots

sys = tf(1, [1,1])*delay(1)
stepplot(sys) # Compilation time might be long for first simulation
bodeplot(sys)
]
