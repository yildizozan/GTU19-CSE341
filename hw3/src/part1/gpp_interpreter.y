
%{
#include <stdio.h>

int yylex();
int yyerror(char *s);

%}

%token KW_AND
%token KW_OR
%token KW_NOT
%token KW_EQUAL
%token KW_LESS
%token KW_NIL
%token KW_LIST
%token KW_APPEND
%token KW_CONCAT
%token KW_SET
%token KW_DEFFUN
%token KW_FOR
%token KW_IF
%token KW_EXIT
%token KW_LOAD
%token KW_DISP
%token KW_TRUE
%token KW_FALSE

%token OP_PLUS
%token OP_MINUS
%token OP_DBLMULT
%token OP_DIV
%token OP_MULT
%token OP_OP
%token OP_CP
%token OP_OC
%token OP_CC
%token OP_COMMA

%token COMMENT
%token VALUE
%token IDENTIFIER


%%

START	:	INPUT
		;

INPUT	: EXPI
		| EXPLISTI
		;

LISTVALUE	: OP_OC OP_OP VALUES OP_OP
			;

VALUES	: VALUES VALUE
		| VALUES
		;


EXPI	: OP_OP OP_PLUS EXPI EXPI OP_CP		
		| OP_OP OP_MINUS EXPI EXPI OP_CP
		| OP_OP OP_MULT EXPI EXPI OP_CP
		| OP_OP OP_DIV EXPI EXPI OP_CP
		| IDENTIFIER
		| VALUE
		| OP_OP IDENTIFIER EXPLISTI OP_CP
		;

EXPB	: OP_OP KW_AND EXPB EXPB OP_CP
		| OP_OP KW_OR EXPB EXPB OP_CP
		| OP_OP KW_NOT EXPB EXPB OP_CP
		| OP_OP KW_EQUAL EXPB EXPB OP_CP
		| OP_OP KW_EQUAL EXPI EXPI OP_CP
		| BinaryValue
		;

EXPLISTI	: OP_OP KW_CONCAT EXPLISTI EXPLISTI OP_CP
			| OP_OP KW_APPEND EXPLISTI EXPLISTI OP_CP
			| LISTVALUE
			/* | null (eklenecek)*/
			;

BinaryValue	: KW_TRUE
			| KW_FALSE
			;
/*
EXPI	: OP_OP KW_SET IDENTIFIER EXPI OP_CP
		;

EXPI	: OP_OP KW_DEFFUN IDENTIFIER IDLIST EXPLISTI OP_CP
		;

EXPI	: OP_OP IDENTIFIER EXPI OP_CP
		;

EXPI	: OP_OP KW_IF EXPB EXPLISTI OP_CP
		;

EXPI	: OP_OP KW_IF EXPB EXPLISTI EXPLISTI OP_CP
		;
*/
/* EXPI -> (while (EXPB) EXPLISTI) */
/* EXPI -> (for (IDENTIFIER EXPI EXPI) EXPLISTI) */





%%

int yyerror(char *s)
{
	printf("Syntax Error on line %s\n", s);
	return 0;
}

/*** Code Section prints the number of 
capital letter present in the given input **/
int yywrap(){} 
int main(int argc, char *argv[]) { 

    // Explanation: 
    // yywrap() - wraps the above rule section 
    // yyin - takes the file pointer which contains the input
    // yylex() - this is the main flex function which runs the Rule Section
    // yytext is the text in the buffer 

    // Uncomment the lines below 
    // to take input from file 
    FILE *fp;
    fp = fopen(argv[1],"r"); 
    if (fp == NULL) {
        perror("Unable to open source code!");
        return 1;
    }

    char buffer[128];

    yyin = fp;
    //while (fgets(buffer, sizeof(buffer), fp) != NULL) {
    //    yyin = buffer;
    //}
     
    yylex();

    // Close file before exit program
    fclose(fp);

    return 0; 
} 