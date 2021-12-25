#!/bin/bash
set -e

cc -w -Os   -c -o ./build/lisp.o ./sectorlisp/lisp.c
cc -s ./build/lisp.o  -o ./out/lisp

BOOTSTRAP=$(tail ./sectorlisp/lisp.lisp -n 45)

function test_lisp () {
    input=$1
    expected=$2
    echo "Case $(echo $1 | head -n 1) ..."

    output=$(echo "$input" | ./out/lisp)
    if [ "$output" != "$expected" ]; then
        echo "Test failed!"
        echo "$input"
        echo "$output"
        exit 1
    fi
    echo "Passed."
}

test_lisp "(QUOTE 5)" "5"
test_lisp "((LAMBDA () (QUOTE 7)))" "7"
test_lisp "$BOOTSTRAP" "A"

echo "All tests have passed."
