# lex demo
___

## lex

```bash
lex demo_1.lex

cc lex.yy.c

./a.out
```

___

### DFA

Turn of compression 

```bash
lex demo_1.lex -Cef
```

then look for `yy_nxt` and `yy_accept`

___

```c
yy_match:
   while ( (yy_current_state = yy_nxt[yy_current_state][yy_ec[(unsigned char)(*yy_cp)]]) > 0 )
       {
       if ( yy_accept[yy_current_state] )
           {
           yy_last_accepting_state = yy_current_state;
           yy_last_accepting_cpos = yy_cp;
           }

         yy_cp;
       }

   yy_current_state = -yy_current_state;
```

```c
static yyconst short yy_nxt[][8] =
    {
    {    0,    0,    0,    0,    0,    0,    0,    0    },
    {    3,    4,    5,    6,    7,    8,    9,   10    },
    {    3,    4,    5,    6,    7,    8,    9,   10    },
    {   -3,   -3,   -3,   -3,   -3,   -3,   -3,   -3    },
    {    3,   -4,   -4,   -4,   -4,   -4,   -4,   -4    },
    {    3,   -5,   -5,   -5,   -5,   -5,   -5,   -5    },
    {    3,   -6,   -6,   -6,   -6,   -6,   -6,   -6    },
    {    3,   -7,   -7,   -7,   -7,   -7,   -7,   -7    },
    {    3,   -8,   -8,   -8,   -8,   11,   -8,   -8    },
    {    3,   -9,   -9,   -9,   -9,   -9,   12,   -9    },
    {    3,  -10,  -10,  -10,  -10,  -10,  -10,  -10    },
    {    3,   13,   13,   14,   13,   13,   13,   13    },
    {    3,  -12,  -12,  -12,  -12,  -12,   12,  -12    },
    {    3,   13,   13,   14,   13,   13,   13,   13    },
    {    3,  -14,  -14,  -14,  -14,  -14,  -14,  -14    },
    } ;
```

```c
static yyconst short int yy_accept[15] =
    {   0,
        0,    0,    8,    6,    5,    5,    3,    3,    2,    4,
        0,    2,    0,    1
    } ;
```

How do we regexp the condition "at the same level of nesting"?

___

## bison

```bash
bison demo_2.y

cc cc -ly demo_2.tab.c 

./a.out
```
___

## bison + lex

```bash
lex demo_3.lex

bison -d demo_3.y

cc -ly lex.yy.c demo_3.tab.c

./a.out
```
___

### states print
```bash

lex demo_3.lex

bison -dt demo_3u.y

cc lex.yy.c demo_3.tab.c

./a.out

```
___

