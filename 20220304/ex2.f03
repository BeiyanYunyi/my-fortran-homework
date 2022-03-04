program ex1
  implicit none
  integer i, t
  read *, t
  do i = 0, t
    print *, t, 'X', i, '=', t*i
  end do
end program ex1
