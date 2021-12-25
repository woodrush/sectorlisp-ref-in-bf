#!/bin/bash
set -e

cc -w -Os   -c -o ./build/lisp.o ./sectorlisp/lisp_bf.c
cc -s ./build/lisp.o  -o ./out/lisp

cd sectorlisp && make
cd ..

BOOTSTRAP=$(tail ./sectorlisp/lisp.lisp -n 45)

function test_lisp () {
    input=$1
    expected=$2
    echo "Case $(echo $1 | head -n 1) ..."

    output_modified=$(echo "$input" | ./out/lisp)
    output_orig=$(echo "$input" | ./sectorlisp/lisp)
    if [ "$output_modified" != "$output_orig" ] || [ "$output_modified" != "$expected" ]; then
        echo "Test failed!"
        echo "Input: $input"
        echo "Output (modified): $output"
        echo "Output (original): $output_orig"
        exit 1
    fi
    echo "Passed."
}

test_lisp "(QUOTE 5)" "5"
test_lisp "((LAMBDA () (QUOTE 7)))" "7"
test_lisp "$BOOTSTRAP" "A"

echo "All tests have passed."
