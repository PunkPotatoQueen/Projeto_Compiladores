%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

/* Definição dos tokens, já gerenciados pelo Bison */
%token KW_CHAR KW_INT KW_IF KW_THEN KW_ELSE KW_WHILE KW_READ KW_PRINT KW_RETURN
%token TK_IDENTIFIER LIT_INT LIT_CHAR LIT_STRING
%token OP_PLUS OP_MINUS OP_MULT OP_DIV OP_MOD OP_LPAREN OP_RPAREN

/* Definição de precedência para evitar conflitos */
%left OP_PLUS OP_MINUS
%left OP_MULT OP_DIV OP_MOD
%left OP_LPAREN OP_RPAREN

%%

program:
    expression { printf("Expressão reconhecida\n"); }
    ;

expression:
    expression OP_PLUS expression
    | expression OP_MINUS expression
    | expression OP_MULT expression
    | expression OP_DIV expression
    | OP_LPAREN expression OP_RPAREN
    | LIT_INT
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}
