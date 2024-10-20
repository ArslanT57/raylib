function platform_defines()
    defines{"PLATFORM_DESKTOP"}

    filter {"options:graphics=opengl43"}
        defines{"GRAPHICS_API_OPENGL_43"}

    filter {"options:graphics=opengl33"}
        defines{"GRAPHICS_API_OPENGL_33"}

    filter {"options:graphics=opengl21"}
        defines{"GRAPHICS_API_OPENGL_21"}

    filter {"options:graphics=opengl11"}
        defines{"GRAPHICS_API_OPENGL_11"}

    filter {"options:graphics=openges3"}
        defines{"GRAPHICS_API_OPENGL_ES3"}

    filter {"options:graphics=openges2"}
        defines{"GRAPHICS_API_OPENGL_ES2"}

    filter {"system:macosx"}
        disablewarnings {"deprecated-declarations"}

    filter {"system:linux"}
        defines {"_GLFW_X11"}
        defines {"_GNU_SOURCE"}
end

project "raylib"
    kind "StaticLib"

    platform_defines()

    language "C"
    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")


    filter "action:vs*"
        defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS"}
        characterset ("Unicode")
        buildoptions { "/Zc:__cplusplus" }
    filter{}

    files {
        "src/**.h", 
        "src/**.c"
    }
    
    includedirs {
        "src", 
        "src/external/glfw/include" 
    }
    flags { "ShadowedVariables"}
    vpaths
    {
        ["Header Files"] = { "/src/**.h"},
        ["Source Files/*"] = { "/src/**.c"},
    }

    removefiles {"/src/rcore_*.c"}

    filter { "system:macosx", "files:" .. IncludeDir.raylib .. "/src/rglfw.c" }
        compileas "Objective-C"

    filter {}
