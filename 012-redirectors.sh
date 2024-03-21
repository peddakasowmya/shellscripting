#!/bin/bash
# redirectors

echo "This file is all about i/p, o/p and error redirectors"

#how to take input, give outputs and handle the erors
<<redirectors
1) Input redirector:   ' < '    - $mysql < /student/sql
2) Output redirector:   '> or >>' -


#Output types:
1. Standard output                      1> or >(replaces) or >> (append)
2. Standard error                       2> or 2>>
3. Standard output and Standard error   &> or &>>

redirectors

#'1>' and '>' --> After redirecting the previous contect is overridden
#'>>' ---> The data will be appended
#/dev/null  ---> we can redirect output to this file and nullify it
