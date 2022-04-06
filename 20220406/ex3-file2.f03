! 未完成 / 无法完成
program file2
  implicit none
  integer::i = 0
  real::b
  character*7 data
  open (2, file="test.txt")
  open (3, file="test2.dat", form="unformatted", access='stream')
  do i = 1, 5
    read (2, *) data, b
    print *, data, b
    write (3, *) data, b
  end do
  close (2)
  close (3)
end
