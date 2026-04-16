
//
//
/// doc comment
//! top doc comment

"a"
"a\"b"
'a'
'\n'

\\raw line
\\second raw line

@"identifier"
@"weird name"

@import
@sizeOf
@TypeOf
@embedFile

@import("std")
@sizeOf(u32)
@TypeOf(123)

:
::
->

.
..
...

0
0.
0..1
0xFF
0b1010
1.0e-3

foo
foo()
foo(
foo.bar

true
false
null
undefined

u8
u16
u32
u64
usize
i8
i16
i32
i64
isize
f16
f32
f64
bool
void
noreturn
type
anytype
anyerror
comptime_int
comptime_float

const x = 123;
var y: i32 = 0;
const z = 1.0e-3;

fn add(a: i32, b: i32) i32 {
    return a + b;
}

fn square(x: f32) f32 {
    return x * x;
}

const Point = struct {
    x: i32,
    y: i32,
};

const Value = union(enum) {
    i: i32,
    f: f32,
};

const Color = enum {
    red,
    green,
    blue,
};

pub fn main() !void {
    const std = @import("std");

    const p = Point{ .x = 1, .y = 2 };
    _ = p;

    if (true) {
        std.debug.print("hello\n", .{});
    } else {
        std.debug.print("nope\n", .{});
    }

    for (0..10) |i| {
        std.debug.print("{}\n", .{i});
    }

    const maybe_value: ?i32 = 42;
    const value = maybe_value orelse 0;

    const result: anyerror!i32 = 123;
    const unwrapped = result catch 0;

    _ = value;
    _ = unwrapped;

    defer std.debug.print("done\n", .{});
    errdefer std.debug.print("error path\n", .{});

    const n = switch (value) {
        0 => 0,
        1...10 => 1,
        else => 2,
    };
    _ = n;
}

test "add" {
    try std.testing.expect(add(1, 2) == 3);
}

test Point {
    const p = Point{ .x = 3, .y = 4 };
    try std.testing.expect(p.x == 3);
}

comptime {
    _ = @sizeOf(Point);
}

