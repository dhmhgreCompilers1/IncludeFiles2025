#include <stack>
#include <stdlib.h>
#include <stdio.h>
#include <string>

#include "Grammar.flex.h"

extern int yylex();
extern std::stack<YY_BUFFER_STATE> buffer_stack;
FILE* f0;

int main (int argc ,char** argv) {
	if (argc > 1) {
		fopen_s(&f0,argv[1], "r");
		if (f0 == NULL) {
			perror (argv[1]);
			return 1;
		}
	}
	YY_BUFFER_STATE newbuffer = yy_create_buffer(f0, YY_BUF_SIZE);
	buffer_stack.push(newbuffer);
	yy_switch_to_buffer(newbuffer);
	yylex();
	
	return 0;
}


