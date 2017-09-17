%{
    int yylex();
    int yyerror(char const *str);
%}
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
%}
%union {
    double value;
}
%token <value> VALUE;
%token ADD SUB MUL REM DIV POW CR LEFT_BRACKET RIGHT_BRACKET
%type <value> factor expr
%left ADD SUB
%left MUL DIV REM

%%
input :
      | input line
line  : CR
      | expr CR { printf("result >> %f\n", $1); }
      | error CR { yyerrok; yyclearin;  }
expr  : factor
      | expr ADD expr      { $$ = $1 + $3;      }
      | expr SUB expr      { $$ = $1 - $3;      }
      | expr MUL expr      { $$ = $1 * $3;      }
      | expr DIV expr      { $$ = $1 / $3;      }
      | expr REM expr      { $$ = fmod($1, $3); }
      | LEFT_BRACKET expr RIGHT_BRACKET { $$ = $2;           }
factor: VALUE
%%

int yyerror(char const *str)
{
    printf("syntax error!!");
    return 0;
}
int main(void)
{
    yyparse();
}