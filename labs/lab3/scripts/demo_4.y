%{
    #include <stdio.h>
    void yyerror(char *s) {
      fprintf (stderr, "%s\n", s);
    }
%}

%token NUM

%%

EVALUATE: EXPR          { printf("=%d\n", $$) } ;

EXPR:    NUM
        | EXPR '+' EXPR { $$ = $1 + $3; }
        | EXPR '-' EXPR { $$ = $1 - $3; }
        | EXPR '*' EXPR { $$ = $1 * $3; }
        | EXPR '/' EXPR { $$ = $1 / $3; }
;

%%