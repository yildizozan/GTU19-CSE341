%{
  #include <stdio.h> // include print functions
  #include <math.h> // include `pow' function
  #include <ctype.h> // include `isdigit' function
  int yylex (void); // declare lexing function
  void yyerror (char const *); // declare yyerror function
%}

%define api.value.type {double}

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

input: %empty
| input line
;

line:
  '\n'
| EXPI '\n' { printf ("%.10g\n", $1); }
| EXPLISTI
;

EXPI:
  VALUE
| '(' '+' EXPI EXPI ')' { $$ = $3 + $4; }
| '(' '-' EXPI EXPI ')' { $$ = $3 - $4; }
| '(' '*' EXPI EXPI ')' { $$ = $3 * $4; }
| '(' '/' EXPI EXPI ')' { $$ = $3 / $4; }
;

EXPB	: OP_OP KW_AND EXPB EXPB OP_CP
		| OP_OP KW_OR EXPB EXPB OP_CP
		| OP_OP KW_NOT EXPB EXPB OP_CP
		| OP_OP KW_EQUAL EXPB EXPB OP_CP
		| OP_OP KW_EQUAL EXPI EXPI OP_CP
		| BinaryValue
		;

LISTVALUE	: OP_OC OP_OP VALUES OP_OP
			;

VALUES	: VALUE
		| VALUE VALUES	
		;

EXPLISTI	: OP_OP KW_CONCAT EXPLISTI EXPLISTI OP_CP
			| OP_OP KW_APPEND EXPLISTI EXPLISTI OP_CP
			| LISTVALUE
			/* | null (eklenecek)*/
			;

BinaryValue	: KW_TRUE
			| KW_FALSE
			;
%%

int yylex (void)
{
  int c;

  while ((c = getchar ()) == ' ' || c == '\t')
    continue;

  if (c == '.' || isdigit (c))
  {
    ungetc (c, stdin);
    scanf ("%lf", &yylval);
    return VALUE;
  }

  if (c == EOF)
    return 0;

  return c;
}

int main (void)
{ 
	return yyparse(); 
}

void yyerror (char const *s)
{
	fprintf (stderr, "%s\n", s);
	yyparse();
}