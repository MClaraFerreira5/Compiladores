%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include "valida.tab.h" /* ESSENCIAL PARA PEGAR OS TOKENS DO BISON */
%}

%option noyywrap

%%

"{"                    { return ABRE_CHAVES; }
"}"                    { return FECHA_CHAVES; }
"["                    { return ABRE_COLCHETES; }
"]"                    { return FECHA_COLCHETES; }
","                    { return ','; }
":"                    { return ':'; }

"true"                  { return PALAVRA_RESERVADA; }
"false"                 { return PALAVRA_RESERVADA; }
"null"                  { return PALAVRA_RESERVADA; }

-?(0|[1-9][0-9]*)(\.[0-9]+)?    { return NUMERO; }
\"[^\"\n]*\"                    { return STRING; }

[ \t\r\n]+              { /* ignora espacos e quebras de linha */ }
.                       { return yytext[0]; /* manda caracteres estranhos pro parser reprovar */ }

%%