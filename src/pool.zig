const std = @import("std");
const list = @import("list.zig");

pub fn Pool(comptime T: type) type {
    return struct {
        const Self = @This();

        const List = list.Queue(T);
        const Node = List.Node;

        allocator: std.mem.Allocator,
        list: List,
        size: usize = 0,
        free: usize = 0,

        pub fn init(allocator: std.mem.Allocator, size: ?usize) Self {
            return .{
                .allocator = allocator,
                .list = List.init(),
                .size = if (size) |value| value else 0,
            };
        }

        pub fn deinit(self: *Self) void {
            var iterator = self.list.iterator();

            while (iterator.next()) |node| {
                self.allocator.destroy(node);
            }

            self.list.deinit();
        }

        pub fn get(self: *Self) !*Node {
            if (self.list.pull()) |node| {
                self.free -= 1;
                return node;
            }

            return try self.allocator.create(Node);
        }

        pub fn put(self: *Self, node: *Node) void {
            if (self.size == 0 or (self.free < self.size)) {
                self.free += 1;
                self.list.push(node);
            } else {
                self.allocator.destroy(node);
            }
        }
    };
}
