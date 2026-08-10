# Mojo lexer syntax test.
# Covers common language constructs and lexical edge cases.

from math import sqrt
from collections import List

# Comments
# Another comment with symbols: + - * / % == != <= >= ->

# Basic values

var integer: Int = 42
var negative = -17
var floating: Float64 = 3.1415926535
var scientific = 6.022e23
var small = 1.5e-9

var enabled = True
var disabled = False

var text = "Hello, Mojo!"
var empty = ""
var escaped = "quote: \"hello\""
var path = "/tmp/demo.txt"

# Basic expressions

var a = 10
var b = 3

var addition = a + b
var subtraction = a - b
var multiplication = a * b
var division = a / b
var remainder = a % b

var comparison1 = a == b
var comparison2 = a != b
var comparison3 = a < b
var comparison4 = a >= b

var logic = enabled and not disabled

# Conditional control flow

if a > b:
    print("a is larger")
elif a == b:
    print("equal")
else:
    print("b is larger")

# Loops

for i in range(10):
    if i == 3:
        continue

    if i == 8:
        break

    print(i)

var count = 0

while count < 5:
    count += 1

# Lists and indexing

var values = List[Int]()

values.append(10)
values.append(20)
values.append(30)

var first = values[0]

for value in values:
    print(value)

# Functions

def hello():
    print("hello")


def add(x: Int, y: Int) -> Int:
    return x + y


def multiply(value: Float64, factor: Float64 = 2.0) -> Float64:
    return value * factor


def describe(value: Int):
    if value > 0:
        print("positive")
    elif value < 0:
        print("negative")
    else:
        print("zero")


# Error-capable function

def checked_sqrt(value: Float64) raises -> Float64:
    if value < 0:
        raise "value cannot be negative"

    return sqrt(value)


# Error handling

def test_errors():
    try:
        var result = checked_sqrt(25.0)
        print(result)
    except error:
        print("error:", error)
    else:
        print("success")
    finally:
        print("finished")


# Compile-time parameters

def scale[factor: Int](value: Int) -> Int:
    return value * factor


def generic_identity[T](value: T) -> T:
    return value


def test_parameters():
    var doubled = scale[2](21)
    var tripled = scale[3](14)

    print(doubled)
    print(tripled)

    var int_value = generic_identity[Int](123)
    var string_value = generic_identity[String]("hello")

    print(int_value)
    print(string_value)


# Compile-time values

comptime default_size = 16
comptime name = "LexerTest"


# Structs

struct Point:
    var x: Float64
    var y: Float64

    def __init__(out self, x: Float64, y: Float64):
        self.x = x
        self.y = y

    def length(self) -> Float64:
        return sqrt(self.x * self.x + self.y * self.y)

    def translated(self, dx: Float64, dy: Float64) -> Point:
        return Point(self.x + dx, self.y + dy)


struct Counter:
    var value: Int

    def __init__(out self):
        self.value = 0

    def increment(mut self):
        self.value += 1

    def reset(mut self):
        self.value = 0


# Parameterized struct

struct Pair[T]:
    var first: T
    var second: T

    def __init__(out self, first: T, second: T):
        self.first = first
        self.second = second


# Traits

trait Printable:
    def print_value(self):
        ...


struct Message(Printable):
    var text: String

    def __init__(out self, text: String):
        self.text = text

    def print_value(self):
        print(self.text)


# Static method

struct MathHelpers:
    @staticmethod
    def square(value: Int) -> Int:
        return value * value


# Aliases

alias Index = Int
alias Real = Float64


# Ownership/reference-oriented argument forms

def inspect(borrowed value: String):
    print(value)


def update(mut value: Int):
    value += 1


def consume(owned value: String):
    print(value)


# Nested expressions

def calculation(x: Float64, y: Float64) -> Float64:
    var result = (
        x * x
        + y * y
        + 2.0 * x * y
    )

    return sqrt(result)


# Main

def main() raises:
    print("Mojo syntax test")

    hello()

    var sum = add(10, 20)
    print(sum)

    var p = Point(3.0, 4.0)
    print(p.length())

    var shifted = p.translated(1.0, -2.0)
    print(shifted.x, shifted.y)

    var counter = Counter()
    counter.increment()
    counter.increment()

    print(counter.value)

    var pair = Pair[Int](10, 20)
    print(pair.first, pair.second)

    var message = Message("trait implementation")
    message.print_value()

    print(MathHelpers.square(9))

    test_parameters()
    test_errors()

    var root = checked_sqrt(81.0)
    print(root)


