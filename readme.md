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

# What we have achieved
1. We have paraeterised the code, so that with very minimal changes we were able to re-use the code
2. But is our code still DRY? --- NO


# We haveNodeJS, Python, Java, AngularJS based components...

# -----------------*********---------*************************_----------------
Lets make bash to create EC2 instances and route 533 records on AWS

# in how many ways can we connect or authenticate to AWS
* GUI / Console (Username / userPassword)
* CLI / Commands (we use tokens to authenticate)

Token Generation : Access / Secret key

IAM : Identity and Access Management
    - We create User Accounts   (Humans)
    - Group Accounts            (Humans)
    - IAM roles                 (System) -- (we can add 1 IAM role per an EC2 instance)

# IAM helps in achieving 'Least Privilage Principle' ( Zero trust principle)
AAA : Authentication , Authorization and Auditing


Vertical scaling --> Adding resources to the same machine again and again on the top of it.

# Vetical scaling vs Horizontal scaling


--- One EC2 instance can have n number of security groups
