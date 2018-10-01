#!/usr/bin/env bash
cd ./src
bison -d demo.y --verbose && flex demo.l && g++ -c lex.yy.c demo.tab.c && g++ -o demo lex.yy.o demo.tab.o -ll -ly && echo "good news everyone!"
rm lex.yy.* demo.tab.*