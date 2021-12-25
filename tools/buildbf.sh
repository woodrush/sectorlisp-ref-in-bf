#!/bin/bash
set -e

mkdir -p build
mkdir -p out

echo "8cc..."
./elvm/out/8cc -S -I. -Ilibc -Iout -o build/lisp.c.eir sectorlisp/lisp.c
echo "elc..."
./elvm/out/elc -bf build/lisp.c.eir > build/lisp.c.eir.bf

echo "Cleaning the BF source code..."
cat ./build/lisp.c.eir.bf | sed -e 's/[^][+-\,.<>]//g' > ./build/cleaned.bf
cat ./build/cleaned.bf | tr -d ':\n' > ./out/lisp.bf

echo "bfopt..."
cd elvm
./out/bfopt -c ../out/lisp.bf ../build/lisp.c.eir.bf.c

echo "tcc..."
./tinycc/tcc -Btinycc ../build/lisp.c.eir.bf.c -o ../out/lisp.bf.exe
cd ..

echo "Built the BF source code and optimized executable."
