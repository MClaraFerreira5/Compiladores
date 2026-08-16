%{
#include <stdio.h>

int linhas = 0;
int palavras = 0;
int caracteres = 0;
int inteiros = 0;
int floats = 0;
int pontuacoes = 0;
%}

/* Regex */
DIGITO [0-9]
LETRA [a-zA-Z]
FLOAT {DIGITO}+\.{DIGITO}+
INTEIRO {DIGITO}+
PALAVRA {LETRA}+
PONTUACAO [.,;:!\?]

%%

\n {linhas++; caracteres += yyleng;}
{FLOAT} {floats++; caracteres += yyleng;}
{INTEIRO} {inteiros++; caracteres += yyleng;}  
{PALAVRA} {palavras++; caracteres += yyleng;}
{PONTUACAO} {pontuacoes++; caracteres += yyleng;}
. {caracteres += yyleng;}

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
    yylex();

    if (caracteres > 0 && (linhas == 0 || yyleng > 0)) {
        linhas++;
    }


    fprintf(f_out, "Linhas: %d\n", linhas);
    fprintf(f_out, "Palavras: %d\n", palavras);
    fprintf(f_out, "Caracteres: %d\n", caracteres);
    fprintf(f_out, "Inteiros: %d\n", inteiros);
    fprintf(f_out, "Floats: %d\n", floats);
    fprintf(f_out, "Pontuacoes: %d\n", pontuacoes);

    fclose(f_in);
    fclose(f_out);

    return 0;
}