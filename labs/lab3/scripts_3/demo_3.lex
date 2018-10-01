%{
    #include "demo_3.tab.h"
%}

%option yylineno
%option noyywrap

%%

[/][/].*\n      ; // comment
[0-9]+          { yylval = atoi(yytext);
                  return NUM;
                }
[ \t\r\n]      ; // whitespace
.              { return *yytext; }

%%