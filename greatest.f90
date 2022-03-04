program greatest
  implicit none
  real a, b, c, r
  read *, a, b, c
  r = max(a, b, c)
  if (r == a) print *, 'The greatest:', a
  if (r == b) print *, 'The greatest:', b
  if (r == c) print *, 'The greatest:', c
end program greatest
