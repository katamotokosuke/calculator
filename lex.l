%option noyywrap
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "parse.tab.h"
%}

%%
[0-9][0-9]* {
    yylval.value = atof(yytext);
    return VALUE;
}

[0-9]+\.[0-9]* {
    yylval.value = atof(yytext);
    return VALUE;
}

"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"%" { return REM; }
"\n" { return CR; }
"(" { return LEFT_BRACKET; }
")" { return RIGHT_BRACKET; }

%%
