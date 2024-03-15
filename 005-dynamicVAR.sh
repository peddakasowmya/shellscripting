#!/bin/bash

#DATE="14/MARCH/2024"
#NO_OF_SESSIONS="2"  #Thesre are hard coding 

DATE="#(date+%F)"
NO_OF_SESSIONS="$(who | wc -l)"

echo -e "Today's date is $DATE"
echo -e "Total active sessions are: $NO_OF_SESSIONS"


