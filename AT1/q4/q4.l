%{
#include <stdio.h>
#include <stdlib.h>
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

{ID}        { printf("ID %s\n", yytext); }
{NUMERO}    { printf("NUMBER %s\n", yytext); }

[ \t\r\n]+ {}

. { printf("SIMBOLO %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Erro: Informe o nome do arquivo de entrada.\nUso: %s <nome_do_arquivo>\n", argv[0]);
        exit(1);
    }

    FILE *arquivo = fopen(argv[1], "r");
    if (!arquivo) {
        fprintf(stderr, "Erro: Nao foi possivel abrir o arquivo '%s'.\n", argv[1]);
        exit(2);
    }

    FILE *f_out = fopen("saida.txt", "w");
    if (!f_out) {  
        
        fprintf(stderr, "Erro: Nao foi possivel criar o arquivo de saida 'saida.txt'.\n");
        fclose(arquivo);
        exit(3);
    }
    yyin = arquivo;
    stdout = f_out;
    yylex();

    fclose(arquivo);
    fclose(f_out);
    return 0;
}
