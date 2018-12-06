using System;

namespace src
{
    public class Parcer
    {
        public string ParcerResult;

        private string _input;
        private Token _lookahead;
        private int _yytext;
        private int _yyleng;

        public enum Token
        {
            INIT,
            EOI,
            SEMI,
            PLUS,
            TIMES,
            LP,
            RP,
            NUM,
            ERR
        }

        public Parcer(string input)
        {
            ParcerResult = "";
            _input = input;
            _lookahead = Token.INIT;
        }

        public Token Lex()
        {
            var current = _yytext + _yyleng;

            while (true)
            {
                if (current == _input.Length)
                    return Token.EOI;

                while (_input[current] == ' ' || _input[current] == '\n')
                {
                    current++;

                    if (current == _input.Length)
                        return Token.EOI;
                }

                for (; current < _input.Length; current++)
                {
                    _yytext = current;
                    _yyleng = 1;

                    switch (_input[current])
                    {
                        case ';': return Token.SEMI;
                        case '+': return Token.PLUS;
                        case '*': return Token.TIMES;
                        case '(': return Token.LP;
                        case ')': return Token.RP;

                        case '\r':
                        case '\n':
                        case '\t':
                        case ' ': break;

                        default:
                            if (char.IsDigit(_input[current]))
                            {
                                while (current < _input.Length && char.IsDigit(_input[current]))
                                    current++;

                                _yyleng = current - _yytext;

                                return Token.NUM;
                            }
                            else
                            {
                                Console.WriteLine("a");
                                Console.WriteLine("z" + _input[current] + "Z");
                                Console.WriteLine("b");
                                Console.ReadKey();
                                return Token.ERR;
                            }
                    }
                }
            }
        }

        private bool Match(Token token)
        {
            if (_lookahead == Token.INIT)
                Advance();

            return token == _lookahead;
        }

        private void Advance()
        {
            _lookahead = Lex();
        }

        private void Expression()
        {
            Term();
            ExprPrime();
        }

        private void Term()
        {
            Factor();
            TermPrime();
        }

        private void ExprPrime()
        {
            if (Match(Token.PLUS))
            {
                ParcerResult += "PLUS ";
                Advance();
                Term();
                ExprPrime();
            }
        }

        private void TermPrime()
        {
            if (Match(Token.TIMES))
            {
                ParcerResult += "TIMES ";
                Advance();
                Factor();
                TermPrime();
            }
        }

        private void Factor()
        {
            if (!Match(Token.LP))
            {
                ParcerResult += "NUM ";
                Advance();
            }
            else
            {
                ParcerResult += "LP ";
                Advance();
                Expression();
                ParcerResult += "RP ";
                Advance();
            }
        }

        public void Statements()
        {
            Expression();

            if (Match(Token.SEMI))
            {
                ParcerResult += "SEMI ";
                Advance();
            }

            if (!Match(Token.EOI))
            {
                Statements(); /* Do another statement. */
            }
            else
            {
                ParcerResult += "EOF";
            }
        }
    }
}