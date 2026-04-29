
# comment

"a"
"a\"b"
'a'
'a\'b'
"""triple double"""
'''triple single'''

f"hello {name + 1}"
fr"\s+ {value}"
f"{foo(bar)}"
f"{items[0].name}"
f"foo {{ color: black; }}"
f"foo {{ color: black; }"

f"""
{ foo("") }
"""

@
@decorator
@decorator_name

#
#

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
123j

foo
foo()
foo(
foo.bar

None
True
False

int
float
bool
str
bytes
list
dict
set
tuple

x = 123
y = 0
z = 1.0e-3
w = 123j

def add(a, b):
    return a + b

async def fetch_user(user_id):
    return user_id

class Point:
    def __init__(self, x: float, y: float):
        self.x = x
        self.y = y

    def length(self):
        return (self.x ** 2 + self.y ** 2) ** 0.5

if True:
    print("hello")
else:
    print("nope")

for i in range(10):
    print(i)

while False:
    break

items = [1, 2, 3]
mapping = {"a": 1, "b": 2}
pair = (1, 2)
unique = {1, 2, 3}

result = add(1, 2)
value = mapping["a"]

a, _ = a, b

try:
    raise ValueError("x")
except ValueError as err:
    print(err)
finally:
    print("done")

with open("x.txt", "w") as f:
    f.write("hello")

lambda_fn = lambda x: x + 1

@decorator
def decorated():
    pass
    
x = """hello"""

def main():
    """
    This should be foldable.
    """
    
    return 0

