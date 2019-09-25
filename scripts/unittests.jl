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
    mopath = OMJulia.sendExpression(omc, "getModelicaPath()")
    mopath = "$mopath:$(escape_string(moroot))"
    println("Setting MODELICAPATH to ", mopath)
    OMJulia.sendExpression(omc, "setModelicaPath(\"$mopath\")")
    # load Modelica standard library
    OMJulia.sendExpression(omc, "loadModel(Modelica)")
    @testset "Simulate examples" begin
        @testset "UnidirectionalConductionExample" begin
            r = OMJulia.sendExpression(omc, "loadModel(SHMConduction.Examples.ModularExample)")
            @test r
            es = OMJulia.sendExpression(omc, "getErrorString()")
            @test es == ""
            r = OMJulia.sendExpression(omc, "simulate(SHMConduction.Examples.ModularExample, stopTime=50, numberOfIntervals=27500, outputFormat=\"csv\")")
            es = OMJulia.sendExpression(omc, "getErrorString()")
            @test es == ""
        end
        @testset "PVCExample" begin
            r = OMJulia.sendExpression(omc, "loadModel(SHMConduction.Examples.PVCExample)")
            @test r
            es = OMJulia.sendExpression(omc, "getErrorString()")
            @test es == ""
            r = OMJulia.sendExpression(omc, "simulate(SHMConduction.Examples.PVCExample, stopTime=50, numberOfIntervals=27500, outputFormat=\"csv\")")
            es = OMJulia.sendExpression(omc, "getErrorString()")
            @test es == ""
            # we cannot change with_sinus using simflags and -override
            # because it is a structural parameter => create wrapper model
            r = OMJulia.sendExpression(omc, "model PVCNoSinus extends SHMConduction.Examples.PVCExample(with_sinus=false); end PVCNoSinus;")
            r = OMJulia.sendExpression(omc, "simulate(PVCNoSinus, stopTime=50, numberOfIntervals=27500, outputFormat=\"csv\")")
            es = OMJulia.sendExpression(omc, "getErrorString()")
            @test es == ""
        end
    end
finally
    println("Closing OMC session")
    sleep(1)
    OMJulia.sendExpression(omc, "quit()", parsed=false)
    println("Done")
end
