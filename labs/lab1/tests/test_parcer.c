//
// Created by cubazis on 27.08.18.
//
#include <check.h>
#include "parcer.h"

#include <stdlib.h>

START_TEST (test_parser)
{
	char* output = string_builder();
	char* pattern = "Hello world";

	ck_assert_str_eq(output, pattern);
	printf("%s\n", output);
}
END_TEST

Suite* str_suite (void)
{
	Suite *suite = suite_create("parser");
	TCase *tcase = tcase_create("case");
	tcase_add_test(tcase, test_parser);
	suite_add_tcase(suite, tcase);
	return suite;
}

int main (int argc, char *argv[]) {
	int number_failed;
	Suite *suite = str_suite();
	SRunner *runner = srunner_create(suite);
	srunner_run_all(runner, CK_NORMAL);
	number_failed = srunner_ntests_failed(runner);
	srunner_free(runner);
	return number_failed;
}