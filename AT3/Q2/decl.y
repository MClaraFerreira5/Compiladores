%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_VARS 1000

int yylex(void);
void yyerror(const char *s);
extern FILE *yyin;

typedef struct {
    char *name;
} Simbolo;

static Simbolo tabela[MAX_VARS];
static int total_vars = 0;
static char *tipo_atual = NULL;

static int busca_simbolo(const char *nome) {
    for (int i = 0; i < total_vars; i++) {
        if (strcmp(tabela[i].name, nome) == 0) return 1;
    }
    return 0;
}

static void declara_var(const char *nome) {
    if (busca_simbolo(nome)) {
        printf("erro: %s já foi declarada\n", nome);
    } else {
        printf("%s %s\n", tipo_atual, nome);
        tabela[total_vars].name = strdup(nome);
        total_vars++;
    }
}
%}

%union {
    char *str;
}

%token <str> TIPO ID

%%

programa : lista_declaracoes
         ;

lista_declaracoes : 
                  | lista_declaracoes declaracao
                  ;

declaracao : TIPO { 
                if (tipo_atual) free(tipo_atual);
                tipo_atual = $1; 
           } lista_ids ';' 
           ;

lista_ids : ID                  { declara_var($1); free($1); }
          | lista_ids ',' ID    { declara_var($3); free($3); }
          ;

%%

void yyerror(const char *s)
{
    fprintf(stderr, "%s\n", s);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *f = fopen(argv[1], "r");
        if (f) yyin = f;
    }
    yyparse();
    printf("+++++ %d variáveis declaradas\n", total_vars);
    
    if (tipo_atual) free(tipo_atual);
    for (int i = 0; i < total_vars; i++) {
        free(tabela[i].name);
    }
    return 0;
}