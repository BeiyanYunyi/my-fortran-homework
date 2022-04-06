program file1
  implicit none
  integer::i = 0
  real::b
  character*7 data
  open (2, file="test.txt")
  open (3, file="test2.txt")
  do i = 1, 5
    read (2, *) data, b
    print *, data, b
    write (3, "(a7,1x,f6.1)") data, b
  end do
  close (2)
  close (3)
end program file1
