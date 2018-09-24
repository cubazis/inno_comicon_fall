# "ComiCon" Lab session #4
## 24/09/2018
___

## Нисходящий синтаксический анализ (НСА)

Методы нисходящего более интуитивны чем методы восходящего.

Для восходящего разработано больше инструментальных средств.

Применение восходящего более широко чем нисходящего.

- Критерии принятия решений при нисходящем синтаксическом анализе
- КС грамматики, на которых может основываться нисходящий синтаксический анализ
- Простые методы создания НСА
- Преобразование грамматики в форму подходящую для НСА
- Преимущества и недостатки НСА
- КС грамматики как основа процессов времени компиляции
___

Вычисляем множества первых порождаемых символов. Проверяем множества на предмет пересечения. 
$LL(1) - грамматика$ - грамматика в которой для каждого нетерминала, появляющегося в левой части нескольких продукций, множества первых порождаемых символов всех продукций, в которых появляется этот нетерминал, являются непересекающимися.

$S \rightarrow Ty$
$T \rightarrow AB$
$T \rightarrow sT$
$A \rightarrow aA$
$A \rightarrow \epsilon$
$B \rightarrow bB$
$B \rightarrow \epsilon$


$T \rightarrow AB$, $\{a, b, y\}$
$T \rightarrow sT$, $\{s\}$
$A \rightarrow aA$, $\{a\}$
$A \rightarrow \epsilon$, $\{b,y\}$
$B \rightarrow bB$, $\{b\}$
$B \rightarrow \epsilon$, $\{y\}$

Недетерминированный НСА на основе отката (backtracking) не считается эффективной процедурой.

$LL(k)$ так же не считаются практичными с точки зрения синтаксичского анализа.
___

$LL(1) - язык $  - тот что может быть сгенерирован $LL(1) - грамматикой$

Не существует алгоритма определения относится ли данный язык к классу $LL(1)$

Тем не менее существуют грамматики не являющиеся $LL(1) - грамматиками$, но генерирующие $LL(1) - языки$

___

## Восходящий синтаксический анализ (ВСА)

При восходящем синтаксическом анализе искомым является правое порождение. 

$\{x^my^n | m,n > 0\}$

$S \rightarrow XY$
$X \rightarrow xX$
$X \rightarrow x$
$Y \rightarrow yY$
$Y \rightarrow y$

Рассматриваем $xxxyy$

Искомое порождение

$S \Rightarrow XY \Rightarrow XyY \Rightarrow Xyy \Rightarrow xXyy \Rightarrow xxXyy \Rightarrow xxxyy$

При восходящем синтаксическом анализе порядок правых подстановок представим в следующем виде

$S \Leftarrow XY \Leftarrow XyY \Leftarrow Xyy \Leftarrow xXyy \Leftarrow xxXyy \Leftarrow xxxyy$

$LR(k)-грамматика$ - это грамматика все конфликты которой при восходящем синтаксическом анализе слева направо могут быть разрешени с использованием фиксированного объема информации, уже проведенного анализа и конечного числа символов предпросмотра. 

$LR(k)-язык$ - генерируется $LR(k)-грамматикой$

___

$E \rightarrow E + T$
$E \rightarrow T$
$T \rightarrow T*F$
$T \rightarrow F$
$F \rightarrow (E)$
$F \rightarrow x$

Разберем восходящий анализ

$x + x + x*x$
___

## Coding

### Syntax

```javascript=
from = 0; to = 1000;
echo("Задумай число от ",from," до ",to,", а я буду угадывать\n");
while (from <= to) {
   guess = (from+to)/2;
   echo("Это ",guess,"?  (1=меньше, 2=больше, 3=попал) ");
   i = input();
   if (i==1)
      to = guess-1;
   else if (i==2)
      from = guess+1;
   else if (i==3) {
      echo("Ура! Я молодец!\n");
      exit;
   } else
      echo("Я ничего не понял!\n");
}
echo("Врёшь, так не бывает!\n");
```

### Grammar v1.0 

```
PROGRAM: OPS ;  // последовательность операторов
OPS: OP | OPS OP ;
OP: '{' OPS '}' // блок
    | EXPR ';'  // выражение
    | 'if' '(' EXPR ')' OP
    | 'if' '(' EXPR ')' OP 'else' OP
    | 'while' '(' EXPR ')' OP
    | 'exit' ';' ;
EXPR: NUM // переменная
    | ID  // литерал
    | ID '(' ARGS ')' // вызов функции
    | EXPR '+' EXPR | EXPR '-' EXPR | EXPR '*' EXPR | EXPR '/' EXPR | '(' EXPR ')' | '-' EXPR // арифметика
    | EXPR '==' EXPR | EXPR '<=' EXPR | EXPR '>=' EXPR | EXPR '!=' EXPR | EXPR '>' EXPR | EXPR '<' EXPR
    | '!' EXPR // не будем заводить отдельные булевы операции; вместо && будет *, и вместо || будет +
    | ID '=' EXPR ;   // присваивание
ARGS: // пустой список
    | ARG // один аргумент
    | ARGS ',' ARG ;
ARG: EXPR | STRING ;  // строки возможны только в аргументах

```

**Any problems?** 
*Ambiguity?*

### Grammar v2.0

```
PROGRAM: OPS ;
OPS: OP | OPS OP ;
// операторы, за которыми может следовать else внешнего условия
OP1: '{' OPS '}' | EXPR ';'
     | 'if' '(' EXPR ')' OP1 'else' OP1 // if с else: оператором не может быть if без else
     | 'while' '(' EXPR ')' OP1
     | 'exit' ';' ;
// операторы, заканчивающиеся на if без else
OP2: 'if' '(' EXPR ')' OP     // if без else: оператор может быть любой
     | IF '(' EXPR ')' OP1 ELSE OP2
     | WHILE '(' EXPR ')' OP2 ;
OP: OP1 | OP2 ;
EXPR: EXPR1 | ID '=' EXPR ;   // низший приоритет и правая ассоциативность
// остальные операторы левоассоциативные, по возрастанию приоритета
EXPR1: EXPR2
     | EXPR1 '==' EXPR2 | EXPR1 '<=' EXPR2 | EXPR1 '>=' EXPR2
     | EXPR1 '!=' EXPR2 | EXPR1 '>' EXPR2 | EXPR1 '<' EXPR2 ;
EXPR2: TERM | EXPR2 '+' TERM | EXPR2 '-' TERM ;
TERM: VAL | TERM '*' VAL | TERM '/' VAL ;
VAL: NUM | '-' VAL | '!' VAL | '(' EXPR ')' | ID | ID '(' ARGS ')' ;
ARGS: | ARG | ARGS ',' ARG ;
ARG: EXPR | STRING ;
```

### Parser (LEX + BISON)

- token helds `std::string`
- type of values `YYSTYPE`
- `BEGIN` named states

### Bash

```bash
$ lex demo.lex

$ bison -vd demo.y

$ c++ lex.yy.c demo.tab.c

$ ./a.out < valid.demo

$ ./a.out < invalid.demo
```

### script_2

Folder with same compiler but with printing parsed tree (same view as input)

### Lab task

Serialize parse tree in JSON format

- Write translator in JSON format for the lex + bison bundle of this lab template (JVSRPT LNVG)

___

### Home assignment task

In your homework you will get a code snippet.

- Build a grammar for this code snippet.
- Use lex+bison to create a lexer + parser bundle
- Write translator in JSON format for the lex + bison bundle