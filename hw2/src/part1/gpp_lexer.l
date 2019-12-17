/*** Definition Section has one variable 
which can be accessed inside yylex() 
and main() ***/
%{ 
#include "tokens.h"
%}

ERROR 1


/*  Rule Section has three rules, first rule
    matches with capital letters, second rule
    matches with any character except newline and
    third rule does not take input after the enter */
%%

[" "\t\n]   ; /* Ignores */

and     { printf("%s\n", "KW_AND"); }
or      { printf("%s\n", "KW_OR"); }
not     { printf("%s\n", "KW_NOT"); }
equal   { printf("%s\n", "KW_EQUAL"); }
less    { printf("%s\n", "KW_LESS"); }
nil     { printf("%s\n", "KW_NIL"); }
list    { printf("%s\n", "KW_LIST"); }
append  { printf("%s\n", "KW_APPEND"); }
concat  { printf("%s\n", "KW_CONCAT"); }
set     { printf("%s\n", "KW_SET"); }
deffun  { printf("%s\n", "KW_DEFFUN"); }
for     { printf("%s\n", "KW_FOR"); }
if      { printf("%s\n", "KW_IF"); }
exit    { printf("%s\n", "KW_EXIT"); }
load    { printf("%s\n", "KW_LOAD"); }
disp    { printf("%s\n", "KW_DISP"); }
true    { printf("%s\n", "KW_TRUE"); }
false   { printf("%s\n", "KW_FALSE"); }

"+"       { printf("%s\n", "OP_PLUS"); }
"-"       { printf("%s\n", "OP_MINUS"); }
"**"      { printf("%s\n", "OP_DBLMULT"); }
"*"       { printf("%s\n", "OP_DIV"); }
"/"       { printf("%s\n", "OP_MULT"); }
"("       { printf("%s\n", "OP_OP"); }
")"       { printf("%s\n", "OP_CP"); }
"\""      { printf("%s\n", "OP_OC"); }
"\""      { printf("%s\n", "OP_CC"); }
","       { printf("%s\n", "OP_COMMA"); }

;;.*    { printf("%s\n", "COMMENT"); }

[1-9][0-9]*         { printf("%s\n", "VALUE"); }

[a-zA-Z][a-zA-Z_$0-9]*    { printf("%s\n", "IDENTIFIER"); }

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

    // Close file before exit program
    fclose(fp);

    return 0; 
} 
