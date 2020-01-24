CC=cc
# CFLAGS=-I.
CFLAGS=-Wall

NAME=gpp_interpreter

all:
	flex -l ${NAME}.l
	bison -d ${NAME}.y
	${CC} -o ${NAME} ${NAME}.tab.c lex.yy.c ${CFLAGS}

clean:
	rm -rf *.o lex.yy.c ${NAME}.tab.* ${NAME}.output

run:
	./${CC} code.g++
