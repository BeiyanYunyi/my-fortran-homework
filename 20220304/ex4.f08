program ex4
  implicit none
  integer ::n = 6
  integer i, sigma, pi, b
  do i = 1, n
    read *, b
    if (i == 1) then
      pi = b
    else
      pi = pi*b
    end if
    sigma = sigma + b
  end do
  print *, 'sum=', sigma, 'times=', pi
end program ex4
