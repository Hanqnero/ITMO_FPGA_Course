from itertools import product


f1 = lambda a, b, c: int((a != b) or c)
f2 = lambda a, b, c: int(a != c)
f3 = lambda a, b, c: int(b or f1(a, b, c))
f4 = lambda a, b, c: int(f1(a, b, c) and f2(a, b, c) and f3(a, b, c))
f5 = lambda a, b, c: int(a or b or c)
f6 = lambda a, b, c: int((a != (not b)) or c)
f7 = lambda a, b, c: int(a and b and c)
f8 = lambda a, b, c: int(c)

fs = [eval(f"f{i}") for i in range(1, 9)]

for i, (a, b, c) in enumerate(product((0, 1), repeat=3)):
    print(f"{'A' if a else '-'}{'B' if b else '-'}{'C' if c else '-'}", end="\t")
    for f in reversed(fs):
        print(f(a, b, c), end="")
    print()

print("\n")

for i in range(1, 9):
    f = fs[i - 1]
    print(f"F{i}", end="\t")
    for a, b, c in product((0, 1), repeat=3):
        print(f(a, b, c), end="")
    print()
