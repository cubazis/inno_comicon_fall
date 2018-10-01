# "ComiCon" Lab session #4
## 01/10/2018
___

## Theory part

Answer:

|   | E | T | F | + | * | ( | ) | x | ⊢ |
| - | - | - | - | - | - | - | - | - | - |
| 1 |S2 |S5 |S8 |   |   |S9 |   |S12|   |
| 2 |   |   |   |S3 |   |   |   |   |   |
| 3 |   |S4 |S8 |   |   |S9 |   |S12|   |
| 4 |   |   |   |R1 |S6 |   |R1 |   |R1 |
| 5 |   |   |   |R2 |S6 |   |R2 |   |R2 |
| 6 |   |   |S7 |   |   |S9 |   |S12|   |
| 7 |   |   |   |R3 |R3 |   |R3 |   |R3 |
| 8 |   |   |   |R4 |R4 |   |R4 |   |R4 |
| 9 |S10|S5 |S8 |   |   |S9 |   |S12|   |
| 10|   |   |   |S3 |   |   |S11|   |   |
| 11|   |   |   |R5 |R5 |   |R5 |   |R5 |
| 12|   |   |   |R6 |R6 |   |R6 |   |R6 |

Question:

![GitHub](https://github.com/cubazis/inno_comicon_fall/blob/dev/imgs/7_1.jpg)


## Conflicts
[A Quick Introduction to Handling Conflicts in Yacc Parsers](https://www2.cs.arizona.edu/classes/cs453/fall14/DOCS/conflicts.pdf)

___

## Coding

Mkay. Let's have a try to parse Python. Lol. At first let's state the problem. I do not want to parse the entire python grammar. Why? Because.

[Python 2.5.2 grammar](https://docs.python.org/release/2.5.2/ref/grammar.txt)

Up to this point, we have been talking about fairly simple cases all the time. We parsed identifiers and brackets. 

What a disgrace! Now let it be related to classes and functions.

At this point it would be convinient to work with EBNF.

___

### Extended Backus–Naur form

| Usage   |   Notation |
|-|-|
| definition  |  = |
| concatenation   |   , |
| termination     | ; |
| alternation     | \| |
| optional    |    [ ... ] |
| repetition  |  { ... } |
| grouping    |    ( ... ) |
| terminal    | string " ... " |
| terminal    | string ' ... ' |
| comment     | (\* ... \*) |
| special     | sequence    ? ... ? |
| exception   |   - |

___

CLASS, COLON, COMMA, DEF, DOT, ID, LBRACE, MESSAGE, RBRACE, OTHER, STAR

### Token Set

Ok. If we talk about functions we need some...

**1 iter**

- DEF ~ `def`
- LBRACE ~`(`
- RBRACE ~ `)`
- COLON ~ `:` 

`func_def = DEF funcname LBRACE [func_args_list] RBRACE COLON suite`

**2 iter**

What is the `funcname`?

- ID ?

**3 iter**

What is the `func_args_list`?

- `[func_arg]`

**4 iter**
`dotted_name = ID {DOT ID}`
`star_arg = [STAR] STAR ID`

**5 iter**
`(dotted_name | star_arg) {OTHER | COMMA | dotted_name | star_arg | MESSAGE}`

**EBNF for Python functions:**

```
func_def = DEF funcname LBRACE [func_args_list] RBRACE COLON suite

funcname = ID

func_args_list = [func_arg]

func_arg = (dotted_name | star_arg) {OTHER | COMMA | 
dotted_name | star_arg | MESSAGE}

star_arg = [STAR] STAR ID
```

**EBNF for Python classes:**

```
class_def = CLASS classname [inheritance] COLON suite

classname = ID

inheritance = LBRACE class_args_list RBRACE

class_args_list = [class_arg]

class_arg = dotted_name {COMMA dotted_name}

dotted_name = ID {DOT ID}

```

**Tocken set**
`COLON, COMMA, DEF, DOT, ID, LBRACE, MESSAGE, RBRACE, OTHER, STAR`

Is this all we need?

What about `DEFINED` 
___

### Lex

- Ignore empty characters
- the flow of tokens is transferred to the bison
- yytext contains parsed pattern
- yylval contains parsed value (according pattern)

___

### Bison

- `demo.tab.h` contains lexeme macroses
- each lexeme has its own number starting from 257
- yyparse() function call

```
int main()
{
    return yyparse();
}
```
___

Let's have a try and...
```
1 ☭ CLASS: Foo()
2 ☭ CLASS: Test(Foo)
3 ☭ CLASS: Test2()
4 ☭ FUNC:  Test.Test2.__init__(self)
5 ☭ FUNC:  Test.Test2.foo()
```

We'll add a stack to which we will add the name of the current class. As soon as the definition of a function is encountered, we gradually remove the class names from the stack, concatenating with the function name. If a new class is found deeper in the level, we add it to the stack, otherwise we remove the elements from the stack until we reach the current level of nesting (and one more less), and add a new class to the stack.


```Добавляем имя текущего класса в стек. 

Если встречается определение функции то достаем из стека имя класса, конкатенируем с именем функции. 

Если встречается новый класс глубже по уровню то добавляем в стек.

Иначе удаляем из стека элементы, пока не дойдем до текущего уровня вложенности (и еще на единицу меньше), добавляем новый класс в стек
```
___

### Implementation

The problem is to know nesting level.
We need to contain indentation.

#### yylloc

- structure yylloc (first_line, first_column, last_line, last_column)

- use first_line for current line
- use last_column for indentation

```C=
extern YYLTYPE yylloc;
#define YY_USER_INIT yylloc.first_line = 1;

```

If get new line:

```C=
yylloc.first_line++;
yylloc.last_column = 0;
isNewLine = true;
```

If line starts with space:

```C=
if (isNewLine == true && 0 == yyleng % SPACES_PER_INDENT)
    yylloc.last_column = yyleng / SPACES_PER_INDENT;
isNewLine = false;
```

SPACES_PER_INDENT = 4
yyleng - length of lexeme

If line starts with tab:

```C=
if (isNewLine == true)
    yylloc.last_column = yyleng;
isNewLine = false;
```

Ignore long messages:

```C=
static string skipMessage(string _ch){
    string ch;
    string str = _ch;
    _ch = _ch[0];
    bool skip = false;
    int count = 1;
    for(;;ch = yyinput()) {
        str += ch;
        if (ch == _ch){
            if (count == 3)
                return str;
            else count++;
        } else
            count = 1;

        if ("\n" == ch || "\r" == ch)
            yylloc.first_line++;
    }
}
```

Ignore comments:

```C=
static void skipComments(){
    for(char ch = yyinput();;ch = yyinput()) {
        if ('\0' == ch || '\n' == ch || '\r' == ch) {
            yylloc.first_line++;
            break;
        }
    }
}
```

#### Stack

```C=

typedef pair <string, int> meta_data; 
typedef stack <meta_data> meta_stack;

static meta_stack class_st;

```

Put name of class and indentation in a stack:

```C=
class_def: CLASS classname inheritance COLON suite
    {
        int indent = @1.last_column; // получаем текущий отступ
        meta_data new_class($2, indent);

        clean_stack( class_st, indent );
        class_st.push( new_class );
    }
;
```

Clean stack

```C=
static void clean_stack( meta_stack& stack, int indent )
{
    while(!stack.empty())
    {
        if( indent > stack.top().second )
            break;
        stack.pop();
    }
}
```

Define full name of funcion
```C=
func_def: DEF funcname LBRACE func_args_list RBRACE COLON suite
  {
      string fnc_name = $2;
      int indent = @1.last_column;
      
      clean_stack( class_st, indent );
      meta_stack tmp_class_st(class_st);

      while (!tmp_class_st.empty())
      {
          fnc_name = tmp_class_st.top().first + "." + fnc_name;
          tmp_class_st.pop();
      }
  }
```