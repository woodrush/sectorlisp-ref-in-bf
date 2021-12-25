#!/bin/bash
set -e

cd sectorlisp && make
cd ..

BOOTSTRAP=$(tail ./sectorlisp/lisp.lisp -n 45)

echo " ((LAMBDA () (QUOTE 5))) " | ./sectorlisp/lisp
echo " (QUOTE 5) " | ./sectorlisp/lisp
echo $BOOTSTRAP | ./sectorlisp/lisp
