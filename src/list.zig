pub fn LIFO(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            next: ?*Node,
            data: T,
        };

        head: ?*Node,
        tail: ?*Node,

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

        pub fn pushTail(self: *Self, node: *Node) void {
            node.next = null;

            if (self.tail) |tail| {
                tail.next = node;
            } else {
                self.head = node;
            }

            self.tail = node;
        }

        pub fn popHead(self: *Self) ?*Node {
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

        pub fn each(self: *Self, comptime T_userdata: type, userdata: *T_userdata, do: fn (*T_userdata, *Node) void) void {
            var head = self.head;

            while (head) |node| {
                head = node.next;
                do(userdata, node);
            }
        }
    };
}

pub fn FIFO(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            next: ?*Node,
            data: T,
        };

        head: ?*Node,

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

        pub fn pushHead(self: *Self, node: *Node) void {
            node.next = self.head;
            self.head = node;
        }

        pub fn popHead(self: *Self) ?*Node {
            if (self.head) |head| {
                self.head = head.next;
                return head;
            }

            return null;
        }

        pub fn each(self: *Self, comptime T_userdata: type, userdata: *T_userdata, do: fn (*T_userdata, *Node) void) void {
            var head = self.head;

            while (head) |node| {
                head = node.next;
                do(userdata, node);
            }
        }
    };
}

pub fn DL(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            previous: ?*Node = null,
            next: ?*Node = null,
            data: T,
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

        pub fn popHead(self: *Self) ?*Node {
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

        pub fn popTail(self: *Self) ?*Node {
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

        pub fn each(self: *Self, comptime T_userdata: type, userdata: *T_userdata, do: fn (*T_userdata, *Node) void) void {
            var head = self.head;

            while (head) |node| {
                head = node.next;
                do(userdata, node);
            }
        }
    };
}
