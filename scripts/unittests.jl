using OMJulia
using Base.Filesystem

cd(@__DIR__)
cd("..")
mofiles = []
println("foo")
for (root, dirs, files) in walkdir("SHMConduction")
    global mofiles
    mofiles = vcat(mofiles, [joinpath(root, f) for f in files if endswith(f, ".mo")])
end
println(mofiles)

omc = OMJulia.OMCSession()
try
    r = omc.sendExpression("loadFiles({$(join(["\"$f\"" for f in mofiles], ", "))})")
    println(r)
    print("Errors: ")
    println(omc.sendExpression("getErrorString()"))
    println("loaded")
finally
    omc.sendExpression("quit()")
    println("quit()")
end
