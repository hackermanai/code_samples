# Matrix computation demo for Mojo.
#
# Implements a small dense matrix type and a few numerical operations.
# Intended as a realistic syntax and editing demo rather than a full
# linear algebra library.

from collections import List
from math import sqrt
from time import now

struct Matrix:
    var rows: Int
    var cols: Int
    var data: List[Float64]

    def __init__(out self, rows: Int, cols: Int):
        self.rows = rows
        self.cols = cols
        self.data = List[Float64]()

        for _ in range(rows * cols):
            self.data.append(0.0)

    def __init__(
        out self,
        rows: Int,
        cols: Int,
        values: List[Float64],
    ):
        self.rows = rows
        self.cols = cols
        self.data = values

    def index(self, row: Int, col: Int) -> Int:
        return row * self.cols + col

    def get(self, row: Int, col: Int) -> Float64:
        return self.data[self.index(row, col)]

    def set(mut self, row: Int, col: Int, value: Float64):
        self.data[self.index(row, col)] = value

    def fill(mut self, value: Float64):
        for i in range(len(self.data)):
            self.data[i] = value

    def print_matrix(self):
        for row in range(self.rows):
            for col in range(self.cols):
                print(self.get(row, col), end=" ")

            print()

def identity(size: Int) -> Matrix:
    var result = Matrix(size, size)

    for i in range(size):
        result.set(i, i, 1.0)

    return result

def transpose(matrix: Matrix) -> Matrix:
    var result = Matrix(matrix.cols, matrix.rows)

    for row in range(matrix.rows):
        for col in range(matrix.cols):
            result.set(
                col,
                row,
                matrix.get(row, col),
            )

    return result

def add(a: Matrix, b: Matrix) raises -> Matrix:
    if a.rows != b.rows or a.cols != b.cols:
        raise "matrix dimensions must match"

    var result = Matrix(a.rows, a.cols)

    for row in range(a.rows):
        for col in range(a.cols):
            result.set(
                row,
                col,
                a.get(row, col) + b.get(row, col),
            )

    return result

def multiply(a: Matrix, b: Matrix) raises -> Matrix:
    if a.cols != b.rows:
        raise "incompatible matrix dimensions"

    var result = Matrix(a.rows, b.cols)

    for row in range(a.rows):
        for col in range(b.cols):
            var sum = 0.0

            for k in range(a.cols):
                sum += (
                    a.get(row, k)
                    * b.get(k, col)
                )

            result.set(row, col, sum)

    return result

def frobenius_norm(matrix: Matrix) -> Float64:
    var sum_squared = 0.0

    for value in matrix.data:
        sum_squared += value * value

    return sqrt(sum_squared)

def normalize(matrix: Matrix) raises -> Matrix:
    var norm = frobenius_norm(matrix)

    if norm == 0.0:
        raise "cannot normalize a zero matrix"

    var result = Matrix(matrix.rows, matrix.cols)

    for row in range(matrix.rows):
        for col in range(matrix.cols):
            result.set(
                row,
                col,
                matrix.get(row, col) / norm,
            )

    return result

def make_demo_matrix(size: Int, offset: Float64) -> Matrix:
    var result = Matrix(size, size)

    for row in range(size):
        for col in range(size):
            var value = (
                Float64(row + 1) * 0.25
                + Float64(col + 1) * 0.5
                + offset
            )

            result.set(row, col, value)

    return result

def checksum(matrix: Matrix) -> Float64:
    var result = 0.0

    for value in matrix.data:
        result += value

    return result

def run_small_demo() raises:
    print("Matrix A")

    var values = List[Float64]()

    values.append(1.0)
    values.append(2.0)
    values.append(3.0)

    values.append(4.0)
    values.append(5.0)
    values.append(6.0)

    values.append(7.0)
    values.append(8.0)
    values.append(9.0)

    var a = Matrix(3, 3, values)

    a.print_matrix()

    print("")
    print("Transpose")

    var at = transpose(a)
    at.print_matrix()

    print("")
    print("A * A^T")

    var product = multiply(a, at)
    product.print_matrix()

    print("")
    print("Frobenius norm:", frobenius_norm(product))

    var normalized = normalize(product)

    print("")
    print("Normalized")

    normalized.print_matrix()

def benchmark(size: Int, iterations: Int) raises:
    print("")
    print("Dense matrix benchmark")
    print("----------------------")

    print("Matrix size:", size, "x", size)
    print("Iterations:", iterations)

    var a = make_demo_matrix(size, 0.25)
    var b = make_demo_matrix(size, 1.75)

    var result = Matrix(size, size)

    var start = now()

    for iteration in range(iterations):
        result = multiply(a, b)

        # Change the input slightly so this represents
        # repeated numerical work rather than a fixed expression.
        if iteration % 2 == 0:
            a = transpose(a)

    var elapsed = now() - start

    print("")
    print("Elapsed:", elapsed)
    print("Checksum:", checksum(result))

def main() raises:
    print("Mojo Matrix Computation Demo")
    print("============================")

    run_small_demo()

    comptime matrix_size = 32
    comptime iterations = 20

    benchmark(
        matrix_size,
        iterations,
    )

