#!/bin/bash

#Loops: to run something for required number of times
<<COMMENT
There are 2 types of loops
1. For loop     (when you know how many times to be executed)
2. While loop   (when you do not know how many times to be executed)

for x in a b c d e ; do
echo print $x
done

COMMENT

for x in 10 20 30 40 50 ; do
    echo -e " values are $x \n\t"
done