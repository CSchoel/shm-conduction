using OMJulia
using Base.Filesystem

moroot = dirname(@__DIR__)

omc = OMJulia.OMCSession()
try
    mopath = omc.sendExpression("getModelicaPath()")[3:end-2]
    mopath = "$mopath:$(escape_string(moroot))"
    println("Setting MODELICAPATH to ", mopath)
    omc.sendExpression("setModelicaPath(\"$mopath\")")
    r = omc.sendExpression("loadModel(SHMConduction.Examples.UnidirectionalContractionExample)")
    println(r)
    print("Errors: ")
    println(omc.sendExpression("getErrorString()"))
    println("loaded")
finally
    omc.sendExpression("quit()")
    println("quit()")
end
