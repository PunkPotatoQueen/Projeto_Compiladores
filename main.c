#include "tokens.h"
#include <stdio.h>

// Declaração das funções do lexer
extern int yylex();
extern int getLineNumber();
extern int isRunning();

int main() {
    int token;
    printf("Iniciando análise léxica...\n");

    while (isRunning()) {
        token = yylex();
        if (token == TOKEN_ERROR) {
            printf("Erro léxico na linha %d: caractere inválido\n", getLineNumber());
        } else if (token < 256) {
            printf("Token reconhecido: '%c' (ASCII %d)\n", token, token);
        } else {
            printf("Token reconhecido: %d\n", token);
        }
    }

    printf("Análise léxica concluída.\n");
    return 0;
}