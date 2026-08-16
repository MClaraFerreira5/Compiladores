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