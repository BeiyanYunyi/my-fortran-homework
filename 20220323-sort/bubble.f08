program bubble
  implicit none
  integer, parameter::N = 20
  integer i, j, k
  real random_array(N), temp

  call random_seed()
  call random_number(random_array)
  random_array = random_array*100
  print *, "Random array:"
  do k = 1, N
    print *, random_array(k)
  end do

  do i = 1, N
    do j = 1, N - i
      if (random_array(j) > random_array(j + 1)) then
        temp = random_array(j)
        random_array(j) = random_array(j + 1)
        random_array(j + 1) = temp
      end if
    end do
  end do

  print *, "Sorted array:"
  do k = 1, N
    print *, random_array(k)
  end do
end program bubble
