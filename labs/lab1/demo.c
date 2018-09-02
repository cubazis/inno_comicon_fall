//
// Created by cubazis on 01.09.18.
//

#include <stdio.h>
#include "src/parcer.h"

int main(void)
{
	file = fopen( "in.txt" , "r");
	FILE * out = fopen( "out.txt" , "w");
	statements();

	printf("%s\n", result);
	fprintf(out, result);

	fclose(file);
	fclose(out);
}