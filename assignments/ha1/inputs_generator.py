from random import randint


def expr(depth=0, size=0):
    return relation(depth, size)


def relation(depth, size):
    s = term(depth, size)
    b = randint(0, 9)  # 0 or 1 time:
    if b > 4:
        c = randint(0, 2)
        if c == 0:
            s += "<"
        elif c == 1:
            s += ">"
        else:
            s += "="
        s += term(depth, size + len(s))
    return s


def term(depth, size):
    s = factor(depth, size)
    b = randint(0, 5)  # 0 or more times, here is using to 5
    for i in range(b):
        c = randint(0, 1)
        if c == 0:
            s += "+"
        else:
            s += "-"
        s += factor(depth, size + len(s))
    return s


def factor(depth, size):
    s = primary(depth, size)
    b = randint(0, 3)  # 0 or more times, here is using to 3
    for i in range(b):
        s += "*"
        s += primary(depth, size + len(s))
    return s


def primary(depth, size):
    b = randint(0, 1)
    if b == 0 and depth < 5 and size < 20:  # limitation of recursion on depth and size
        return "(" + expr(depth + 1, size) + ")"
    return integer()


def integer():
    b = randint(0, 100)  # integer to 100
    return str(b)


def main():
    for i in range(100):  # 100 variants
        f = open("inputs/in" + str(i + 1) + ".txt", "w")
        b = randint(90, 110)
        for _ in range(b):
            f.write(expr())
            f.write("\n")
        f.close()


main()
