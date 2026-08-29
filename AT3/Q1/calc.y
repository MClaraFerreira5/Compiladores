%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

#define MAX_VARIABLES 100

int yylex(void);
void yyerror(const char *s);
extern FILE *yyin;

/* Estrutura para tabela de variaveis estatica */
typedef struct {
    char *name;
    double value;
} Variable;

static Variable variables[MAX_VARIABLES];
static size_t variable_count = 0;

/* Prototipos para evitar chamadas implicitas */
static int find_variable(const char *name);

static void set_var(char *name, double val) {
    int position = find_variable(name);

    if (position < 0) {
        if (variable_count >= MAX_VARIABLES) {
            fprintf(stderr, "Limite de variaveis excedido\n");
            free(name);
            return;
        }
        variables[variable_count].name = name;
        variables[variable_count].value = val;
        variable_count++;
        return;
    }

    variables[position].value = val;
    free(name);
}

static double get_var(const char *name) {
    int position = find_variable(name);

    if (position < 0) {
        return 0.0;
    }

    return variables[position].value;
}

static int find_variable(const char *name) {
    for (size_t i = 0; i < variable_count; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            return (int)i;
        }
    }
    return -1;
}

static void print_vars(void) {
    for (size_t i = 0; i < variable_count; i++) {
        printf("%s >>> %g\n", variables[i].name, variables[i].value);
    }
}

static void free_variables(void) {
    for (size_t i = 0; i < variable_count; i++) {
        free(variables[i].name);
    }
}
%}

%union {
    double val;
    char *id;
}

%destructor { free($$); } <id>

%token <id> ID
%token <val> NUM
%token MAIS MENOS VEZES DIVISAO ABRE_PAREN FECHA_PAREN POT GUARDA_VALOR PRINTAR
%type <val> expr

%left MAIS MENOS
%left VEZES DIVISAO
%precedence UMINUS
%right POT

%%
entrada : 
        | entrada acao '\n'    
        | entrada '\n'         
        ; 

acao : ID GUARDA_VALOR expr         { set_var($1, $3); }
     | expr                         { printf("= %g\n", $1); }
     | PRINTAR                      { print_vars(); }
     ;

expr : NUM                          { $$ = $1; }
     | ID                           { $$ = get_var($1); free($1); }
     | expr MAIS expr               { $$ = $1 + $3; }
     | expr MENOS expr              { $$ = $1 - $3; }
     | expr VEZES expr              { $$ = $1 * $3; }
     | expr DIVISAO expr            { $$ = $1 / $3; }
     | expr POT expr                { $$ = pow($1, $3); }
     | MENOS expr %prec UMINUS      { $$ = -$2; }
     | ABRE_PAREN expr FECHA_PAREN  { $$ = $2; }
     ;
%%

void yyerror(const char *s)
{
    fprintf(stderr, "Erro sintatico: %s\n", s);
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

    int result = yyparse();
    free_variables();
    return result;
}