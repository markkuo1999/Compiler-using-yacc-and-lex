%{
#include "y.tab.h"
%}
%%
[ \t]+	{;}
[0-9]+	{yylval.ival = atoi(yytext);return(INUMBER);}
[a-zA-Z]+ {yylval.word = strdup(yytext);return(WORD);}
.	{return yytext[0];}
[\n]    {yylval.word = strdup(yytext);return(WORD);}
<<EOF>> {yylval.word = strdup("end");return(WORD);}
%%
