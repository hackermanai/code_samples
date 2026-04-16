
//
//
/*a*/

"a"
"a\"b"
'a'
'\n'

@
@private
@cold

#
#+optional_ok

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
123i

foo
foo()
foo(
foo.bar
foo::bar

nil
true
false

int
u8
u16
u32
u64
i8
i16
i32
i64
f32
f64
bool
string
cstring
uintptr

x := 123
y := 0..10
z := 1.0e-3

main :: proc() {
}

add :: proc(a: int, b: int) -> int {
    return a + b
}

square :: proc(x: f32) -> f32 {
    return x * x
}

Point :: struct {
    x: f32,
    y: f32,
}

Value :: union {
    i: int,
    f: f32,
}

Color :: enum {
    Red,
    Green,
    Blue,
}

Flags :: bit_set[enum {
    A,
    B,
    C,
}]

foreign import libc "system:libc"

when ODIN_OS == .Windows {
    x := 1
} else {
    x := 2
}

foo_proc :: proc() {
    if true {
        fmt.println("hello")
    } else {
        fmt.println("nope")
    }

    for i in 0..10 {
        fmt.println(i)
    }
}

arr := [3]int{1, 2, 3}
slice := []int{1, 2, 3}
m := map[string]int{
    "a" = 1,
    "b" = 2,
}

p := Point{1, 2}
q := Point{x = 1, y = 2}

using context

defer fmt.println("done")
