%{
#include <stdio.h>
#include <string.h>
#define YYDEBUG 0
int stack[100], top, invalid;
void yyerror(const char *message);
%}
%union {
int ival;
char *word;
}
%token <ival> INUMBER
%token <word> WORD
%type <ival> integer
%type <word> test
%left '+'
%error-verbose
%%
start : line
      | start line
      ;
line :test integer {;}
   ;
line :test {}
   ;
integer :INUMBER {top++;stack[top] = $<ival>1;}
   ;
test :WORD {if($<word>1[0] == 'a'){if(top-1<0){invalid=1;}else{stack[top-1] = stack[top]+stack[top-1];top--;}}	  
	    else if($<word>1[0] == 's' && $<word>1[1] == 'u'){if(top-1<0){invalid=1;}else{stack[top-1] = stack[top]-stack[top-1];top--;}}
	    //printf("%d\n", stack[top]);
	    else if($<word>1[0] == 'm' && $<word>1[1] == 'u'){if(top-1<0){invalid=1;}else{stack[top-1] = stack[top]*stack[top-1];top--;}}
	    else if($<word>1[0] == 'm' && $<word>1[1] == 'o'){if(top-1<0 || stack[top-1] == 0){invalid=1;}else{stack[top-1] = stack[top]%stack[top-1];top--;}}
	    else if($<word>1[0] == 'e'){if(invalid==1){printf("Invalid format\n");}else if(top!=0){printf("Invalid format\n");}else{printf("%d\n", stack[top]);}return 0;}
  	    else if($<word>1[0] == 'i'){if(top<0){invalid=1;}else{stack[top]++;}}
	    else if($<word>1[0] == 'd' && $<word>1[1] == 'e' && $<word>1[2] == 'c'){if(top<0){invalid=1;}else{stack[top]--;}}
	    else if($<word>1[0] == 'c'){if(top<0){invalid=1;}else{top++;stack[top] = stack[top-1];}}
	    else if($<word>1[0] == 'd' && $<word>1[1] == 'e' && $<word>1[2] == 'l'){if(top<0){invalid=1;}else{stack[top] = '\0';top--;}}
	    else if($<word>1[0] == 's' && $<word>1[1] == 'w'){if(top-1<0){invalid=1;}else{int tmp;tmp = stack[top];stack[top] = stack[top-1];stack[top-1] = tmp;}}}
	   
            
   ;
%%
void yyerror (const char *message)
{
        printf("Invalid format\n");
}

int main(int argc, char *argv[]) {
	#if YYDEBUG
            yydebug = 1;
    	#endif
	top = -1;
	//printf("%d\n", 3%0);
	invalid = 0;
        yyparse();
        return(0);
}
