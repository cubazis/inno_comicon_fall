# &$%^@ language C Interpreter
___

### Architecture

- main.c

- common.h

- chunk.c (dynamic array of instructions)
- PROS
  - Cache-friendly, dense storage.
  - Constant-time indexed element lookup.
  - Constant-time appending to the end of the array.

- METHODS
  - Allocate a new array with more capacity.
  - Copy the existing elements from the old array to the new one.
  - Store the new capacity.
  - Delete the old array.
  - Update code to point to the new array.
  - Store the element in the new array now that there is room.
  - Update the count.

- memory.c
___

*now we have simple tool for building chunks of instructions*

```c=
  Chunk chunk;                          
  initChunk(&chunk);                    
  writeChunk(&chunk, OP_RETURN);        
  freeChunk(&chunk); 
```

*disassembler*

```c=
  Chunk chunk;                          
  initChunk(&chunk);                    
  writeChunk(&chunk, OP_RETURN);
  disassembleChunk(&chunk, "test chunk");        
  freeChunk(&chunk); 
```

- debug.h
- debug.c

```
== test chunk ==
0000 OP_RETURN
```
___

*what about values?*

- value.h
  - immediate instructions
  - [constant pool](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.4)
  - arrays
  - constants (execution?)
  
```c
initChunk(&chunk); 

int constant = addConstant(&chunk, 1.2);
writeChunk(&chunk, OP_CONSTANT);        
writeChunk(&chunk, constant);

writeChunk(&chunk, OP_RETURN);
```
___

*LINE INFORMATION*

```
int constant = addConstant(&chunk, 1.2);

writeChunk(&chunk, OP_CONSTANT, 123);   
writeChunk(&chunk, constant, 123);
writeChunk(&chunk, OP_RETURN, 123); 

disassembleChunk(&chunk, "test chunk"); 
```

```
== test chunk ==
0000  123 OP_CONSTANT         0 '1.2'
0002    | OP_RETURN
```

___

### Lexical Grammar
```
NUMBER         → DIGIT+ ( "." DIGIT+ )? ;
STRING         → '"' <any char except '"'>* '"' ;
IDENTIFIER     → ALPHA ( ALPHA | DIGIT )* ;
ALPHA          → 'a' ... 'z' | 'A' ... 'Z' | '_' ;
DIGIT          → '0' ... '9' ;
```
___

### Syntax Grammar

```
program        → declaration* EOF ;
```

#### declaration

```
declaration    → classDecl
               | funDecl
               | varDecl
               | statement ;

classDecl      → "class" IDENTIFIER ( "<" IDENTIFIER )?
                 "{" function* "}" ;
funDecl        → "fun" function ;
varDecl        → "var" IDENTIFIER ( "=" expression )? ";" ;
```

#### statement

```
statement      → exprStmt
               | forStmt
               | ifStmt
               | printStmt
               | returnStmt
               | whileStmt
               | block ;

exprStmt       → expression ";" ;
forStmt        → "for" "(" ( varDecl | exprStmt | ";" )
                           expression? ";"
                           expression? ")" statement ;
ifStmt         → "if" "(" expression ")" statement ( "else" statement )? ;
printStmt      → "print" expression ";" ;
returnStmt     → "return" expression? ";" ;
whileStmt      → "while" "(" expression ")" statement ;
block          → "{" declaration* "}" ;
```

#### expression

```
expression     → assignment ;

assignment     → ( call "." )? IDENTIFIER "=" assignment
               | logic_or;

logic_or       → logic_and ( "or" logic_and )* ;
logic_and      → equality ( "and" equality )* ;
equality       → comparison ( ( "!=" | "==" ) comparison )* ;
comparison     → addition ( ( ">" | ">=" | "<" | "<=" ) addition )* ;
addition       → multiplication ( ( "-" | "+" ) multiplication )* ;
multiplication → unary ( ( "/" | "*" ) unary )* ;

unary          → ( "!" | "-" ) unary | call ;
call           → primary ( "(" arguments? ")" | "." IDENTIFIER )* ;
primary        → "true" | "false" | "nil" | "this"
               | NUMBER | STRING | IDENTIFIER | "(" expression ")"
               | "super" "." IDENTIFIER ;
```

#### Helper rules

```           
function       → IDENTIFIER "(" parameters? ")" block ;
parameters     → IDENTIFIER ( "," IDENTIFIER )* ;
arguments      → expression ( "," expression )* ;
```

___