class Parcer:
    _EOI = 0
    _SEMI = 1
    _PLUS = 2
    _TIMES = 3
    _LP = 4
    _RP = 5
    _NUM = 6
    file = None
    current = ''
    input_string = ''
    iterator = 0
    parser_result = ''
    not_iterate = False

    def __init__(self, file_path):
        self.file = open(file_path, "r")
        self.input_string = self.file.readline()

    def lex(self):
        if self.current == '':
            try:
                self.current = self.input_string[self.iterator]
            except:
                return self._EOI
        while self.current == ' ':
            self.iterator += 1
            self.current = self.input_string[self.iterator]
        if self.current.isdigit():
            return self._NUM
        if self.current == ';':
            return self._SEMI
        elif self.current == '+':
            return self._PLUS
        elif self.current == '*':
            return self._TIMES
        elif self.current == '(':
            return self._LP
        elif self.current == ')':
            return self._RP

    def match(self, token):
        if token == self.lex():
            return True
        return False

    def advance(self):
        self.iterator += 1
        if self.iterator == len(self.input_string):
            self.current = ''
        else:
            self.current = self.input_string[self.iterator]
            if self.current.isdigit():
                while self.current.isdigit():
                    self.iterator += 1
                    self.current = self.input_string[self.iterator]
                self.iterator -= 1
                self.current = self.input_string[self.iterator]

    def expression(self):
        self.term()
        self.expr_prime()

    def term(self):
        self.factor()
        self.term_prime()

    def expr_prime(self):
        if self.match(self._PLUS):
            self.parser_result += "PLUS "
            self.advance()
            self.term()
            self.expr_prime()

    def term_prime(self):
        if self.match(self._TIMES):
            self.parser_result += "TIMES "
            self.advance()
            self.factor()
            self.term_prime()

    def factor(self):
        if self.match(self._NUM):
            self.parser_result += "NUM "
            self.advance()
        if self.match(self._LP):
            self.parser_result += "LP "
            self.advance()
            self.expression()
            self.parser_result += "RP "
            self.advance()

    def statements(self):
        self.expression()
        if self.match(self._SEMI):
            self.parser_result += "SEMI "
            self.advance()
        if not self.match(self._EOI):
            self.statements()
        else:
            self.parser_result += "EOF"
