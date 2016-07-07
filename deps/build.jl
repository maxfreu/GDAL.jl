using BinDeps

@BinDeps.setup

function version_check(name, handle)
    fptr = Libdl.dlsym(handle, :GDALVersionInfo)
    versionptr = ccall(fptr,Cstring,(Cstring,),"RELEASE_NAME")
    versionstring = bytestring(versionptr)
    gdalversion = convert(VersionNumber, versionstring)
    gdalversion >= v"2.1.0"
end

libgdal = library_dependency("libgdal",
                             aliases=["gdal","gdal201", "gdal_w32","gdal_w64","libgdal-20"],
                             validate=version_check)

@windows_only begin
    using WinRPM
    push!(WinRPM.sources, "http://download.opensuse.org/repositories/home:yeesian/openSUSE_13.2")
    WinRPM.update()
    provides(WinRPM.RPM, "gdal", [libgdal], os = :Windows)
end

@unix_only begin
    using Conda
    # conda-forge has an up to date gdal recipe
    # https://github.com/conda-forge/gdal-feedstock
    Conda.add_channel("conda-forge")
    provides(Conda.Manager, "gdal", libgdal)
end

@BinDeps.install Dict(:libgdal => :libgdal)