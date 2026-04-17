
//
//
/* a */
/+
+/

"a"
"a\"b"
r"raw string"
x"68656c6c6f"

'a'
'\n'

@
@safe
@nogc
@property

:
::
.

0
0.
0..1
0xFF
0b1010
1.0e-3
1_000_000

foo
foo()
foo(
foo.bar
foo.bar()
foo!int
foo!int()
foo!(int, string)

int
char
float
double
real
void
bool
size_t
string

true
false
null
_

const int x = 123;
auto y = 1.0e-3;
string s = "hello";

class Foo {
public:
    this() {
    }

    int add(int a, int b) {
        return a + b;
    }
}

struct Point {
    int x;
    int y;
}

union Value {
    int i;
    float f;
}

enum Color {
    Red,
    Green,
    Blue,
}

enum Mode {
    Read,
    Write,
}

template square(T) {
    T square(T x) {
        return x * x;
    }
}

mixin template Helper() {
    int twice(int x) {
        return x * 2;
    }
}

interface Drawable {
    void draw();
}

class Widget : Drawable {
    mixin Helper;

    override void draw() {
    }
}

alias IntArray = int[];
alias IntToString = string[int];

int add(int a, int b) {
    return a + b;
}

int sumRange(int a, int b) {
    int total = 0;
    foreach (i; a .. b) {
        total += i;
    }
    return total;
}

void nestedComments() {
    /+
        outer
        /+
            inner
        +/
    +/
}

void directives() @safe nothrow pure {
}

int main() {
    Point p = Point(0, 1);
    IntArray values = [1, 2, 3];

    if (p.x < p.y) {
        values ~= add(p.x, p.y);
    } else {
        values ~= 0;
    }

    foreach (v; values) {
        import std.stdio;
        writeln(v);
    }

    auto mode = Mode.Read;
    auto z = square!int(4);
    auto total = sumRange(0, 4);

    _ = z;
    _ = total;

    return 0;
}

