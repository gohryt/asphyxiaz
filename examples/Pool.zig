const std = @import("std");
const asphyxiaz = @import("asphyxiaz");

const Object = struct {
    value: i32,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        if (gpa.deinit() == .leak) {
            std.log.err("gpa leak", .{});
        }
    }

    const allocator = gpa.allocator();

    var pool = asphyxiaz.Pool(Object).init(allocator, null);
    defer pool.deinit();

    const object_1 = try pool.get();
    object_1.data.value = 42;
    pool.put(object_1);

    const object_2 = try pool.get();
    std.debug.assert(object_2.data.value == 42);
    pool.put(object_2);
}
