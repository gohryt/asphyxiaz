const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const asphyxiaz_module = b.addModule("asphyxiaz", .{
        .root_source_file = b.path("src/root.zig"),
    });

    // list.Queue example
    const list_Queue = b.addExecutable(.{
        .name = "list-Queue",
        .root_source_file = b.path("examples/list/Queue.zig"),
        .target = target,
        .optimize = optimize,
    });

    list_Queue.root_module.addImport("asphyxiaz", asphyxiaz_module);

    b.installArtifact(list_Queue);

    const list_Queue_cmd = b.addRunArtifact(list_Queue);

    list_Queue_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        list_Queue_cmd.addArgs(args);
    }

    const list_Queue_step = b.step("list-Queue", "Run the list-Queue example");
    list_Queue_step.dependOn(&list_Queue_cmd.step);

    // list.Stack example
    const list_Stack = b.addExecutable(.{
        .name = "list-Stack",
        .root_source_file = b.path("examples/list/Stack.zig"),
        .target = target,
        .optimize = optimize,
    });

    list_Stack.root_module.addImport("asphyxiaz", asphyxiaz_module);

    b.installArtifact(list_Stack);

    const list_Stack_cmd = b.addRunArtifact(list_Stack);

    list_Stack_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        list_Stack_cmd.addArgs(args);
    }

    const list_Stack_step = b.step("list-Stack", "Run the list-Queue example");
    list_Stack_step.dependOn(&list_Stack_cmd.step);

    // list.DoublyLinked example
    const list_DoublyLinked = b.addExecutable(.{
        .name = "list-DoublyLinked",
        .root_source_file = b.path("examples/list/DoublyLinked.zig"),
        .target = target,
        .optimize = optimize,
    });

    list_DoublyLinked.root_module.addImport("asphyxiaz", asphyxiaz_module);

    b.installArtifact(list_DoublyLinked);

    const list_DoublyLinked_cmd = b.addRunArtifact(list_DoublyLinked);

    list_DoublyLinked_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        list_DoublyLinked_cmd.addArgs(args);
    }

    const list_DoublyLinked_step = b.step("list-DoublyLinked", "Run the list-DoublyLinked example");
    list_DoublyLinked_step.dependOn(&list_DoublyLinked_cmd.step);

    // asphyxiaz tests
    const asphyxiaz_tests = b.addTest(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const asphyxiaz_tests_cmd = b.addRunArtifact(asphyxiaz_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&asphyxiaz_tests_cmd.step);
}
