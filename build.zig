const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const asphyxiaz_module = b.addModule("asphyxiaz", .{
        .root_source_file = b.path("src/root.zig"),
    });

    const list_DL = b.addExecutable(.{
        .name = "eventloop-delay",
        .root_source_file = b.path("examples/list-DL/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    list_DL.root_module.addImport("asphyxiaz", asphyxiaz_module);

    b.installArtifact(list_DL);

    const list_DL_cmd = b.addRunArtifact(list_DL);

    list_DL_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        list_DL_cmd.addArgs(args);
    }

    const list_DL_step = b.step("list-DL", "Run the list-DL example");
    list_DL_step.dependOn(&list_DL_cmd.step);

    const asphyxiaz_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const run_asphyxiaz_unit_tests = b.addRunArtifact(asphyxiaz_unit_tests);

    const list_DL_unit_tests = b.addTest(.{
        .root_source_file = b.path("examples/eventloop-delay/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const run_list_DL_unit_tests = b.addRunArtifact(list_DL_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_asphyxiaz_unit_tests.step);
    test_step.dependOn(&run_list_DL_unit_tests.step);
}
