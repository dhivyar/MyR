y <- function(number,divisor)
{
  if(number%%divisor==0)
    message("Exact Multiple")
  else
    message("NOT Exact Multiple")
}

# > y(4,2)
#Exact Multiple
#> y(4,3)
#NOT Exact Multiple