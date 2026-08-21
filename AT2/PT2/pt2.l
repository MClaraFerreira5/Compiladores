%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int linha = 1;
%}

%option noyywrap

DIGITO      [0-9]
LETRA       [a-zA-Z_]
ID          {LETRA}({LETRA}|{DIGITO})*
INTEIRO     {DIGITO}+
REAL        {DIGITO}+","{DIGITO}+
ESPACO      [ \t\r]+

%%

"\n"        { linha++; }
{ESPACO}    {  }

"{\-\-\-"   {
    int c;
    while((c = input()) != 0) {
        if(c == '\n') linha++;
        if(c == '-') {
            if((c = input()) == '-') {
                if((c = input()) == '-') {
                    if((c = input()) == '}') {
                        break; // Fim do comentário
                    }
                }
            }
        }
    }
    if(c == 0) {
        printf("LINHA %d: ERRO LEXICO (Comentario de bloco nao fechado)\n", linha);
    }
}

"#coment"[^\n]* { }

"inicio"          { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"fim"             { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"inteiro"         { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"real"            { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"texto"           { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"booleano"        { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"se"              { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"faz"             { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"senao"           { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"repita_enquanto" { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"para"            { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"de"              { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"ate"             { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"faca"            { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"leia"            { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"mostre"          { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"sim"             { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"nao"             { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"retorne"         { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }
"funcao"          { printf("LINHA %d: KEYWORD (%s)\n", linha, yytext); }

'[^'\n]*'         { printf("LINHA %d: STRING (%s)\n", linha, yytext); }
'[^'\n]*          { printf("LINHA %d: ERRO LEXICO (String nao fechada: %s)\n", linha, yytext); }

{DIGITO}+{LETRA}+ { printf("LINHA %d: ERRO LEXICO (Identificador invalido: %s)\n", linha, yytext); }

{REAL}            { printf("LINHA %d: REAL (%s)\n", linha, yytext); }
{INTEIRO}         { printf("LINHA %d: INTEGER (%s)\n", linha, yytext); }

{ID}              { printf("LINHA %d: IDENTIFIER (%s)\n", linha, yytext); }


"=="|"!="|"<="|">="|"&&"|"||" { printf("LINHA %d: OPERATOR (%s)\n", linha, yytext); }

"+"|"-"|"*"|"/"|"%"|"="|">"|"<"|"!" { printf("LINHA %d: OPERATOR (%s)\n", linha, yytext); }

"$"               { printf("LINHA %d: DOLLAR (%s)\n", linha, yytext); }
";"               { printf("LINHA %d: SEMICOLON (%s)\n", linha, yytext); }
"("               { printf("LINHA %d: LPAREN (%s)\n", linha, yytext); }
")"               { printf("LINHA %d: RPAREN (%s)\n", linha, yytext); }
"["               { printf("LINHA %d: LBRACKET (%s)\n", linha, yytext); }
"]"               { printf("LINHA %d: RBRACKET (%s)\n", linha, yytext); }
"{"               { printf("LINHA %d: LBRACE (%s)\n", linha, yytext); }
"}"               { printf("LINHA %d: RBRACE (%s)\n", linha, yytext); }

.                 { printf("LINHA %d: ERRO LEXICO (Caractere invalido: %s)\n", linha, yytext); }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *arquivo = fopen(argv[1], "r");
        if (!arquivo) {
            perror("Erro ao abrir arquivo");
            return 1;
        }
        yyin = arquivo;
    }
    yylex();
    return 0;
}