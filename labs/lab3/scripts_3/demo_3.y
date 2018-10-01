%{
    #include <stdio.h>
    void yyerror(char *s) {
      fprintf (stderr, "%s\n", s);
    }
    #define YYPRINT(file, type, value) fprintf(file, "%d", value);
%}

%token NUM

%%

EVALUATE: EXPR          { printf("%d\n", $$); } ;

EXPR:    TERM
        | EXPR '+' TERM { $$ = $1 + $3; }
        | EXPR '-' TERM { $$ = $1 - $3; }
;

TERM:    NUM
        | TERM '*' NUM  { $$ = $1 * $3; }
        | TERM '/' NUM  { $$ = $1 / $3; }
;

%%
int main () { yydebug=1; return yyparse(); }