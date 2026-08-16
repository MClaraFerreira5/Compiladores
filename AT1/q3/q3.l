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
    FILE *f_in = fopen("entrada.txt", "r");
    if (!f_in) {
        fprintf(stderr, "Erro ao abrir o arquivo entrada.txt\n");
        return 1;
    }

    FILE *f_out = fopen("saida.txt", "w");
    if (!f_out) {
        fprintf(stderr, "Erro ao criar o arquivo saida.txt\n");
        fclose(f_in);
        return 1;
    }
    yyin = f_in;
    stdout = f_out;
    yylex();
    fclose(f_in);
    fclose(f_out);
    return 0;
}
