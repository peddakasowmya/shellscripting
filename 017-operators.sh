#!/bin/bash

<<COMMENT
Operators on strings:
=, ==, !=

[abc = abc]

-z , -n

[ -z "$var" ]  --> This is true if var is not having ny data
[ -n "$var" ]  --> This is true if var is having any data

-z and -n are inverse proportional options

Operators on files:
Lot of opertors are available and you can check them using man pages of bash

[ -f file]  --> True if file exists and file is a regular file
[ -d xyz ]  --> True if file exists and it is a directory

## explore the file types, there are 7 types on files in Linux.

COMMENT