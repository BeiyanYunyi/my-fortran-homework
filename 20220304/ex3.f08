program main
  implicit none
  integer a, i, j
  read *, a
  do i = 1, a
    write (*, "(<a-i>x,<2*i-1>('*'))")
  end do
  do i = 1, (a - 1)
    write (*, "(<i>x,<2*a-1-2*i>('*'))")
  end do
end
