pub fn Queue(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            next: ?*Node = null,
            data: T,
        };

        pub const Iterator = struct {
            node: ?*Node,

            pub fn next(self: *Iterator) ?*Node {
                if (self.node) |node| {
                    self.node = node.next;
                    return node;
                }

                return null;
            }
        };

        head: ?*Node = null,
        tail: ?*Node = null,

        pub fn init() Self {
            return .{
                .head = null,
                .tail = null,
            };
        }

        pub fn deinit(self: *Self) void {
            self.* = .{
                .head = null,
                .tail = null,
            };
        }

        pub fn iterator(self: *Self) Iterator {
            return .{ .node = self.head };
        }

        pub fn push(self: *Self, node: *Node) void {
            node.next = null;

            if (self.tail) |tail| {
                tail.next = node;
            } else {
                self.head = node;
            }

            self.tail = node;
        }

        pub fn pull(self: *Self) ?*Node {
            if (self.head) |head| {
                if (head.next) |next| {
                    self.head = next;
                } else {
                    self.* = .{
                        .head = null,
                        .tail = null,
                    };
                }

                return head;
            }

            return null;
        }
    };
}

pub fn Stack(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            next: ?*Node = null,
            data: T,
        };

        pub const Iterator = struct {
            node: ?*Node,

            pub fn next(self: *Iterator) ?*Node {
                if (self.node) |node| {
                    self.node = node.next;
                    return node;
                }

                return null;
            }
        };

        head: ?*Node = null,

        pub fn init() Self {
            return .{
                .head = null,
            };
        }

        pub fn deinit(self: *Self) void {
            self.* = .{
                .head = null,
            };
        }

        pub fn iterator(self: *Self) Iterator {
            return .{ .node = self.head };
        }

        pub fn push(self: *Self, node: *Node) void {
            node.next = self.head;
            self.head = node;
        }

        pub fn pull(self: *Self) ?*Node {
            if (self.head) |head| {
                self.head = head.next;
                return head;
            }

            return null;
        }
    };
}

pub fn DoublyLinked(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            previous: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        pub const Iterator = struct {
            node: ?*Node,

            pub fn next(self: *Iterator) ?*Node {
                if (self.node) |node| {
                    self.node = node.next;
                    return node;
                }

                return null;
            }
        };

        head: ?*Node = null,
        tail: ?*Node = null,

        pub fn init() Self {
            return .{
                .head = null,
                .tail = null,
            };
        }

        pub fn deinit(self: *Self) void {
            self.* = .{
                .head = null,
                .tail = null,
            };
        }

        pub fn iterator(self: *Self) Iterator {
            return .{ .node = self.head };
        }

        pub fn pushHead(self: *Self, node: *Node) void {
            if (self.head) |head| {
                node.next = head;
                head.previous = node;
            } else {
                node.next = null;
                self.tail = node;
            }

            node.previous = null;
            self.head = node;
        }

        pub fn pushTail(self: *Self, node: *Node) void {
            if (self.tail) |tail| {
                node.previous = tail;
                tail.next = node;
            } else {
                node.previous = null;
                self.head = node;
            }

            node.next = null;
            self.tail = node;
        }

        pub fn pullHead(self: *Self) ?*Node {
            if (self.head) |head| {
                self.head = head.next;

                if (self.head) |new_head| {
                    new_head.previous = null;
                } else {
                    self.tail = null;
                }

                return head;
            }

            return null;
        }

        pub fn pullTail(self: *Self) ?*Node {
            if (self.tail) |tail| {
                self.tail = tail.previous;

                if (self.tail) |new_tail| {
                    new_tail.next = null;
                } else {
                    self.head = null;
                }

                return tail;
            }

            return null;
        }
    };
}
