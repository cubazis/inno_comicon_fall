using Microsoft.VisualStudio.TestTools.UnitTesting;
using Token = src.Parcer.Token;
using src;

namespace tests
{
    [TestClass]
    public class ParcerTest
    {
        [TestMethod]
        public void TestLex0()
        {
            const string input = "";
            const Token pattern = Token.EOI;

            var result = new Parcer(input).Lex();

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestLex1()
        {
            const string input = ";";
            const Token pattern = Token.SEMI;

            var result = new Parcer(input).Lex();

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestLex2()
        {
            const string input = "+";
            const Token pattern = Token.PLUS;

            var result = new Parcer(input).Lex();

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestLex3()
        {
            const string input = "*";
            const Token pattern = Token.TIMES;

            var result = new Parcer(input).Lex();

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestLex4()
        {
            const string input = "(";
            const Token pattern = Token.LP;

            var result = new Parcer(input).Lex();

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestLex5()
        {
            const string input = ")";
            const Token pattern = Token.RP;

            var result = new Parcer(input).Lex();

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestLex6()
        {
            const string input = "0";
            const Token pattern = Token.NUM;

            var result = new Parcer(input).Lex();

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestLex7()
        {
            const string input = "123";
            const Token pattern = Token.NUM;

            var result = new Parcer(input).Lex();

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestLex8()
        {
            const string input = "023";
            const Token pattern = Token.NUM;

            var result = new Parcer(input).Lex();

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestParser0()
        {
            const string input = "0;";
            const string pattern = "NUM SEMI EOF";

            var parcer = new Parcer(input);
            parcer.Statements();
            var result = parcer.ParcerResult;

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestParser1()
        {
            const string input = "1+2;";
            const string pattern = "NUM PLUS NUM SEMI EOF";

            var parcer = new Parcer(input);
            parcer.Statements();
            var result = parcer.ParcerResult;

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestParser2()
        {
            const string input = "1+2; 1+2*3+2;\n1+3;";
            const string pattern = "NUM PLUS NUM SEMI NUM PLUS NUM TIMES NUM PLUS NUM SEMI NUM PLUS NUM SEMI EOF";

            var parcer = new Parcer(input);
            parcer.Statements();
            var result = parcer.ParcerResult;

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestParser3()
        {
            const string input = "1+2; 1+2*(3+2);\n1+3;";
            const string pattern = "NUM PLUS NUM SEMI NUM PLUS NUM TIMES LP NUM PLUS NUM RP SEMI NUM PLUS NUM SEMI EOF";

            var parcer = new Parcer(input);
            parcer.Statements();
            var result = parcer.ParcerResult;

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestParser4()
        {
            const string input = "123 + 96 + 5;\n12 * 13 + 1;\n12 * (3 + 7);\n0";
            const string pattern =
                "NUM PLUS NUM PLUS NUM SEMI NUM TIMES NUM PLUS NUM SEMI NUM TIMES LP NUM PLUS NUM RP SEMI NUM EOF";

            var parcer = new Parcer(input);
            parcer.Statements();
            var result = parcer.ParcerResult;

            Assert.AreEqual(pattern, result);
        }

        [TestMethod]
        public void TestParser5()
        {
            const string input = "123 + 12 * (96 + 5 + (12 * 13 + 1)) + (2 + 9);\n12 * (3 + 7);\n0";
            const string pattern =
                "NUM PLUS NUM TIMES LP NUM PLUS NUM PLUS LP NUM TIMES NUM PLUS NUM RP RP PLUS LP NUM PLUS NUM RP SEMI NUM TIMES LP NUM PLUS NUM RP SEMI NUM EOF";

            var parcer = new Parcer(input);
            parcer.Statements();
            var result = parcer.ParcerResult;

            Assert.AreEqual(pattern, result);
        }
    }
}