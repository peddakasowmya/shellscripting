#1/bin/bash

#Every color in bash has a color code and we can use that code based on our need

#Color      Foreground Code     Background Code
#Black          30                      40
#Red	        31	                    41
#Green	        32	                    42
#Yellow	        33	                    43  
#Blue	        34	                    44
#Magenta	    35	                    45
#Cyan	        36	                    46
#Light Gray	    37	                    47

#SYNTAX to print colors

#echo -e "\e[COLOR CODEm I am printing a color \e[0m"
echo -e "\e[30m I am pritning Black color \e[0m"
echo -e "\e[31m I am pritning Red color \e[0m"
echo -e "\e[32m I am pritning Green color \e[0m"
echo -e "\e[33m I am pritning Yellow color \e[0m"
echo -e "\e[34m I am pritning Blue color \e[0m"
echo -e "\e[36m I am pritning Cyan color \e[0m"
echo -e "\e[37m I am pritning Light Gray color \e[0m"