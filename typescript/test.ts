
#!/usr/bin/env node

// line comment
/* block comment */

"a"
"a\"b"
'c'
'\n'
`template`
`value = ${1 + 2}`

"unterminated
'also unterminated
`template ${1 + 2`

?.
!.
...
=>

0
0.
0xFF
0b1010
0o755
1.0e-3
123n

foo
foo(
foo<number>
foo<number>()
foo.bar
foo?.bar
foo!.bar

x: number
y = 123

type ID = number | string;
type Range = number | bigint;
type Pair<T> = [T, T];

interface PointLike {
    x: number;
    y: number;
}

interface Named {
    name: string;
}

type Printable = {
    print(): void;
};

enum Color {
    Red,
    Green,
    Blue,
}

const enum Mode {
    Read,
    Write,
}

class Point implements PointLike {
    x: number;
    y: number;

    constructor(x: number, y: number) {
        this.x = x;
        this.y = y;
    }

    lengthSquared(): number {
        return this.x * this.x + this.y * this.y;
    }
}

class Foo extends Point implements Named {
    name: string;
    count: number;

    constructor(name: string, count: number, x: number, y: number) {
        super(x, y);
        this.name = name;
        this.count = count;
    }
}

type Value =
    | { kind: "int"; i: number }
    | { kind: "float"; f: number };

function add(a: number, b: number): number {
    return a + b;
}

const square = (x: number): number => {
    return x * x;
};

function identity<T>(value: T): T {
    return value;
}

function pair<T>(a: T, b: T): Pair<T> {
    return [a, b];
}

function useGenerics(): void {
    const a = identity<number>(123);
    const b = pair<string>("a", "b");
    console.log(a, b);
}

function useArrays(): void {
    const xs: number[] = [1, 2, 3];
    const ys: Array<string> = ["a", "b"];
    const zs = xs.map(x => x * 2).filter(x => x > 2);
    console.log(xs, ys, zs);
}

function useObjectTypes(): void {
    const data: Foo = new Foo("Alice", 3, 1.0, 2.0);
    const p: PointLike = { x: 1, y: 2 };
    console.log(data.name, data.count, p.x, p.y);
}

function useEnums(): void {
    const color: Color = Color.Red;
    const mode: Mode = Mode.Read;

    if (color === Color.Red) {
        console.log("red");
    }

    if (mode === Mode.Read) {
        console.log("read");
    }
}

function useSpecialSyntax(obj?: Foo | null): void {
    const count = obj?.count ?? 0;
    const sure = obj!.name;
    const ok = count satisfies number;
    console.log(sure, ok);
}

type Result<T> = T extends string ? "text" : "other";
type NameOf<T> = keyof T;
type Inner<T> = T extends Array<infer U> ? U : never;

function useTypes(): void {
    type A = Result<string>;
    type B = NameOf<Foo>;
    type C = Inner<number[]>;
    const _a: A = "text";
    const _b: B = "name";
    const _c: C = 123;
    console.log(_a, _b, _c);
}

declare function externalLog(msg: string): void;

namespace Demo {
    export const version: string = "1.0";

    export function print(msg: string): void {
        console.log(msg);
    }
}

abstract class Shape {
    abstract area(): number;
}

class Rect extends Shape {
    constructor(
        public width: number,
        public height: number,
    ) {
        super();
    }

    override area(): number {
        return this.width * this.height;
    }
}

class Counter {
    #value = 0;

    increment(): void {
        this.#value++;
    }

    get value(): number {
        return this.#value;
    }
}

function useControlFlow(x: number, y: number): void {
    if (x < y) {
        console.log("less");
    } else {
        console.log("more");
    }

    for (let i = 0; i < 10; i++) {
        console.log(i);
    }

    for (const v of [1, 2, 3]) {
        console.log(v);
    }

    while (x < y) {
        x++;
    }

    switch (x) {
        case 0:
            console.log("zero");
            break;
        default:
            console.log("other");
            break;
    }
}

function useBuiltins(): void {
    console.log("hello");
    Math.max(1, 2, 3);
    JSON.stringify({ ok: true });
    parseInt("123", 10);
}

const data = {
    name: "Alice",
    count: 3,
} as const;

const point = new Point(1.0, 2.0);
const fooValue = new Foo("Bob", 2, 3.0, 4.0);
const values: readonly number[] = [1, 2, 3];
const tuple: [number, string] = [1, "a"];

useArrays();
useObjectTypes();
useEnums();
useGenerics();
useTypes();
useControlFlow(1, 2);
useBuiltins();
Demo.print("done");
externalLog("finished");

// incomplete / error cases
const brokenObject = {
    name: "Alice",
    count: 3,

function brokenFunction(x: number, y: number): number {
    return x + y;

const brokenCall = add(1, 2;
const brokenGeneric = identity<string("oops");
const brokenArray: number[] = [1, 2, 3;
const brokenTemplate = `hello ${point.x`;

