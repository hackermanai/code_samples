
// line comment
/* block comment */

"a"
"a\"b"

'a'
'\n'
'\"'

#
#include <stdio.h>
#define MAX_COUNT 128

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
123u
123UL
0xffu

foo
foo()
foo(1, 2)

int
char
float
double
void
size_t

true
false
NULL

int x;
char *s;
const char *name = "Alice";

struct Point {
    int x;
    int y;
};

union Value {
    int i;
    float f;
};

enum Color {
    RED,
    GREEN,
    BLUE,
};

typedef struct Point Point;

static int add(int a, int b) {
    return a + b;
}

int main(void) {
    Point p = {0, 1};
    int arr[3] = {1, 2, 3};

    if (p.x < p.y) {
        printf("%d\n", add(p.x, p.y));
    } else {
        puts("nope");
    }

    for (int i = 0; i < 10; i++) {
        arr[i % 3] += i;
    }

    return 0;
}
