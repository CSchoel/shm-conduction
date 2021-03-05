using ModelicaScriptingTools: withOMC, testmodel
using Base.Filesystem
using Test
using OMJulia

projectroot = dirname(@__DIR__)

outdir = joinpath(projectroot, "out")
modeldir = projectroot
# use reference data from SHM project if available
refdir = joinpath(projectroot, "../shm-ref")

if !ispath(outdir)
    mkdir(outdir)
end

withOMC(outdir, modeldir) do omc
    @testset "Simulate examples" begin
        @testset "UnidirectionalConductionExample" begin
            testmodel(omc, "SHMConduction.Examples.ModularExample"; refdir=refdir)
        end
        @testset "PVCExample" begin
            testmodel(omc, "SHMConduction.Examples.PVCExample"; refdir=refdir)
            # we cannot change with_sinus using simflags and -override
            # because it is a structural parameter => create wrapper model
            OMJulia.sendExpression(omc, "model PVCNoSinus extends SHMConduction.Examples.PVCExample(with_sinus=false); end PVCNoSinus;")
            es = OMJulia.sendExpression(omc, "getErrorString()")
            @test isempty(es)
            testmodel(omc, "PVCNoSinus";  override=Dict(
                "stopTime"=>55, "numberOfIntervals"=>27500
            ), refdir=refdir)
        end
    end
end
