#!/bin/bash
set -e

BOOTSTRAP=$(tail ./sectorlisp/lisp.lisp -n 45)

echo " ((LAMBDA () (QUOTE 7)))" | ./out/lisp.bf.exe
echo " (QUOTE 5)" | ./out/lisp.bf.exe
echo $BOOTSTRAP | ./out/lisp.bf.exe
