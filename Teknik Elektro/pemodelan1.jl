using Modia, ModiaPlot

SimpleModel = Model(
    T = 0.4,
    x = Var(init=0.2),
    equation = :[T * der(x) + x = 1],
)

simpleModel = @instantiateModel(SimpleModel)
simulate!(simpleModel, stopTime = 1.2)
simulate!(simpleModel, Tsit5(), stopTime = 1.2u"s")
plot(simpleModel, ("x", "der(x)"), figure=1)