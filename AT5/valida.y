%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
extern FILE *yyin;
int yylex(void); 
%}

%token ABRE_CHAVES FECHA_CHAVES ABRE_COLCHETES FECHA_COLCHETES
%token ',' ':' PALAVRA_RESERVADA NUMERO STRING

%start json

%%

json: valor ;

valor: 
      STRING 
    | NUMERO  
    | PALAVRA_RESERVADA
    | objeto
    | array
    ;

objeto:
      ABRE_CHAVES FECHA_CHAVES
    | ABRE_CHAVES lista_de_atributos FECHA_CHAVES
    ;

lista_de_atributos:
      atributo
    | lista_de_atributos ',' atributo
    ;

atributo:
      STRING ':' valor
    ; 

array:
      ABRE_COLCHETES FECHA_COLCHETES
    | ABRE_COLCHETES lista_de_valores FECHA_COLCHETES
    ;

lista_de_valores: 
      valor
    | lista_de_valores ',' valor
    ;

%%

void yyerror(const char *s)
{
    printf("JSON COM ERRO\n");
    exit(1); 
}

int main(int argc, char **argv)
{
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Erro ao abrir o arquivo");
            return 1;
        }
        yyin = file;
    }

    if (yyparse() == 0) {
        printf("JSON OK\n");
    }
    
    return 0;
}