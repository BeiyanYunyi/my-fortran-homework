program select
  implicit none
  integer, parameter::N = 20
  integer i, j, k, min
  real randomAry(N)
  external swap
  call random_seed()
  call random_number(randomAry)
  randomAry = randomAry*100
  print *, "Random array:"
  do k = 1, N
    print *, randomAry(k)
  end do

  do i = 1, N - 1
    min = i
    do j = i + 1, N
      print *, j
      if (randomAry(j) < randomAry(min)) min = j
    end do
    call swap(randomAry(min), randomAry(i))
  end do

  print *, "Sorted array:"
  do k = 1, N
    print *, randomAry(k)
  end do

end program select

subroutine swap(a, b)
  implicit none
  real a, b, temp
  temp = a
  a = b
  b = temp
end subroutine swap
