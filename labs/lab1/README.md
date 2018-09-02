# "ComiCon" Lab session #1
## 27/08/2018
___

### Lectures 1--2 summary
- 3 cornerstones of CS (databases, OSs & compilers)
- We want to make the course practical & useful
- The goal of compiler: overcoming semantic gap between human thinking and the way computer works
- Compilation vs interpretation
- Stages of compilation: Lexical analysis, Syntax analysis, Semantic analysis, IR generation, Object code generation, Object code linking
- Compiler front-end & back-end
- Compiler development technologies
- On what stages program optimization can be done

## Some introductory task here
Quiz (Cahoot)
___

## Objectives

Materials
- Define **token**, **pattern** and **lexeme**
- Given the description of allowed expressions, construct a valid grammar
- Given a grammar, determine validity of a sequence
- Given a grammar, build a parse tree for a sequence
- Given a programming language compilation scheme, determine how it is different from the overall scheme
- Given a compiler error, determine whether it was caught on the lexical analysis stage (invalid symbol) or further stages
- Prepare a plan of how they would implement a simple expression compiler


## Concepts --- Grammars; Lexical analysis
- What is lexical analysis
- Token, pattern, lexeme
- Recap on grammars
- Parse trees
- Parse tree vs. AST vs. tree-like IR

Compilers are complex programs. As a consequence, they're often broken into several distinct chunks, called passes, that communicate with one another via temporary files.

