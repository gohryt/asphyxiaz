const Closure = @This();

ptr: *const anyopaque,
run: *const fn (*const anyopaque) void,

pub fn Prototype(comptime prototype: type) type {
    const prototype_info = @typeInfo(prototype);

    if (prototype_info != .Struct) {
        @compileError("'prototype' should be struct");
    }

    if (!@hasDecl(prototype, "run")) {
        @compileError("prototype should declare pub fn 'run' which takes prototype as first argument");
    }

    const run = @field(prototype, "run");

    const run_info = @typeInfo(@TypeOf(run));

    if (run_info != .Fn) {
        @compileError("'run' should be fn");
    }

    return struct {
        const Self = @This();

        data: prototype,

        pub fn build(self: *Self) Closure {
            return .{
                .ptr = @ptrCast(&self.data),
                .run = @ptrCast(&run),
            };
        }
    };
}
