CC=cc
CFLAGS=-I.

all:
	flex gpp_lexer.l
	${CC} -o gpp_lexer lex.yy.c ${CFLAGS}

clean:
	rm -rf lex.yy.c gpp_lexer

run:
	./gpp_lexer example.g++
