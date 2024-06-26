pub fn LIFO(comptime T: type) type {
    return struct {
        const Self = @This();

        head: ?*Node,
        tail: ?*Node,

        pub const Node = struct {
            next: ?*Node,
            data: T,
        };

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

        pub fn push_tail(self: *Self, node: *Node) void {
            node.next = null;

            if (self.tail) |tail| {
                tail.next = node;
            } else {
                self.head = node;
            }

            self.tail = node;
        }

        pub fn pop_head(self: *Self) ?*Node {
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

        head: ?*Node,

        pub const Node = struct {
            next: ?*Node,
            data: T,
        };

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

        pub fn push_head(self: *Self, node: *Node) void {
            node.next = self.head;
            self.head = node;
        }

        pub fn pop_head(self: *Self) ?*Node {
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
