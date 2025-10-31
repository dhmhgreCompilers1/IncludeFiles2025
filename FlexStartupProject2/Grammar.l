%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
FILE *fa[3];
FILE *fout;
YY_BUFFER_STATE ba[3];
int buffer;
%}
%%
.|\n	{	fprintf(fout,"%s-%d \n",yytext,(buffer)%3); buffer++;
			printf("\n%s",yytext);
			yy_switch_to_buffer(ba[buffer%3]);
		}
%%
void main(){
	buffer = 0;
	fopen_s(&fa[0],"a.txt","r");
	fopen_s(&fa[1],"b.txt","r");
	fopen_s(&fa[2],"c.txt","r");
	fopen_s(&fout,"output.txt","w");
	ba[0] = yy_create_buffer(fa[0], YY_BUF_SIZE);
	ba[1] = yy_create_buffer(fa[1], YY_BUF_SIZE);
	ba[2] = yy_create_buffer(fa[2], YY_BUF_SIZE);
	yy_switch_to_buffer(ba[buffer]);
	yylex();
}