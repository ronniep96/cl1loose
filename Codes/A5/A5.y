%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int sym_count=0;
int quad_count=0;
int tempvar=0;
struct Sym
{
	char sym_name[20];
	char sym_type[20];
	double val;
}sym[10];
struct Quad
{
	char op[10];
	char op1[10];
	char op2[10];
	char res[10];
}quad[10];
struct Stack
{
	int top;
	char *items[10];
}stk;
int searchSym(char[]);
void addToSym(char[],char[],double);
void addToQuad(char[],char[],char[],char[]);
void displaySym();
void displayQuad();
void push(char*);
char* pop();
%}
%union
{
	char string[20];
	double dval;
	int ival;
}
%token MAIN 
%token <dval>NUMBER
%token <string>ID 
%token <string>TYPE 
%left '+' '-' 
%left '*' '/'
%%
main:    MAIN '(' ')' '{' body '}' ;
body:    varstmnt  stmntlist ;
varstmnt : vardec varstmnt | ;
vardec:  TYPE varlist ';';
 
varlist: varlist ',' ID							 {
										
										if(searchSym($3)!=-1)
								     			printf("Already Declared\n");
								     		else
							     			        addToSym($3,$<string>0,0);
						
										
									  }
							    
|  ID '=' NUMBER 					        	    {
										//printf("%s",$3);
										if(searchSym($1)!=-1)
								     			printf("Already Declared\n");
								     		else
							     			        addToSym($1,$<string>0,$3);
	
									    }
	
							
									
| varlist ',' ID '=' NUMBER                                                {
										if(searchSym($3)!=-1)
								     			printf("Already Declared\n");
								     		else
							     			        addToSym($3,$<string>0,$5);
	
									    }
	
		
 |  ID 						                           {
									
										
										if(searchSym($1)!=-1)
								     			printf("Already Declared\n");
								     		else
							     			        addToSym($1,$<string>0,0);
									
										
									    }
				
	
	;
stmntlist:varinit stmntlist |   ;
varinit:						    
	  ID '=' expr ';'                            {
	  						
	 						int i=searchSym($1);
	 						if(i==-1)
	 							printf("Variable undeclared\n");
	 						else
	 							addToQuad("=","",pop(),$1);		
	 			
	   				             }
	 ;
expr: expr '+' expr                                  {
                                                          
                                                          char temp[20]="t";
                                                          char index[10];
                                                          sprintf(index,"%d",tempvar);
                                                          strcat(temp,index);
                                                          tempvar++;
                                                          addToQuad("+",pop(),pop(),temp);
                                                          push(temp);
                                                         
						     } 
| expr '-' expr                                      {
                                                          
                                                          char temp[20]="t";
                                                          char index[10];
                                                          sprintf(index,"%d",tempvar);
                                                          strcat(temp,index);
                                                          tempvar++;
                                                          addToQuad("-",pop(),pop(),temp);
                                                          push(temp);
                                                         
						     } 
	
| expr '*' expr                                      {
                                                          
                                                          char temp[20]="t";
                                                          char index[10];
                                                          sprintf(index,"%d",tempvar);
                                                          strcat(temp,index);
                                                          tempvar++;
                                                          addToQuad("*",pop(),pop(),temp);
                                                          push(temp);
                                                         
						     } 
| expr '/' expr                                      {
                                                          
                                                          char temp[20]="t";
                                                          char index[10];
                                                          sprintf(index,"%d",tempvar);
                                                          strcat(temp,index);
                                                          tempvar++;
                                                          addToQuad("/",pop(),pop(),temp);
                                                          push(temp);
                                                         
						     } 
	
 | ID                                                {  
 							
 							if(searchSym($1)==-1) 
                                                       		printf("Undeclared Variable\n");  
 							else
 								push($1);
 						     }
 
 
 | NUMBER    					     {  
 							char temp[10];
 							snprintf(temp,10,"%f",$1); 
 							push(temp);
 						     }
 
 ;
%% 
extern FILE* yyin;
	
int  main()
{
	stk.top=-1;
	yyin = fopen("input.txt","r");
	yyparse();
	printf("Symbol Table\n\n");
	displaySym();
	printf("\n\nQuadraple Table \n\n");
	displayQuad();
	printf("\n\n");
	return 0;
}
int searchSym(char name[])
{	
	int i=0;
	int flag=0;
	for( i=0;i<sym_count;i++)
	{
		if(strcmp(sym[i].sym_name,name)==0)
		{
			flag=1;
			break;
		}
	}
	if(flag)
		return i;
	return -1;
}
void addToSym(char id[],char type[] ,double value)
{	
	strcpy(sym[sym_count].sym_name,id);
	strcpy(sym[sym_count].sym_type,type);
	sym[sym_count].val=value;
	sym_count++;
}
void addToQuad(char op[],char op1[],char op2[],char res[])
{
	strcpy(quad[quad_count].op,op);
	strcpy(quad[quad_count].op1,op1);
	strcpy(quad[quad_count].op2,op2);
	strcpy(quad[quad_count].res,res);
	
	quad_count++;
	
}
void push(char *str)
{	
	stk.top++;
	stk.items[stk.top]=(char*)malloc(strlen(str)+1);
	strcpy(stk.items[stk.top],str);
}
char* pop()
{
	char *temp= (char*)malloc(strlen(stk.items[stk.top])+1);
	strcpy(temp,stk.items[stk.top]);
		
	stk.top--;
	return temp;
}
void displaySym()
{	
	int i=0;
	char name[]="NAME";
	char type[]="TYPE";
	char value[]="VALUE";
	printf("\n%s%40s%40s\n",name,type,value);
	for(;i<sym_count;i++)
		printf("%s%40s%40f\n",sym[i].sym_name,sym[i].sym_type,sym[i].val);
}
void displayQuad()
{
	char res[]="RES";
	char op[]="OPERATOR";
	char op1[]="OPERAND1";
	char op2[]="OPERAND2";
	printf("\n\n%s%10s%10s%10s\n",res,op,op1,op2);
	int i=0;
	for(;i<quad_count;i++)
		printf("%10s%10s%10s%10s\n",quad[i].res,quad[i].op,quad[i].op1,quad[i].op2);
}
yyerror()
{
printf("ERROR");
return 1;
}
