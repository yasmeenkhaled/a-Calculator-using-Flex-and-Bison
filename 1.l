%{
#include "y.tab.h"
void yyerror(char *);
%}

%%
[0-9]+      {
                yylval = atoi(yytext);
                return INTEGER;
            }
[-+()*;/]   { return *yytext; }
[ \t\r]        ; /* skip whitespace */
.            yyerror("invalid character");
%%

int yywrap(void) {
    return 1;
}