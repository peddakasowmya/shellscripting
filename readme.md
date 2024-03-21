# Shell Scripting
This is a BASH learning repository and automating the entire configuartion management using BASH.
We will place all thefiles in a serial order that gives you the approach which one to look first and next.
This is a public repository, so that everyone can read but only I can write.
Public repository can only be accesssed by owner or the people who are part of the organization can access and is not available over internet.

Lets practice these in serial order.

For Authentication, GITHUB offers PAT (Personal Access Token)

Before making first push lets generate a Token,
On your account  ---> Profile ---> Settings --> Developeer settings ----> Classic Token


###whenever you design anything, make sure that piece of automation should work in all other environments as well (prod, non-prod, qa, dev)

#Best practices to be followed for a better automation:

1) Always consider something as working if it works multiple times
2) try to avoid the repetetive code and use functions as much as possible to avoid duplication

## DRY Code vs WET code
DRY : Don't Repeat Yourself  --> reduce repetition of code
WET : Write Everything Twice --> 

### POints to be noted in DNS
1. When you create any private DNS record, don't prefer to delete anytime, 
2. just update the IP
3. If you delete the private DNS record and try to create, sometimes it would take 24 hrs for it to work
