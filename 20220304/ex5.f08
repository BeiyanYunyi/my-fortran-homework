program ex5
  implicit none
  integer bbb, sum
  do while (bbb .ne. -666)
    read *, bbb
    if (bbb .ne. -666) sum = sum + bbb
  end do
  print *, "sum=", sum
end program ex5
