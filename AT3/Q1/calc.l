%{
#include "calc.tab.h"
#include <string.h>

#include <stdio.h>
%}

%option noyywrap

%%
"printar_variaveis"     { return PRINTAR;     }
[a-zA-Z][a-zA-Z0-9_]*   { yylval.id = strdup(yytext); return ID; }
[0-9]+(\.[0-9]+)?       { yylval.val = atof(yytext); return NUM; }
"**"                    { return POT;         }
"+"                     { return MAIS;        }
"-"                     { return MENOS;       }
"*"                     { return VEZES;       }
"/"                     { return DIVISAO;     }
"("                     { return ABRE_PAREN;  }
")"                     { return FECHA_PAREN; }
">>>"                   { return GUARDA_VALOR;}
[ \t\r]+                  { }
\n                      { return '\n'; }
.                       { return yytext[0];    }
%%
