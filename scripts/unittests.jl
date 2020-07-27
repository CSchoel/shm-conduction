using ModelicaScriptingTools: withOMC, testmodel
using Base.Filesystem
using Test

projectroot = dirname(@__DIR__)

outdir = joinpath(projectroot, "out")
modeldir = projectroot
refdir = joinpath(projectroot, "regRefData")

if !ispath(outdir)
    mkdir(outdir)
end

withOMC(outdir, modeldir) begin omc
    @testset "Simulate examples" begin
        @testset "UnidirectionalConductionExample" begin
            testmodel(omc, "SHMConduction.Examples.ModularExample"; refdir=refdir)
        end
        @testset "PVCExample" begin
            testmodel(omc, "SHMConduction.Examples.PVCExample"; refdir=refdir)
        end
    end
end
