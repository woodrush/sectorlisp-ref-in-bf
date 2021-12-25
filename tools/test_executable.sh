#!/bin/bash
set -e

cc -w -Os   -c -o ./build/lisp.o ./sectorlisp/lisp.c
cc -s ./build/lisp.o  -o ./out/lisp

BOOTSTRAP=$(tail ./sectorlisp/lisp.lisp -n 45)

echo " (QUOTE 7) " | ./out/lisp
echo " ((LAMBDA () (QUOTE 5))) " | ./out/lisp
echo $BOOTSTRAP | ./out/lisp
