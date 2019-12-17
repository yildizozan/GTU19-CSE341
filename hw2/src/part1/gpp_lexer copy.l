/*** Definition Section has one variable 
which can be accessed inside yylex() 
and main() ***/
%{ 
int count = 0; 
%}

AND     and

IDENTIFIER  [a-z][a-zA-Z0-9]

letter  [a-zA-Z]

digit   [0-9]

/*  Rule Section has three rules, first rule
    matches with capital letters, second rule
    matches with any character except newline and
    third rule does not take input after the enter */
%%

AND     { return KW_AND; }
OR      { return KW_OR; }
NOT     { return KW_NOT; }
EQUAL   { return KW_EQUAL; }
LESS    { return KW_LESS; }
NIL     { return KW_NIL; }
LIST    { return KW_LIST; }
APPEND  { return KW_APPEND; }
CONCAT  { return KW_CONCAT; }
SET     { return KW_SET; }
DEFFUN  { return KW_DEFFUN; }
FOR     { return KW_FOR; }
IF      { return KW_IF; }
EXIT    { return KW_EXIT; }
LOAD    { return KW_LOAD; }
DISP    { return KW_DISP; }
TRUE    { return KW_TRUE; }
FALSE   { return KW_FALSE; }

PLUS   { return OP_PLUS; }
MINUS   { return OP_MINUS; }
DIV   { return OP_DIV; }
MULT   { return OP_MULT; }
OP   { return OP_OP; }
CP   { return OP_CP; }
DBLMULT   { return OP_DBLMULT; }
OC   { return OP_OC; }
CC   { return OP_CC; }
COMMA   { return OP_COMMA; }

COMMENT   { return COMMENT; }

VALUE   { return VALUE; }

{IDENTIFIER}   { return IDENTIFIER; }

[" "\t\n]      ; // Ignore whitespaces!

[A-Z]   { printf("%s capital letter\n", yytext); count++; } 
.       { printf("%s not a capital letter\n", yytext); } 
%% 

/*** Code Section prints the number of 
capital letter present in the given input***/
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
    printf("\nNumber of Captial letters in the given input - %d\n", count); 

    // Close file before exit program
    fclose(fp);

    return 0; 
} 
