CC=cc
# CFLAGS=-I.
CFLAGS=-lfl

NAME=gpp_interpreter

all:
	flex -l gpp_lexer.l
	bison -dv ${NAME}.y
	${CC} -o ${NAME} ${NAME}.tab.c lex.yy.c ${CFLAGS}

clean:
	rm -rf *.o lex.yy.c ${NAME}.tab.* ${NAME}.output

run:
	./${CC} code.g++