[Semantic gap](https://en.wikipedia.org/wiki/Semantic_gap)

*Structure of a Typical Four-Pass Compiler*
![Imgur](https://i.imgur.com/Bkmf0Fq.jpg)

___

A **phase** is an independent task used in the compilation process.

Typically, several phases are combined into a single pass.

The **lexical analyzer** phase of a compiler (called a **scanner** or **tokenizer**) translates the input into a form that's more useable by the rest of the compiler. 

The lexical analyzer looks at the input stream as a collection of basic language elements called **tokens**. Token is an indivisible lexical unit.

Lexemes are translated to tokens.
The original string that comprises the token is called a **lexeme**. 

Choosing a token set.
Too many tokens, however, can make the parser larger than necessary and difficult to write.


Scanner is self-contained unit.
The lexical analyzer is typically a self-contained unit that interfaces with the rest of the compiler via a small number (typically one or two) of subroutines and global variables. The parser calls the lexical-analyzer every time it needs a new token, and the analyzer returns that token and the associated lexeme. Since the actual input mechanism is hidden from the parser, you can modify or replace the lexical analyzer without affecting the rest of the compiler.
___

The Parser.
Consequently, a good deal of the theoretical side of the subject is borrowed from linguistics. One such concept is the idea of parsing.

Let's consider parsing of "*Alena see Ivan coding*"
- Sentence Diagram (or Syntax tree)
- Parse Tree

**Sentence** - collection of tokens that follow a well-defined grammatical structure.

A parser is a group of subroutines that converts a token stream into a parse tree, and a parse tree is a structural representation of the sentence being parsed. Looked at another way, the parse tree represents the sentence in a hierarchical fashion, moving from a general description of the sentence (at the root of the tree) down to the specific sentence being parsed (the actual tokens) at the leaves.

*Some compilers create a physical parse tree (later...)*
___

The Code Generator.
You can look at an intermediate language as a sort-of super assembly language that's designed for performing specific tasks (such as optimization).

There are **advantages** and **disadvantages** to an intermediate-language approach to compiler writing. The main disadvantage is *lack of speed*. A parser that goes straight from tokens to binary object code will be very fast, since an extra stage to process the intermediate code can often double the compile time. The advantages, however, are usually enough to justify the loss of speed. These are, in a nutshell, *optimization* and *flexibility*.

A single lexical-analyzer/parser front end can be used to generate code for several different machines by providing separate back ends that translate a common intermediate language to a machine-speci fie
assembly language.

Incremental compilers or interpreters. These programs shorten the development cycle by executing intermediate code directly, rather than translating it to binary first, thereby saving the time necessary for assembling and linking a real program. An interpreter can also give you an improved
debugging environment because it can check for things like out-of-bounds array indexing at run time.

___

Flow charts, [Warnier/Orr diagram](https://en.wikipedia.org/wiki/Warnier/Orr_diagram), and structure charts are examples of a design abstraction.

[Backus–Naur form](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_form)

A strict BNF representation starts with a set of tokens, called terminal symbols, and a set of definitions, called nonterminal symbols.

## Practice

### Grammars
**Task 1**
Consider the following grammar:
```
E -> SE | num
S -> -S | +S | ε
```
Here, `E` is the starting symbol, `S` and `E` are nonterminals, and terminals are `+`, `-`, `ε` and `num` where `num` represents any valid non-negative integer, and `ε` stands for empty symbol.
1. Describe how the sequences generated by this grammar would look like.
2. Give three examples of sequences which are valid by this grammar, all of different length
3. Now, give two examples of sequences which would not be valid
4. Now, which of these sequences are valid?
    a. `345`
    b. `--443-5`
    c. `-=++566`
    d. `-++--+0`
5. For those sequences which are valid, draw a parse tree
6. Write a regular expression for this grammar
 
**Task 2**
Here is a list of keywords which can be used in valid variable declarations in C:
 
| `int` | `char` | `long` | `float` | `double` | `signed` | `unsigned` |
| -------- | -------- | -------- | ------ | ------ | ----- | --- |
| **`short`**    | **`const`**    | **`volatile`**    |  **`register`** | **`static`** |  **`extern`** |

1. Write a grammar that recognizes valid C variable names
    - only ASCII letters, digits and underscores can be used
    - the first symbol of the name can't be a number
2. Write a grammar that recognizes a variable declaration made of any number of keywords above and a variable name
3. \* Modify the grammar from the previous question in such a way that it only recognizes valid declarations. Check the validity of your grammar trying out different declaration lines both with it and using C compiler.
4. \** Modify your grammar from the previous question so that it accepts all valid combinations of stars, brackets, parentheses, keywords and names are recognized. Check with a compiler.
5. \** Now, for all grammars you have created in this task, write regular expressions.
6. \* Finally, switch your grammars and try to find mistakes in each other's solutions

**Task 3**
Write a grammar (and a recursive-descent compiler for that grammar) that translates an English description of a C variable into a C-style variable declaration. For example, the input:
```
x is a pointer to an array of 10 pointers to functions that return int.
y is an array of 10 floats.  
z is a pointer to a struct of type a_struct.
```
should be translated to:
```clike=
int     (*(*x)[10])();
float   y[10];  
struct  a_struct *z;
```
___

## Coding

### Stage one. Repentance.

First, let me apologize (as usual at our university) for the inconvenience. lol.

It was assumed that the first lab session we have an interactive code practive. That is why such things as the names of the service variables for implementing the lexical analyzer (*yytext*; *yyleng*; *yylineno*) were incomprehensible to you. 

Soryan. Now we will fix it.
___

### Stage two. Lab session *key goals*.

The first **purpose** of lab session is the implementation of a lexical analyzer and parser bundle for a simple grammar. There are various modifications of this bundle. We will try to implement a concept based on **Recursive-Descent**. Grammar involves simple operations of *multiplication* and *addition*, as well as the presence of *numerical* and *alphabetic* lexemes. The second **purpose** of lab session is to develop your habit of test-driven development (TDD). 

The parser is kind of recognizer program. If it terminate without an error, the input sentence is a legal sentence in the grammar. So the parser+lexical analyzer bundle is an automata for legal input sentences.

The **lexical analyzer** is typically a self-contained unit that interfaces with the rest of the compiler via a small number (typically one or two) of subroutines and global variables.

A **parser** is a group of subroutines that converts a token stream into a parse tree, and a parse tree is a structural representation of the sentence being parsed.
___

### Stage three. How to do wrong.

Let's take a simple example.

The BNF grammar below that recognizes a list of one or more statements, each of which is an arithmetic expression followed by a semicolon. Statements are made up of a series of semicolon-delimited expressions, each comprising a series of numbers separated either by asterisks (for multiplication) or plus signs (for addition).

#### BNF Grammar v1.0

![GitHub](https://github.com/cubazis/inno_comicon_fall/blob/dev/imgs/1_5.jpg)

This grammar is recursive. It's not hard to notice. When parsing a sentence corresponding to this grammar, a lookahead mechanism is used. 

To understand what it's about, look at the last line. Here is a choice between two alternatives when expanding a *factor*. The parser can choose which alternative to apply by looking at the next input symbol. If this symbol is a number, then the compiler applies left alternative and replaces the *factor* with a **number**. If the next input symbol was an open parenthesis, the parser would use *( expression )*.

The problem of this grammar lies in the third line. 

Here the compiler can not cope with the choice of the alternative and a **conflict** arises.

___
- **Task 1: think and try to answer what is the conflict arises**
___

I believe that you have mastered the understanding of the conflict. Now we can move on to a more pumped-up version of the grammar that meets the requirements of our task.
___

### Stage four. How to do it right.

First we confine ourselves to the case when there are only numbers, and we will try to describe the set of tokens. 

A token is an input symbol taken as a unit, a lexeme is the string that represents that symbol. 

The tokens are defined with the macros at the top of *parcer.h* file.

```c
#define _EOI           0		/*  end of input (EOF signal typically) */
#define _SEMI          1		/*       ;                              */
#define _PLUS          2		/*       +                              */
#define _TIMES         3		/*       *                              */
#define _LP            4		/*       (                              */
#define _RP            5		/*       )                              */
#define _NUM           6		/* decimal number                       */
```
The **_NUM** token is used both for numbers so, they are made up of a series of contiguous characters in the range *'0'-'9'*. The lexical analyzer translates a semicolon into a **_SEMI** token, a series of digits into a **_NUM** and so on. 
___

Now when we have a set of tokens, we'll try to compose the Grammar and the corresponding Syntax Diagrams.

#### BNF Grammar v2.0

![GitHub](https://github.com/cubazis/inno_comicon_fall/blob/dev/imgs/1_6.jpg)

Don't be afraid of ⊢ symbol. It's just the end of input. Usually it's an EOF signal in a system ([tty](https://en.wikipedia.org/wiki/Tty_(unix))).

*To my taste it's better to explicitly indicate that at the level of abstraction of the machine we stop reading the intup stream by using ⊢ symbol. But canonically in the BNF you will not see this.*

#### Syntax Diagram
![GitHub](https://github.com/cubazis/inno_comicon_fall/blob/dev/imgs/1_1.jpg)

How it works. Let's consider parser Syntax Tree and  Subroutine Trace for **1 + 2** expression.

#### Syntax Tree
![GitHub](https://github.com/cubazis/inno_comicon_fall/blob/dev/imgs/1_4.jpg)

#### Subroutine Trace
![GitHub](https://github.com/cubazis/inno_comicon_fall/blob/dev/imgs/1_3.jpg)

In context of Subroutine Trace *statements*, *expression*, *term*, *expr_prime*, *factor*, *term_prime* etc. are calls of implemented functions.

*P.S. prime suffix means <'> in Grammar:
*expression'* is the same as **void expr_prime()** in code template. Please be careful.*

___

### Stage five. In code we trust.

The are three variables at top of *parcer.h* are used by the lexical analyzer to pass information to the parser:

- *yytext* points at the current lexeme, which is not '\0' terminated;
- *yyleng* is the number of characters in the lexeme;
- *yylineno* is the current input line number.

The lexical analyzer is already implemented. The idea is to realize its code and test it! You can never be sure that the instructor gives you a suitable material, so test the *lex()* function by using *test_parser.c* test suite structure. Let me help you and start with simple *test_lex_0* test:

```c=
START_TEST (test_lex_0)
{
	char* input = "";
	char* pattern = 0;
	file = fmemopen(input, strlen(input), "r");

	int res = (int)lex();
	
	printf("%d\n", res);
	ck_assert_int_eq(res, pattern);
}
END_TEST
```
**lex()** function returns the number from the tokens set, determined in *lex.h* file.

You see that the *input* is an empty string. In our grammar it's an ϵ element. So, this is permissible value. 

As mentioned above, this means that the sentence consists only of an empty character and the machine recognizes this as the end of the input ⊢, and return **0** value according to **_EOI** from the token set.

___
- **Task 2: test *lex()* by adding tests in test_parcer.c. Start from 30 line.**
___

P.S. 

lex() implemented in terms of FILE descriptor processing, because we want to check it not only in a test suite, but *demo.c* too. So that's why I had to use special function

```c=
FILE *fmemopen (void *bf, size_t size, const char *mode)
```
This functions implemented for GNU C Compilers only. If you use it, delete my implementation, and use GNU implementation from *stdio.h*

P.P.S. As you can see too specific parser internal entities have been used:
```c=
/** parser internal entity to process the input stream */
FILE * file;
/** parser internal entity to provide parsing result*/
char parser_result[1000];
```
this was done to enable the testing of architecture.
___

### Stage six. Lab session practice.

Now you know how the *lex()* works. What about parser?

I've implemented several *entry concepts* for you.

As you can see I provided all of the functions declarations in *parser.h* and their definition templates in *parcer.c*. 

Several functions are already implemented. 

#### Lookahead concept
___
- **Task 3: I offer you to realize the concept of Looking ahead and token matching by using this canonical implementation. Try to explain the advantages and disadvantages of this approach**
___

```c=
static int Lookahead = -1;      /* Lookahead token  */

int match(int token )
{
	/* Return true if "token" matches the current lookahead symbol. */

	if( Lookahead == -1 )
		Lookahead = (int) lex();

	return token == Lookahead;
}

void advance()
{
	/* Advance the lookahead to the next input symbol.  */

	Lookahead = (int) lex();
}
```
#### Grammar functions implementation
___
- **Task 4: Implement and tnext functions:**
```c=
void term();

void expr_prime();

void factor();

void term_prime();
```
___

Before doing this, carefully study the approach I used to generate the output value in *parser_result*. 

I used adding the TOKEN name with one space to *parser_result* variable. 
```c=
strcat(parser_result, "TOKEN ");
```

The idea is to check equality of *parser_result* value and *pattern* value.

```c=
START_TEST (test_parser_0)
{
	char* input = ";";
	char* pattern = "SEMI EOF";
	file = fmemopen(input, strlen(input), "r");
	statements();
	printf("%s\n", parser_result);
	ck_assert_str_eq(parser_result, pattern);
	fclose(file);
}
END_TEST
```
*P.S. Be careful **EOF** token added without space.*

___

- **Task 5: Read the contents of the file *demo.c* and verify its functionality**

This file process an input string from *in.txt* file and generate *out.txt* file.

Use these commands in your shell:
```bash=
> c99 demo.c src/parcer.c

> ./a.out
```

and check *out.txt* file contents.
___


## Homework
**Expression calculator**

[Assignment 1](assignments/ha1/ha1.pdf)

___

### Thank you