%{
#include <stdio.h>
#include <stdbool.h>

#ifdef YYDEBUG
  yydebug = 1;
#endif

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

%type <int_val> EXPI

%type <int_val> VALUE
%type <str_val> IDENTIFIER

%union {
    char *str_val;
    int int_val;
}

%start START

%%

START	: %empty
		| INPUT
		;

INPUT	: EXPI
		| EXPLISTI
		;

LISTVALUE	: OP_OC OP_OP VALUES OP_OP
			;

VALUES	: VALUE
		| VALUE VALUES	
		;


EXPI	: OP_OP OP_PLUS EXPI EXPI OP_CP		{ printf("+ %d %d", $3, $4); $$ = $3 + $4; printf("+ %s", $$); }
		| OP_OP OP_MINUS EXPI EXPI OP_CP	{ printf("- %s %s", $3, $4); $$ = $3 - $4; }
		| OP_OP OP_MULT EXPI EXPI OP_CP		{ $$ = $3 * $4; }
		| OP_OP OP_DIV EXPI EXPI OP_CP		{ $$ = $3 / $4; }
		| VALUE
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

int main()
{
    return yyparse();
}