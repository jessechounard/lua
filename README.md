# Lua
This is [Lua](https://github.com/lua/lua), packaged for [Zig](https://ziglang.org/). (Intended for C or C++ projects using Zig as a build tool.)

## Usage
First, update your `build.zig.zon`:
```sh
zig fetch --save git+https://github.com/jessechounard/lua
```

Next, in your `build.zig`, you can access the library as a dependency:
```zig
const lua_dep = b.dependency("lua", .{
    .target = target,
    .optimize = optimize,
});
const lua_lib = lua_dep.artifact("lua");
exe.linkLibrary(lua_lib);
```

Finally, in your C++ file, you can use the library. Take note that in C++ you'll need to wrap the headers in an extern block:  
```cpp
extern "C" {

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

}

int main() {
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);
    const char *s = "print(\"Hello from Lua!\")";
    luaL_dostring(L, s);
    lua_close(L);

    return 0;
}

```

### Note
[Lua](https://www.lua.org/) is licensed under the MIT software license. The only thing I've contributed is the zig build files, under the same license.

I'm currently only building the library for loading Lua into your programs. If you want the standalone compiler or the interactive repl included, please let me know.
