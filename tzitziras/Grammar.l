%option noyywrap


%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stack>
using namespace std;
stack<YY_BUFFER_STATE> buffer_stack;

%}

FILENAME  [a-zA-Z_][a-zA-Z0-9_]*\.[a-zA-Z_][a-zA-Z0-9_]*

%%

^\#include[ \t]+\"{FILENAME}\"   {
								 // 1. Extract filename
								 char *filename_start = strchr(yytext, '\"');
								 char *filename_end = strchr(filename_start+1, '\"');
								 size_t n = (size_t)(filename_end - filename_start - 1);
								 char* fname = (char*)malloc(n + 1);
								 memcpy(fname, filename_start + 1, n);
								 fname[n] = '\0';
                
								 // 2. Open the file
								 FILE *file;
								 fopen_s(&file, fname, "r");


								 // 3. Create a new buffer
								 YY_BUFFER_STATE new_buffer = yy_create_buffer(file, YY_BUF_SIZE);
								 // 4. Switch to the new buffer
								 yy_switch_to_buffer(new_buffer);
								 // 5. Store the current buffer to return later
								 buffer_stack.push(new_buffer);
								 free(fname);
							   }

.|\n	{	printf("%s",yytext);  }

<<EOF>>  {
			// 1. Check if there are stored buffers to return to
			if (!buffer_stack.empty()) {
				// 2. Yes, switch back to the previous buffer
				YY_BUFFER_STATE previous_buffer = buffer_stack.top();
				buffer_stack.pop();
				yy_switch_to_buffer(previous_buffer);
			} else {
				// 3. If no, end the lexing process
				return 0; // End lexing
			}
		}
			
			




%%



