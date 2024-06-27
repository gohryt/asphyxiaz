const std = @import("std");
const asphyxiaz = @import("asphyxiaz");

const Greeter = struct {
    name: []const u8,
    greeting_count: u32,

    pub fn run(self: *Greeter) void {
        self.greeting_count += 1;
        std.debug.print("Hello, {s}! This is greeting count is {}\n", .{ self.name, self.greeting_count });
    }
};

const GreeterPrototype = asphyxiaz.Closure.Prototype(Greeter);

fn executeClosure(closure: asphyxiaz.Closure) void {
    closure.run(closure.ptr);
}

pub fn main() !void {
    var greeter = GreeterPrototype{
        .data = .{
            .name = "Alice",
            .greeting_count = 0,
        },
    };

    const closure = greeter.build();
    executeClosure(closure);
    executeClosure(closure);

    std.debug.print("Final greeting count for {s}: {}\n", greeter.data);

    var another_greeter = GreeterPrototype{
        .data = Greeter{
            .name = "Bob",
            .greeting_count = 10,
        },
    };

    const another_closure = another_greeter.build();
    executeClosure(another_closure);

    std.debug.print("Final greeting count for {s}: {}\n", another_greeter.data);
}
