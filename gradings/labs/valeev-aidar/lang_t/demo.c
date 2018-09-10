//
// Created by cubazis on 01.09.18.
//

#include <stdio.h>
#include "src/parcer.h"

int main(int argc, char *argv[])
{
	file = fopen( "in.txt" , "r");
	FILE * out = fopen( "out.txt" , "w");
	statements();

	printf("%s\n", parser_result);
	fprintf(out, parser_result);

	fclose(file);
	fclose(out);
}