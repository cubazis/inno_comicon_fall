# JVSRPT LNVG
___

```bash
lex demo.lex

bison -vd demo.y

c++ lex.yy.c demo.tab.c

./a.out < valid.demo

./a.out < invalid.demo
```
___

