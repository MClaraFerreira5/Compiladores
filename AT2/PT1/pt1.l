%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h> 
%}

%x COMENTARIO
%x STRING

%%

"/*" {
    printf("INICIO DE COMENTARIO\n");
    BEGIN(COMENTARIO);
}

<COMENTARIO>"*/" {
    printf("FIM DE COMENTARIO\n");
    BEGIN(INITIAL);

}

<COMENTARIO>\n {
    /* ignora quebra de linha */
}

<COMENTARIO>. {
    /* ignora qualquer outro caractere */
}

\" {
    BEGIN(STRING);
}
    
<STRING>\" {
    BEGIN(INITIAL);
}
<STRING>\n {
    fprintf(stderr, "Erro: String nao fechada.\n");
    exit(1);
}
<STRING>[^\"\n]+ {
    /* ignora qualquer caractere dentro da string */
    printf("STRING %s\n", yytext);
}

"else"                  { printf("ELSE\n"); }
"if"                    { printf("IF\n"); }
"while"                 { printf("WHILE\n"); }
"return"                { printf("RETURN\n"); }

[a-zA-Z_][a-zA-Z0-9_]*  { printf("ID %s\n", yytext); }
[0-9]+(\.[0-9]+)?       { printf("NUMBER %s\n", yytext); }
"//".*                  {  } 

[ \t\n]+                {  }
.                       { printf("SIMBOLO %s\n", yytext); }


%%

// int yywrap(void) {
    // return 1;
// }

int main(int argc, char **argv) {
    
    if (argc < 2) {
        fprintf(stderr, "Erro: Uso correto: %s <nome_do_arquivo_entrada>\n", argv[0]);
        exit(1);
    }

    FILE *arquivo = fopen(argv[1], "r");
    if (!arquivo) {
        fprintf(stderr, "Erro: Nao foi possivel abrir o arquivo '%s'.\n", argv[1]);
        exit(1);
    }


    yyin = arquivo;

    yylex();

    fclose(arquivo); 
    return 0;
}