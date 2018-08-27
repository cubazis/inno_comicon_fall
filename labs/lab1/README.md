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

## Objectives

Quiz:
- List stages of compilation and explain functions of each one
- Explain the difference between compilation & interpretation
- Give examples of the same syntax having different semantics and different syntax having the same semantics
___
Materials
- Define **token**, **pattern** and **lexeme**
- Given the description of allowed expressions, construct a valid grammar
- Given a grammar, determine validity of a sequence
- Given a grammar, build a parse tree for a sequence
- Given a programming language compilation scheme, determine how it is different from the overall scheme
- Given a compiler error, determine whether it was caught on the lexical analysis stage (invalid symbol) or further stages
- Prepare a plan of how they would implement a simple expression compiler

## Some introductory task here
1) Quiz (Cahoot)

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


### Coding

## Check yourself

## Rubrics

## Homework

### Expression calculator

### Extra tasks (optional)
Тут у меня чет поперли идеи того, за какие задания можно давать дополнительные баллы. Некоторые из них можно выполнять в команде, но при этом будет требоваться больший объем и уровень проработки
Можно например сделать по 1 бонусному баллу за каждое выполненное задание, и соответственно тот, кто делает что-то дополнительное каждую неделю, почти гарантированно бустит оценку на одну букву вверх, что вообще говоря звучит справедливо.

#### Artsy option
Имеется идея следующего плана: студент берет любой язык программирования на свой выбор, и делает материал на тему того, как устроен процесс компиляции данного языка.
Упомянуть надо:
- сколько проходов совершается,
- какие стадии выполняются на каждом из них,
- какие оптимизации на каком из проходов осуществляется
- на каком из проходов ловятся какие ошибки,
- что на входе и на выходе каждого.

Материал может быть:
- инфографикой
- нарисованным от руки плакатом
- гифкой или анимацией (в том числе интерактивной)
- хорошей видяшкой
- комиксом
- стихотворением
и т.д.

Основная суть --- это должен быть самостоятельный deliverable, понятный без рассказчика, который может быть просто куда-то залит.
За семестр можно опубликовать кучу таких deliverables на различные темы, у ребят будет галерея курса и материал для повторения

#### Industrial option
Есть множество open-source компиляторов, которые лежат, например, на гитхабе, и постоянно разрабатываются.
Задача состоит в том, чтобы в любом из них взять issue для новичков, сделать его, и добиться того, чтобы pull request приняли.
Принимается при наличии:
1. Ссылки на закрытый issue и вмерженный связанный pull request со своего гитхаб-аккаунта,
2. Небольшого отчета в свободной форме, хоть стихами, про то, что нового узнал, пока делал это issue. Главное, чтобы это тоже был сохраняемый deliverable

#### Teaching option
Взять определенную тему, и сделать небольшое активити для изучения и закрепления этой темы. Тема обговаривается с TA, далее, когда сделано активити, оно модерируется, и как только оно допущено и проведено, начисляются баллы.

## Reference