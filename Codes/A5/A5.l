%{
#include"y.tab.h"
#include<string.h>
#include<stdio.h>
%}

%%

main		      {   return MAIN;};

[ \n\t]                ;

int|float|char|double {   strcpy(yylval.string,yytext); return TYPE;     };

[0-9]+ |		 
[0-9]+\.[0-9]+	      {   yylval.dval=atof(yytext);     return NUMBER;   };

[a-zA-Z][a-zA-Z0-9_]*  {   strcpy(yylval.string,yytext);   return ID;      };

. 		      {   return yytext[0];  };

%%
int yywrap() {return 1;}
