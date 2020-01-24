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

%token NUM // declare NUM as a terminal

%%

input:
  %empty
| input line
;

line:
  '\n'
| EXPI '\n' { printf ("%.10g\n", $1); }
;

EXPI:
  NUM
| '(' '+' EXPI EXPI ')' { $$ = $3 + $4; }
| '(' '-' EXPI EXPI ')' { $$ = $3 - $4; }
| '(' '*' EXPI EXPI ')' { $$ = $3 * $4; }
| '(' '/' EXPI EXPI ')' { $$ = $3 / $4; }
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
    return NUM;
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