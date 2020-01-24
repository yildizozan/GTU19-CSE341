CC=cc
# CFLAGS=-I.
CFLAGS=-Wall

NAME=gpp_interpreter

all:
	bison -d ${NAME}.y
	${CC} -o ${NAME} ${NAME}.tab.c

clean:
	rm -rf *.o ${NAME}.tab.* ${NAME}.output

run:
	./${CC} code.g++
