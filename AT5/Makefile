valida: valida.y valida.l
	bison -d valida.y
	flex valida.l
	gcc valida.tab.c lex.yy.c -lm -o valida 

clean:
	rm -f valida valida.tab.c valida.tab.h lex.yy.c valida.output