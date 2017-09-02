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
%token ADD SUB MUL REM DIV POW CR LP RP
%type <value> factor expr
%left ADD SUB
%left MUL DIV REM
%left NEG POS
%right POW

%%
input :
      | input line
line  : CR
      | expr CR { printf(">> %f\n", $1); }
      | error CR { yyerrok; yyclearin;  }
expr  : factor
      | ADD expr %prec POS { $$ = $2;           }
      | SUB expr %prec NEG { $$ = -$2;          }
      | expr ADD expr      { $$ = $1 + $3;      }
      | expr SUB expr      { $$ = $1 - $3;      }
      | expr MUL expr      { $$ = $1 * $3;      }
      | expr DIV expr      { $$ = $1 / $3;      }
      | expr REM expr      { $$ = fmod($1, $3); }
      | expr POW expr      { $$ = pow($1, $3);  }
      | LP expr RP         { $$ = $2;           }
factor: VALUE
%%

int yyerror(char const *str)
{
    extern char *yytext;
    fprintf(stderr, "%s\n--> %s\n", str, yytext);
    return 0;
}
int main(void)
{
    yyparse();
}