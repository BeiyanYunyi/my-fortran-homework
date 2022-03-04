program ex7
  implicit none
  integer i
  real ::bbb = 1
  do i = 2, 64
    bbb = 2*bbb
  end do
  write (*, "(A6,E10.4,A9,E10.4)") 'count=', bbb, ', weight=', bbb*0.025
end program ex7
