//
// Created by cubazis on 27.08.18.
//

#include "parcer.h"
#include "string.h"

/** Variables for inter communication of lexical analyzer and parser */

char *yytext  = "";   /* Lexeme (not '\0' terminated)   */
int yyleng    = 0;    /* Lexeme length.                 */
int yylineno  = 0;    /* Input line number              */

void* lex()
{
	static char buffer[128];
	char        *current;

	current = yytext + yyleng;  	/* Skip current lexeme  */

	while( 1 )                  	/* Get the next one     */
	{
		while( !*current )
		{
			/* Get new lines, skipping any leading white space on the line,
			 * until a nonblank line is found.
			 */

			current = buffer;
			if( !fgets( buffer, sizeof(buffer), file) )
			{
				*current = '\0' ;
				return _EOI;
			}
			++yylineno;

			while( isspace(*current) )
				++current;
		}

		for( ; *current ; ++current )
		{
			/* Get the next token */

			yytext = current;
			yyleng = 1;

			switch( *current )
			{
				case ';': return (void *) _SEMI;
				case '+': return (void *)_PLUS  ;
				case '*': return (void *)_TIMES ;
				case '(': return (void *)_LP    ;
				case ')': return (void *)_RP    ;

				case '\n':
				case '\t':
				case '\r':
				case ' ' : break;

				default:
					if( !isdigit(*current) ){
						//fprintf(stderr, "Ignoring illegal input <%c>\n", *current);
						return (void *)_ERR_1;
					}
					else
					{
						while( isdigit(*current) )
							++current;

						yyleng = (int) (current - yytext);
						return (void *)_NUM;
					}
			}
		}
	}
}

static int Lookahead = -1;      /* Lookahead token  */

int match(int token )
{
	/* Return true if "token" matches the current lookahead symbol. */

	if( Lookahead == -1 )
		Lookahead = (int) lex();

	return token == Lookahead;
}

void advance()
{
	/* Advance the lookahead to the next input symbol.  */

	Lookahead = (int) lex();
}

void expression()
{
	/* expression -> term expression' */

	/** YOUR CODE HERE */
}

void term()
{
	/* term -> factor term' */

	/** YOUR CODE HERE */
}

void expr_prime()
{
	/* expression' -> PLUS term expression'
	 *              | epsilon
	 */

	/** YOUR CODE HERE */
}

void term_prime()
{
	/* term' -> TIMES factor term'
	 *       |   epsilon
	 */

	/** YOUR CODE HERE */
}

void factor()
{
	/* factor   ->    NUM_OR_ID
	 *          |     LP expression RP
	 */
	/** YOUR CODE HERE */
}

void statements()
{
	/*  statements -> expression SEMI
	 *             |  expression SEMI statements
	 */
	expression();

	if( match( _SEMI ) ){
		strcat(parser_result, "SEMI ");
		advance();
	}

	if( !match(_EOI) ){
		statements();			/* Do another statement. */
	} else {
		strcat(parser_result, "EOF");
	}
}
