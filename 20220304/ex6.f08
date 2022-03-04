program ex6
  implicit none
  integer h, m, s
  do h = 0, 2
    do m = 0, 59
      do s = 0, 59
        write (*, "(I2.2,A1,I2.2,A1,I2.2)") h, ':', m, ':', s
      end do
    end do
  end do
end program ex6
