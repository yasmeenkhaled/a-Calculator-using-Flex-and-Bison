%token INTEGER
%left '+' '-' 
%left '*' '/'

%{

#include <stdio.h>
int yylex(void);
void yyerror(char *);
extern FILE * yyin;
extern FILE * yyout;
FILE * yyError;
%}


%%                                    
program:
        program expr ';' { fprintf(yyout, "%d\r", $2); }
        | 
        ;

expr:
        INTEGER                   { $$ = $1; }
		| expr '*' expr           { $$ = $1 * $3; }
        | expr '/' expr           { $$ = $1 / $3; }
        | expr '+' expr           { $$ = $1 + $3; }
        | expr '-' expr           { $$ = $1 - $3; }
        | '(' expr ')'            { $$ = $2; }
        ;
%%

void yyerror(char *s) {
fprintf(yyError, "%s\r\n", s);
}

int main(void) {
yyin = fopen( "in.txt", "r" );
yyout = fopen( "out.txt", "w" );
yyError = fopen( "outError.txt", "w" );

yyparse();

fclose(yyin);
fclose(yyout);
return 0;
}