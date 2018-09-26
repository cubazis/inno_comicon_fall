# Week 6 Com i Con Lab

The first homework:
- the majority handed over the old lab, no one even corrected the date in the comments in the cap.
- most of the work is the same, even boring to read
- Add unnecessary files to the gitignore (out, bin, * .class, etc)
- Well done, most people write comments, many have a good readme.
- almost all managed with work
- always need to understand the pros and cons of this chosen approach, what we neglect and what assumptions we do.

Quiz:
almost all solved 1-2, no one solved 3. Repeat.


### The problem (LL(1) parse table, etc). 
We have a grammar, could we parse it with LL(x) and what x can be?
```
A → BwA
A → eps
B → CxB
B → yC
C → z
```
It isn’t left recursive, it is left factored already, and it is not obviously ambiguous. So the only way to definitively answer the question is to build the parsing table and check for conflicts. 

Link how to construct parse table, first, follow sets:
https://s3.amazonaws.com/content.udacity-data.com/courses/gt-cs6241/courseNotes/CourseNotesLesson+06.pdf

Below we show the grammar is LL(1), as the LL(1) parsing table
has at most one production per entry.
```
First( C) = {z}
First(B) = First( C) + y = {y,z}
First(A) = First(B) = {y,z} + \epsilon = {y,z,\epsilon}
Follow(A) = { $ }
Follow(B) = { w }
Follow( C) = { x,w }
```

| _ | w | x | y | z   | $  |
| - | - | - | - | -   | -  |
| A |   |   |BwA| BwA | eps|
| B |   |   |yC | CxB |    |
| C |   |   |   | z   |    |

### LALR(1) parse table, etc.

Suggest to read started from Syntax Analysis
https://web.cs.dal.ca/~sjackson/lalr1.html
