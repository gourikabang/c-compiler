all:
		bison -d --verbose grammar.y 
		flex lexer_test.l
		gcc -o test grammar.tab.c lex.yy.c -ll
		./test < input.txt > checkk.txt
		subl checkk.txt