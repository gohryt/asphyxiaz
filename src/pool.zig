const std = @import("std");

const list = @import("./list.zig");

pub fn Pool(comptime T: type) type {
    return struct {
        const Self = @This();

        const List = list.LIFO(T);
        const Node = List.Node;

        allocator: std.mem.Allocator,
        list: List,

        pub fn init(allocator: std.mem.Allocator) Self {
            return .{
                .allocator = allocator,
                .list = List.init(),
            };
        }

        fn destroy(self: *Self, node: *Node) void {
            self.allocator.destroy(node);
        }

        pub fn deinit(self: *Self) void {
            self.list.each(Self, self, destroy);
            self.list.deinit();
        }

        pub fn get(self: *Self) !*Node {
            if (self.list.popHead()) |node| {
                return node;
            }

            return try self.allocator.create(Node);
        }

        pub fn put(self: *Self, node: *Node) void {
            self.list.pushTail(node);
        }
    };
}
