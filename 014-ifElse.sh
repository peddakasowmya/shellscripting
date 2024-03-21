#!/bin/bash

<<COMMENT
if condition is ideally available in 3 formats:
1. Simple if
2. If else
3. Else if

1) Simple if

if [expression] ; then
            commands

fi

Commands are executed only if the condition is satisfied or true

2) If-Else

if [expression] ; then
            command 1
else
            command 2
fi


3) Else-if
if [expression] ; then
            command 1

elif [expression] ; then
            command 2

elif [expression] ; then
            command 3

else
            command 4
fi

COMMENT
