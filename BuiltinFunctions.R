# Built In functions

# Log to base e is default
log(10)
# [1] 2.302585
# For log to base 10
log10(10)
#[1] 1
# For log 10 to base 2 or any n
log(10,2)
#[1] 3.321928

# R knows the value of 180 as pi
pi
[1] 3.141593
#So
sin(pi/2)
#[1] 1

# Ctrl-L to clear console in R
cos(pi)
#[1] -1

# Antilog function
exp(2.302)
#[1] 9.994151
# Sq root
sqrt(16)
#[1] 4
#***************************************
factorial(3)
#[1] 6
#Combinations or Binomial Coefficients 3C2
choose(3,2)
#[1] 3

# For getting the value of (x-1)!
gamma(4)
# Gives 3! [1] 6, so factorial(5)=gamma(6)
# Natural log of the gamma function value
lgamma(3)
#[1] 0.6931472

# Smallest closest integer
floor(3.45)
#[1] 3
# Greatest closest integer
ceiling(3.45)
#[1] 4

# Closest integer between x and 0
trunc(3.45)
# [1] 3

# Rounding Off
round(3.4567,digits=0)
#[1] 3

# Generates x uniformly distributed random numbers between 0 and 1
runif(7)
#[1] 0.473769285 0.538969449 0.437840309 0.126296500 0.003472214 0.516080500 0.722387827
# Absolute value ignoring minus sign
abs(-12)
#[1] 12