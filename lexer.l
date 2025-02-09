%{
#include <stdio.h>
#include "tokens.h"

// Variável global para controle de execução
int running = 1;

// Função para retornar o número da linha
int getLineNumber() {
    return yylineno;
}

// Função para verificar o status da execução
int isRunning() {
    return running;
}
%}

DIGITO      [0-9]
LETRA       [a-zA-Z]
IDENTIFIER  {LETRA}({LETRA}|{DIGITO})*
HEX_NUMBER  "#"{DIGITO}+

%%

"char"       { return KW_CHAR; }
"int"        { return KW_INT; }
"if"         { return KW_IF; }
"then"       { return KW_THEN; }
"else"       { return KW_ELSE; }
"while"      { return KW_WHILE; }
"read"       { return KW_READ; }
"print"      { return KW_PRINT; }
"return"     { return KW_RETURN; }

{IDENTIFIER}  { return TK_IDENTIFIER; }

{HEX_NUMBER}  { return LIT_INT; }
{DIGITO}+     { return LIT_INT; }
\'[^\']\'     { return LIT_CHAR; }
\"(\\.|[^\\"])*\"  { return LIT_STRING; }

","   { return ','; }
";"   { return ';'; }
":"   { return ':'; }
"("   { return '('; }
")"   { return ')'; }
"["   { return '['; }
"]"   { return ']'; }
"{"   { return '{'; }
"}"   { return '}'; }
"="   { return '='; }
"+"   { return '+'; }
"-"   { return '-'; }
"*"   { return '*'; }
"/"   { return '/'; }
"%"   { return '%'; }
"<"   { return '<'; }
">"   { return '>'; }
"&"   { return '&'; }
"|"   { return '|'; }
"~"   { return '~'; }

"//".*  {
    printf("Token reconhecido: Comentário em linha 300 %s \n", yytext);
    return 300;
}    

"/\*"([^*]|\*+[^*/])*\*+"/" {
    printf("Token reconhecido: Comentário em mais de uma linha 400 \n");
    return 400;
}

[ \t\n]+   { /* Ignorar espaços em branco */ }


.          { return TOKEN_ERROR; }

%%

int yywrap() {
    running = 1; 
}