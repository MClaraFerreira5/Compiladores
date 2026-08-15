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
    yylex();
    printf("Linhas: %d\n", linhas);
    printf("Palavras: %d\n", palavras);
    printf("Caracteres: %d\n", caracteres);
    printf("Inteiros: %d\n", inteiros);
    printf("Floats: %d\n", floats);
    printf("Pontuações: %d\n", pontuacoes);

    return 0;
}