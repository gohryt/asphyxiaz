const std = @import("std");
const asphyxiaz = @import("asphyxiaz");

const List = asphyxiaz.list.DL(u64);
const Node = List.Node;

pub fn main() !void {
    var list = List.init();

    var node_1 = Node{ .data = 1 };
    var node_2 = Node{ .data = 2 };

    list.pushHead(&node_1);
    list.pushTail(&node_2);

    _ = list.popHead();
    _ = list.popTail();
}
