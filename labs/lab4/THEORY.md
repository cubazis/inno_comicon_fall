# Week 5 Com i Con Lab
This inscription is seen only for wizards and gifted ones :)
### Hello.
Who remembers what was on the last lab? ...
Any questions about the homework?

What is BNF and RBNF (BNF & EBNF)?
The Backus-Naur form; A formal system for describing the syntax in which some syntactic categories are sequentially defined through other categories. Used to describe the syntax of programming languages, data, protocols (for example, in RFC documents), etc. (both grammar and regular vocabulary, since regular grammars are a subset of context-free ones).
What is the difference between BPF and RBNF?
[A] - element A enters or does not enter (conditional occurrence)
{A} - zero or more elements of A (repetition)

### Top-down Parsing
When the parser starts constructing the parse tree from the start symbol and then tries to transform the start symbol to the input, it is called top-down parsing.

**Recursive descent parsing** : It is a common form of top-down parsing. It is called recursive as it uses recursive procedures to process the input. Recursive descent parsing suffers from backtracking.

**Backtracking** : It means, if one derivation of a production fails, the syntax analyzer restarts the process using different rules of same production. This technique may process the input string more than once to determine the right production.
![](https://i.imgur.com/HFr0E8x.png)


Way to get non-recursive predictive parser:
![](https://i.imgur.com/PrVbeAf.png)

LL - means parsing from *Left* to right performing *Leftmost* derivation of the sentence.
![](https://i.imgur.com/FBCeZBD.png)

#### leftmost and rightmost derivation
Example

Production rules:

E → E + E
E → E * E
E → id 
Input string: id + id * id

The left-most derivation is:

E → E * E
E → E + E * E
E → id + E * E
E → id + id * E
E → id + id * id
Notice that the left-most side non-terminal is always processed first.

The right-most derivation is:

E → E + E
E → E + E * E
E → E + E * id
E → E + id * id
E → id + id * id


**Task**. Parse ((i+i)+i) with grammar and LL parser: 
S -> E
E -> ( E + E )
E -> i

Answer:
S -> E -> (E+E) -> ((E+E)+E) -> ((i+E)+E) -> ((i+i)+E) -> ((i+i)+i)


### Bottom-up Parsing
As the name suggests, bottom-up parsing starts with the input symbols and tries to construct the parse tree up to the start symbol.
![](https://i.imgur.com/SqnMB3e.png)

Task. Parse a + b * c with grammar and LR parser:
S → E
E → E + T
E → E * T
E → T
T → id

Answer:
a + b * c
T + b * c
E + b * c
E + T * c
E * c
E * T
E
S

### unreachable rules elimination
Nothing difficult, just check if left side exist somewhere in right side.

### left factoring
Extract common part.
A -> bC | bD
transforms to:
A -> bE
E -> C|D

### ambiguity elimination
Rewrite grammar

### left recursion elimination
Apply rules for elimination

## TASKS:
1. left factoring: 
E -> T + E | T
T -> i | i * T | (E)
Answer:
E -> TX
X -> +E |e
T -> (E) | iY
Y -> * T|e
2. left factoring:
A -> abB | aB | cdg | cdeB | cdfB
Answer:
A -> aX | cdY
X -> bB | B
Y -> g|eB|fB
3. remove left recursion: 
A -> BC | DD
B -> b
C -> c
D -> b | AD
Answer:
first step: D -> b | bCD | DDD 
and then answer is:
D -> b | bCD | bZ | bCDZ
Z -> DDZ | DD
or: 
D -> bZ | bCDZ
Z -> DDZ | e
4. eliminate epsilon rules:
S -> S0|1|AB
B -> AC
A -> e
C -> e
Answer:
S -> S0|1|e
5. eliminate epsilon rules:
![](https://i.imgur.com/ciJlNUX.png)
