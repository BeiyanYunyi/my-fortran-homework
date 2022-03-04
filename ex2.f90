program main
  implicit none
  real E1, E2, E0, t
  E0 = 6.11
  read *, t
  E1 = E0*10**((7.45*t)/(237.3 + t))
  E2 = E0*exp((17.67*t)/(243.5 + t))
  print *, 'E1=', E1, 'E2=', E2
end program main
