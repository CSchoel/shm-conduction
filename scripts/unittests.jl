using OMJulia
using Base.Filesystem
using Test

moroot = dirname(@__DIR__)
outdir = "out"
cd(moroot)
if !ispath(outdir)
    mkdir(outdir)
end
cd(outdir)

omc = OMJulia.OMCSession()
try
    mopath = omc.sendExpression("getModelicaPath()")[2:end-2]
    mopath = "$mopath:$(escape_string(moroot))"
    println("Setting MODELICAPATH to ", mopath)
    omc.sendExpression("setModelicaPath(\"$mopath\")")
    # load Modelica standard library
    omc.sendExpression("loadModel(Modelica)")
    @testset "UnidirectionalConductionExample" begin
        r = omc.sendExpression("loadModel(SHMConduction.Examples.ModularExample)")
        @test r == "true\n"
        es = omc.sendExpression("getErrorString()")
        @test es == "\"\"\n"
        r = omc.sendExpression("simulate(SHMConduction.Examples.ModularExample, stopTime=50, numberOfIntervals=27500, outputFormat=\"csv\")")
        es = omc.sendExpression("getErrorString()")
        @test es == "\"\"\n"
    end
    @testset "PVCExample" begin
        r = omc.sendExpression("loadModel(SHMConduction.Examples.PVCExample)")
        @test r == "true\n"
        es = omc.sendExpression("getErrorString()")
        @test es == "\"\"\n"
        r = omc.sendExpression("simulate(SHMConduction.Examples.PVCExample, stopTime=50, numberOfIntervals=27500, outputFormat=\"csv\")")
        es = omc.sendExpression("getErrorString()")
        @test es == "\"\"\n"
        # we cannot change with_sinus using simflags and -override
        # because it is a structural parameter => create wrapper model
        r = omc.sendExpression("model PVCNoSinus extends SHMConduction.Examples.PVCExample(with_sinus=false); end PVCNoSinus;")
        r = omc.sendExpression("simulate(PVCNoSinus, stopTime=50, numberOfIntervals=27500, outputFormat=\"csv\")")
        es = omc.sendExpression("getErrorString()")
        @test es == "\"\"\n"
    end
finally
    println("Closing OMC session")
    sleep(1)
    omc.sendExpression("quit()")
    println("Done")
end
