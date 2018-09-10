//
// Created by cubazis on 27.08.18.
//

#ifndef LAB1_PARCER_H
#define LAB1_PARCER_H

#include <stdio.h>
#include <ctype.h>

/** parser internal entity to process the input stream */
FILE * file;

/** parser internal entity to provide parsing result*/
char parser_result[1000];

/** Tokens set */
#define _EOI           0		/*  end of input (EOF signal typically) */
#define _SEMI          1		/*       ;                              */
#define _PLUS          2		/*       +                              */
#define _TIMES         3		/*       *                              */
#define _LP            4		/*       (                              */
#define _RP            5		/*       )                              */
#define _NUM           6		/* decimal number                       */

#define _ERR_1         "Ignoring illegal input"

/**
 * lexical analyzer function
 * @return token (int number from the token set)
 */

void* lex();

int match( int token );

void advance();

void expression();

void term();

void expr_prime();

void factor();

void term_prime();

void statements();

#endif //LAB1_PARCER_H
