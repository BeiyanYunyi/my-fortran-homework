program insert
  implicit none
  integer, parameter::N = 20
  integer i, j, k
  real randomAry(N), temp
  call random_seed()
  call random_number(randomAry)
  randomAry = randomAry*100
  print *, "Random array:"
  do k = 1, N
    print *, randomAry(k)
  end do
  do i = 1, N
    temp = randomAry(i)
    j = i - 1
    do while ((j .ge. 0) .and. (randomAry(j) > temp))
      randomAry(j + 1) = randomAry(j)
      j = j - 1
    end do
    randomAry(j + 1) = temp
  end do
  print *, "Sorted array:"
  do k = 1, N
    print *, randomAry(k)
  end do

end program insert
