%{
    #include <iostream>
    extern int yylineno;
    extern int yylex();
    void yyerror(char *s) {
      std::cerr << s << ", line " << yylineno << std::endl;
      exit(1);
    }
    #define YYSTYPE std::string
%}

%token IF ELSE WHILE EXIT
%token EQ LE GE NE
%token STRING NUM ID

%%

PROGRAM: OPS
;

OPS:    OP
|       OPS OP
;

OP1:    '{' OPS '}'
|       EXPR ';'
|       IF '(' EXPR ')' OP1 ELSE OP1
|       WHILE '(' EXPR ')' OP1
|       EXIT ';'
;

OP2:    IF '(' EXPR ')' OP
|       IF '(' EXPR ')' OP1 ELSE OP2
|       WHILE '(' EXPR ')' OP2
;

OP:     OP1 | OP2 ;

EXPR:   EXPR1
|       ID '=' EXPR

EXPR1:  EXPR2
|       EXPR1 EQ EXPR2
|       EXPR1 LE EXPR2
|       EXPR1 GE EXPR2
|       EXPR1 NE EXPR2
|       EXPR1 '>' EXPR2
|       EXPR1 '<' EXPR2
;

EXPR2: TERM
|       EXPR2 '+' TERM
|       EXPR2 '-' TERM
;

TERM:   VAL
|       TERM '*' VAL
|       TERM '/' VAL
;

VAL:    NUM
|       '-' VAL
|       '!' VAL
|       '(' EXPR ')'
|       ID
|       ID '(' ARGS ')'
;

ARGS:
|       ARG
|       ARGS ',' ARG
;

ARG:    EXPR
|       STRING
;

%%
int main() { return yyparse(); }