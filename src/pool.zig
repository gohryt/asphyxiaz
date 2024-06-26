const std = @import("std");

const List = @import("./List.zig");

pub fn Pool(comptime T: type) type {
    return struct {
        const Self = @This();

        const TList = List.LIFO(T);
        const TNode = TList.Node;

        allocator: std.mem.Allocator,
        list: TList,

        pub fn init(allocator: std.mem.Allocator) Self {
            return .{
                .allocator = allocator,
                .list = TList.init(),
            };
        }

        fn destroy(self: *Self, node: *TNode) void {
            self.allocator.destroy(node);
        }

        pub fn deinit(self: *Self) void {
            self.list.each(Self, self, destroy);
            self.list.deinit();
        }

        pub fn get(self: *Self) !*TNode {
            if (self.list.pop_head()) |node| {
                return node;
            }

            return try self.allocator.create(TNode);
        }

        pub fn put(self: *Self, node: *TNode) void {
            self.list.push_tail(node);
        }
    };
}
