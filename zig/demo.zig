//! Koi Editor Zig lexer test.
//! Exercises common Zig syntax and outline behavior.

const std = @import("std");
const Allocator = std.mem.Allocator;

const version: []const u8 = "0.1.0";
const max_items: usize = 128;

const Status = enum {
    idle,
    running,
    stopped,
};

const Value = union(enum) {
    integer: i64,
    float: f64,
    text: []const u8,
};

const Point = struct {
    x: f32,
    y: f32,

    pub fn init(x: f32, y: f32) Point {
        return .{
            .x = x,
            .y = y,
        };
    }

    pub fn length(self: Point) f32 {
        return @sqrt(self.x * self.x + self.y * self.y);
    }
};

const App = struct {
    allocator: Allocator,
    status: Status = .idle,
    points: std.ArrayList(Point),

    pub fn init(allocator: Allocator) App {
        return .{
            .allocator = allocator,
            .points = .empty,
        };
    }

    pub fn deinit(self: *App) void {
        self.points.deinit(self.allocator);
    }

    pub fn addPoint(self: *App, point: Point) !void {
        try self.points.append(self.allocator, point);
    }

    pub fn run(self: *App) !void {
        self.status = .running;

        for (self.points.items, 0..) |point, index| {
            std.debug.print(
                "{d}: ({d:.2}, {d:.2}) length={d:.2}\n",
                .{ index, point.x, point.y, point.length() },
            );
        }

        self.status = .stopped;
    }
};

fn parseNumber(text: []const u8) !i64 {
    return try std.fmt.parseInt(i64, text, 10);
}

fn findPoint(points: []const Point, x: f32) ?Point {
    for (points) |point| {
        if (point.x == x) {
            return point;
        }
    }

    return null;
}

fn describeValue(value: Value) void {
    switch (value) {
        .integer => |number| {
            std.debug.print("integer: {d}\n", .{number});
        },
        .float => |number| {
            std.debug.print("float: {d}\n", .{number});
        },
        .text => |text| {
            std.debug.print("text: {s}\n", .{text});
        },
    }
}

fn arrayAndPointerDemo() void {
    var values = [_]u32{ 10, 20, 30, 40 };
    const slice: []u32 = values[1..3];
    const ptr: *u32 = &values[0];

    ptr.* += 1;

    for (slice) |value| {
        std.debug.print("{d}\n", .{value});
    }
}

fn optionalDemo(value: ?u32) u32 {
    return value orelse 0;
}

fn multilineStringDemo() void {
    const message =
        \\This is a Zig
        \\multiline string.
        \\Braces here should not affect folding: { }
    ;

    std.debug.print("{s}\n", .{message});
}

fn nestedDemo() void {
    const Local = struct {
        value: i32,

        fn doubled(self: @This()) i32 {
            return self.value * 2;
        }
    };

    const item = Local{ .value = 21 };
    std.debug.print("{d}\n", .{item.doubled()});
}

/// Application entry point.
pub fn main() !void {
    var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var app = App.init(allocator);
    defer app.deinit();

    try app.addPoint(Point.init(3.0, 4.0));
    try app.addPoint(Point.init(5.0, 12.0));

    try app.run();

    const number = try parseNumber("42");
    std.debug.print("number = {d}\n", .{number});

    const value = Value{ .integer = number };
    describeValue(value);

    arrayAndPointerDemo();
    multilineStringDemo();
    nestedDemo();

    // Normal comment containing fake syntax:
    // fn fakeFunction() void { }

    const maybe_point = findPoint(app.points.items, 3.0);
    if (maybe_point) |point| {
        std.debug.print("found: {any}\n", .{point});
    } else {
        std.debug.print("not found\n", .{});
    }
}
