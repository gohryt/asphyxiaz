const std = @import("std");
const asphyxiaz = @import("asphyxiaz");

const List = asphyxiaz.list.DoublyLinked(i32);

pub fn main() !void {
    var list = List.init();

    var node1 = List.Node{ .data = 1 };
    var node2 = List.Node{ .data = 2 };
    var node3 = List.Node{ .data = 3 };

    list.pushTail(&node1);
    list.pushHead(&node2);
    list.pushTail(&node3);

    var it = list.iterator();

    while (it.next()) |node| {
        std.debug.print("Node data: {}\n", .{node.data});
    }

    if (list.pullHead()) |node| {
        std.debug.print("Popped from front: {}\n", .{node.data});
    }
    if (list.pullTail()) |node| {
        std.debug.print("Popped from back: {}\n", .{node.data});
    }
}
