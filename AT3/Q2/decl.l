%{
#include <stdio.h>
#include <string.h>
#include "decl.tab.h"
%}

%option noyywrap

%%

"int"                   { yylval.str = strdup(yytext); return TIPO; }
"double"                { yylval.str = strdup(yytext); return TIPO; }
"char"                  { yylval.str = strdup(yytext); return TIPO; }

[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }

","                     { return ','; }
";"                     { return ';'; }

[ \t\r\n]+              { /* ignora espacos e quebras de linha */ }
.                       { /* ignora outros caracteres */ }

%%