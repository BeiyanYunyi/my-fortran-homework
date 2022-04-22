program internship5
  implicit none
  integer i
  external saveToFile, readFromFile
  call saveToFile()
  print *, "输入1-100之间的整数"
  read *, i
  call readFromFile(i)
end program internship5

subroutine saveToFile()
  implicit none
  integer::i = 0
  real::n = 0
  open (10, file="data.txt", access="direct", recl=10, form="formatted")
  do i = 1, 100
    n = i
    write (10, "(5f10.7)", rec=i) sqrt(n)
  end do
  close (10)
end subroutine saveToFile

subroutine readFromFile(i)
  implicit none
  integer, intent(in)::i
  real::n = 0
  open (10, file="data.txt", access="direct", recl=10, form="formatted")
  read (10, "(5f10.7)", rec=i) n
  print *, n
  close (10)
end subroutine readFromFile
