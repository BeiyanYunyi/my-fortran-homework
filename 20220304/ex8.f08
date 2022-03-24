program ex8
  implicit none
  integer secret, input
  integer::count = 0
  secret = int(rand(114514)*100 + 1)
  do while (input .ne. secret)
    count = count + 1
    read *, input
    if (input .gt. secret) print *, 'Your guess is bigger than my secret number. Try again.'
    if (input .lt. secret) print *, 'Your guess is smaller than my secret number. Try again.'
  end do
  print *, "You found it! You've tried for", count, "times."
end program ex8
