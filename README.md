flex lex.l
bison -d parse.y
gcc parse.tab.c lex.yy.c -lm -o hogehoge
./hogehoge