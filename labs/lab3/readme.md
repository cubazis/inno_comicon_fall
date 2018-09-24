# Week 4 Com i Con Lab
This inscription is seen only by wizards :)
### Hello.
Who remembers what was on the last lab? ...
Today there will be less problems and easier.
Who tried to struggle with context-dependent? a ^ n b ^ n c ^ n (n> = 1)
Answer:
S-> aSBC
S-> aBC
CB-> BC
aB-> ab
bB-> bb
bC-> bc
cC-> cc

### The lex program (flex)
As you know, this compiler generates a lexical analyzer. How to use it is understandable.
Conflict resolution. If several prefixes correspond to one or more templates, then
1) Preference is given to a longer prefix (the <= sign is one lexeme)
2) If the largest prefix corresponds to two or more patterns, the first preference is given. (this makes the keywords reserved, for example, if the template for then is defined before the {id} template)


### Once again about the regulars and machines
Why regulars and automata are used when there are grammars? Visibility, convenience, their use in different programs. What kind of automata exists? Deterministic and nondeterministic. What is the difference? OK. We will not dwell on them, you seemed to be going through, and there is nothing specific there.

### Two words about errors.
How many characters we should look to be able to cope with errors. 
What are the options for dealing with errors for a lexical analyzer?
- skip until we find further development
- local (replacement of one symbol) and global (replacement of the whole phrase) correction
- generation of additional grammar rules for errors

### Continuation of grammars. Get rid of the left recursion.
It is important to verify that the conditions for a deterministic algorithm are satisfied. This is due to other things that in an expression of the form:
term 0 | term 1
The terms must not feature any common start symbols.
For the next grammar, we recognize that the requirement is violated, simply because the is the start symbol of A (b IN first (A)), and because it is the first ("a") and the first ("b") are not disjoint. "b" is the common element.
A -> Aa | b
Answer:
A -> bA '
A '-> aA' | e
This is the general scheme for getting rid of left recursion.
![](https://i.imgur.com/xG3NIOl.png)

##### Task1. Remove left recursion
E -> E + T | T
T -> T * F | F
F -> (E) | id

Answer:
E -> T E '
E '-> + TE' | e
T -> FT '
T '-> * FT' | e
F -> (E) | id

##### Task2. Remove left recursion
S -> Aa | b
A -> Ac | Sd | e
What is the feature of this grammar? The nonterminal S is left-recursive, but the recursion S-> Aa-> Sda is not immediate. The above algorithm is guaranteed to work only with grammars without cycles and e-products. Cycles and e-products can be removed by the following algorithms.
But here e does not interfere. Therefore:
A -> Ac | Aad | bd | e
A -> bdA '| A '
A '-> cA' | adA '| e

### Left Factorization
Left factorization is the transformation of a grammar into a suitable predicate (descending) syntactic analysis. When the choice of two alternatives is unclear, the choice can be postponed.
For example.
A -> BC | BD
Left factorization:
A -> BA '
A '-> C | D

##### Task1. Factorize
S -> if E then S | if E then S else S | a
E -> b
Answer:
S -> if E then S S '| a
S '-> else S | e
E -> b
Of course, both grammars are ambiguous and if else is found, it is unclear which of the alternatives for S should be chosen, but that's another story.

##### Task2. Factorize
Rexpr -> Rexpr + Rterm | Rterm
Rterm -> Rterm Rfactor | Rfactor
Rfactor -> Rfactor * | Rprimary
Rprimary -> a | b
Answer:
Too lazy to solve. Let them solve.

Is it suitable after left factorization and elimination of left recursion for top-down parsing?

### Top-down parsing
It can be considered as the task of constructing a parse tree for the input string (bypassing in depth)
For id + id * id and:

![](https://i.imgur.com/fVaL4Ci.png)
We get:
![](https://i.imgur.com/dzEub5D.png)



### Bottom up parsing:

Once again, we demonstrate the process with the example of simple expressions. Let the syntax be as follows:

![](https://i.imgur.com/AIsAmum.png)

and let the sentence to be recognized be x * (y + z). In order to display the process, the remaining source text is shown to the right, whereas to the left the - initially empty - sequence of recognized constructs is listed. At the far left, the letters S and R indicate the kind of step taken
![](https://i.imgur.com/ENZMfwX.png)

At the end, the initial source text is reduced to the start symbol E, which here would better be called the stop symbol. As mentioned earlier, the intermediate store to the left is a stack.

## Top down parsing
In analogy to this representation, the process of parsing the same input according to the top-down principle is shown below. The two kinds of steps are denoted by M (match) and P (produce, expand). The start symbol is E.
![](https://i.imgur.com/c6Riaxk.png)

Evidently, in the bottom-up method the sequence of symbols read is always reduced at its right end, whereas in the top-down method it is always the leftmost nonterminal symbol which is expanded. According to Knuth the bottom-up method is therefore called LR-parsing, and the top-down method LL-parsing. The first L expresses the fact that the text is being read from left to right. Usually, this denotation is given a parameter k (LL(k), LR(k)). It indicates the extent of the lookahead being used. We will always implicitly assume k = 1.



