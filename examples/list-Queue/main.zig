const std = @import("std");
const asphyxiaz = @import("asphyxiaz");

const List = asphyxiaz.list.Queue(i32);

pub fn main() !void {
    var queue = List.init();

    var node1 = List.Node{ .data = 1 };
    var node2 = List.Node{ .data = 2 };
    var node3 = List.Node{ .data = 3 };

    queue.push(&node1);
    queue.push(&node2);
    queue.push(&node3);

    var it = queue.iterator();

    while (it.next()) |node| {
        std.debug.print("Node data: {}\n", .{node.data});
    }

    while (queue.pull()) |node| {
        std.debug.print("Dequeued: {}\n", .{node.data});
    }
}
