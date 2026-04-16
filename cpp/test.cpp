
//
//
/*a*/

"a"
"a\"b"

'a'
'\n'

#
#include <vector>
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

foo
foo()
foo(
foo::
foo::bar
foo::bar()
foo<int>
foo<int>()

int
char
float
double
void
bool
size_t
std

true
false
nullptr

const int x = 123;
auto y = 1.0e-3;
std::string s = "hello";

class Foo {
public:
    Foo() = default;

    int add(int a, int b) {
        return a + b;
    }
};

struct Point {
    int x;
    int y;
};

union Value {
    int i;
    float f;
};

enum Color {
    Red,
    Green,
    Blue,
};

enum class Mode {
    Read,
    Write,
};

template <typename T>
T square(T x) {
    return x * x;
}

namespace demo {
    inline int sub(int a, int b) {
        return a - b;
    }
}

using IntVec = std::vector<int>;
using namespace std;

int add(int a, int b) {
    return a + b;
}

int main() {
    Point p{0, 1};
    IntVec values{1, 2, 3};

    if (p.x < p.y) {
        values.push_back(add(p.x, p.y));
    } else {
        values.push_back(0);
    }

    for (const auto &v : values) {
        std::cout << v << "\n";
    }

    auto mode = Mode::Read;
    auto z = square(4);

    return 0;
}
