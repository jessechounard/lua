const std = @import("std");

pub fn build(b: *std.Build) !void {
    const upstream = b.dependency("lua", .{});
    const lib = b.addStaticLibrary(.{
        .name = "lua",
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });
    lib.linkLibC();
    lib.addIncludePath(upstream.path("."));
    lib.addCSourceFiles(.{
        .root = upstream.path("."),
        .files = &.{
            "lapi.c",
            "lauxlib.c",
            "lbaselib.c",
            "lcode.c",
            "lcorolib.c",
            "lctype.c",
            "ldblib.c",
            "ldebug.c",
            "ldo.c",
            "ldump.c",
            "lfunc.c",
            "lgc.c",
            "liolib.c",
            "linit.c",
            "llex.c",
            "lmathlib.c",
            "lmem.c",
            "loadlib.c",
            "lobject.c",
            "lopcodes.c",
            "loslib.c",
            "lparser.c",
            "lstate.c",
            "lstring.c",
            "lstrlib.c",
            "ltable.c",
            "ltablib.c",
            "ltm.c",
            "lundump.c",
            "lutf8lib.c",
            "lvm.c",
            "lzio.c",
        },
    });

    lib.installHeadersDirectory(upstream.path("."), "", .{});
    b.installArtifact(lib);
}
