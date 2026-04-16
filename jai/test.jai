
/
//
/*a*/

"a"
"a\"b"

#
#scope
#scope_file
#bake_arguments

:
::

.
..
...

@
@note

0
0.
0..1
0xFF
0b1010
1.0e-3

foo
foo(
foo ::
foo :: (
foo :: inline
foo :: #bake_arguments

x : int
y := 123
z := 0..10

add :: (a: int, b: int) -> int {
    return a + b;
}

square :: (x: float) -> float {
    return x * x;
}

main :: () {
    value := add(1, 2);
    print("%\n", value);
}

Point :: struct {
    x: float;
    y: float;
}

Value :: union {
    i: int;
    f: float;
}

Color :: enum {
    RED;
    GREEN;
    BLUE;
}

Foo :: struct {
    name: string;
    count: int;
}

foo :: () {
    x := 10;
    y := 20;

    if x < y {
        print("less\n");
    } else {
        print("more\n");
    }

    for i: 0..10 {
        print("%\n", i);
    }
}

bar :: inline {
    print("inline\n");
}

baz :: #bake_arguments {
    print("baked\n");
}

qux :: (p: *Point) {
    p.x = 1.0;
    p.y = 2.0;
}

use_enum :: () {
    color := .RED;
    if color == .RED {
        print("red\n");
    }
}

use_notes :: () {
    @todo
    @cleanup
}

use_directives :: () {
    #assert 1 == 1;
}

data := Foo.{
    name = "Alice";
    count = 3;
};
