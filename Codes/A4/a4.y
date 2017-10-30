%{

#include <stdio.h>

extern FILE* yyin;

%}



%token DIGIT VAR HEADER MAIN STARTB ENDB 

%token ENDS DTYPE SEP FUNC OP EQ

%token IFC OPB CLB



%%

St: S MAIN STARTB stmts ENDB {printf("Program with main\n");};

S: HEADER S | HEADER {printf("HEADERs\n");};

stmts: stmt| stmts stmt| ;

stmt: expr|DTYPE varlist ENDS | FUNC ENDS | IFC OPB CLB STARTB stmts ENDB {printf("\nStatement\n");};

varlist: VAR| varlist SEP VAR ;

expr:  VAR EQ dv opn ENDS{printf("Expression\n");};

opn:  OP dv | OP dv opn|;

dv:   DIGIT|VAR;

%%

int main()

{

char ifile[100];

printf("\nEnter input file name:     ");

scanf("%s",ifile);

yyin=fopen(ifile,"r");

yyparse();

}


int yyerror(char* s)
{

printf("Incorrect Syntax");

}
