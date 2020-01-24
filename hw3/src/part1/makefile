CC=cc
# CFLAGS=-I.
CFLAGS=-Wall

NAME=gpp_interpreter

all:
	flex -l ${NAME}.l
	bison -d ${NAME}.y
	${CC} -o ${NAME} ${NAME}.tab.c lex.yy.c

clean:
	rm -rf *.o ${NAME}.tab.* ${NAME}.output lex.yy.c

run:
	./${CC} code.g++
