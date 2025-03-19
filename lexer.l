%{
#include <stdio.h>
#include "parser.tab.h" // Agora usamos o header gerado pelo Bison

int yylval;
int running = 1;

int getLineNumber() {
    return yylineno;
}

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

{HEX_NUMBER}  { yylval = strtol(yytext + 1, NULL, 16); return LIT_INT; }
{DIGITO}+     { yylval = atoi(yytext); return LIT_INT; }
\'[^\']\'     { return LIT_CHAR; }
\"(\\.|[^\\"])*\"  { return LIT_STRING; }

","   { return ','; }
";"   { return ';'; }
"("   { return '('; }
")"   { return ')'; }
"+"   { return '+'; }
"-"   { return '-'; }
"*"   { return '*'; }
"/"   { return '/'; }
"%"   { return '%'; }

[ \t\n]+   { }

%%

int yywrap() {
    return 1;
}
