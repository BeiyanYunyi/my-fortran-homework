program ex1
  implicit none
  integer i, t, sum
  do i = 1, 5
    read *, t
    sum = t + sum
  end do
  print *, sum
end program ex1
