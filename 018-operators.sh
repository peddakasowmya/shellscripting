#!/bin/bash

<<COMMENT
## Expressions are categorised in to three types and based on expression 

1. numbers
2. Strings
3. Files

Operators on Numbers:

-eq, -ne, -gt, -ge, -lt, -le

[ 1 -eq 1 ]
[ 1 -ne 1 ]

Operators on strings:
=, ==, !=
a = 10  --> assigning the value
==      --> String comparison

[ abc = abc ]

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