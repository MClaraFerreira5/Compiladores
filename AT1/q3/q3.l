%{
#include <stdio.h>
%}

DIGITO [0-9]
LETRA [a-zA-Z_]
ID {LETRA}({LETRA}|{DIGITO})*
NUMERO {DIGITO}+(\.{DIGITO}+)?

%% 

"//".* {}

"if" { printf("IF\n"); }
"else" { printf("ELSE\n"); }
"while" { printf("WHILE\n"); }
"return" { printf("RETURN\n"); }

{ID} printf("ID %s\n", yytext);
{NUMERO} printf("NUMBER %s\n", yytext);

[ \t\r\n]+ {}

. { printf("SIMBOLO %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}
