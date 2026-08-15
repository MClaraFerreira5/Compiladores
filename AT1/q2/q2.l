%{
#include <stdio.h>
%}

%%

"+" { printf("PLUS\n");}
"-" { printf("MINUS\n");}
"*" { printf("TIMES\n");}
"/" { printf("DIVIDE\n");}
"(" { printf("LPAREN\n");}
")" { printf("RPAREN\n");}
"|" { printf("ABS\n");}
"%" { printf("MOD\n");}
"^" { printf("POWER\n");}
[0-9]+ { printf("NUMBER %s\n", yytext); }

"<="        { printf("REL_OP <=\n"); }
">="        { printf("REL_OP >=\n"); }
"=="        { printf("REL_OP ==\n"); }
"!="        { printf("REL_OP !=\n"); }
"<"         { printf("REL_OP <\n"); }
">"         { printf("REL_OP >\n"); }

[ \t]+ { /* IGNORA ESPAÇOS E TABULAÇÕES */ }
\r?\n { printf("NEWLINE\n"); }
. { printf("Mystery character %s\n", yytext); }

%%

int yywrap() {
    return 1;
}   

int main() {
    yylex();
    return 0;
}