# JVSRPT LNVG
___

```bash
lex demo.lex

bison -vd demo.y

g++ lex.yy.c demo.tab.c

clear

./a.out < valid.demo

./a.out < invalid.demo
```
___

