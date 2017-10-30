%{

#include "y.tab.h"

#include <stdio.h>

extern int yylval;

%}



%%

[0-9]+     {yylval=atoi(yytext); return DIGIT; }

int|float|char|double   {return DTYPE;}

"#include <"[.a-zA-Z ]*">\n" {return HEADER;}

"main()"[\n]*      {return MAIN;}

"{"[\n]*           {return STARTB;}

"}"[\n]*           {return ENDB;}

";"[\n]*           {return ENDS;}

","                {return SEP;}

[-+/*]            {return OP;}

"="               {return EQ;}

"("               {return OPB;}

")"               {return CLB;}

"if"              {return IFC;}

"printf("[^\)]*")" {printf("Function call\n");return FUNC;}

"scanf("[^\)]*")" {printf("Function call\n");return FUNC;}

[a-zA-Z][_a-zA-Z0-9]*  {return VAR;}

[ \t]+ ;

%%



int yywrap()

{return 1;}

