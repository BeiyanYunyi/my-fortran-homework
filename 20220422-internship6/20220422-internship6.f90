!  $20220422internship6.f90
!
!  FUNCTIONS:
!  $20220422internship6 - Entry point of console application.
!

!****************************************************************************
!
!  PROGRAM: $20220422internship6
!
!  PURPOSE:  Entry point for the console application.
!
!****************************************************************************

program internship6
  implicit none

  ! Variables
  integer, parameter::gridX = 145, gridY = 73, gridZ = 3, timeT = 3
  integer::x = 0, y = 0, z = 0, t = 0
  real::presSFC(timeT, 1, gridY, gridX), air(timeT, gridZ, gridY, gridX), hgt(timeT, gridZ, gridY, gridX)

  ! Body of $20220422internship6
  ! Read Pres SFC
  open (10, file="pres.sfc.2019.01.01.txt")
  read (10, *) ((presSFC(1, 1, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="pres.sfc.2019.01.02.txt")
  read (10, *) ((presSFC(2, 1, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="pres.sfc.2019.01.03.txt")
  read (10, *) ((presSFC(3, 1, y, x), x=1, gridX), y=1, gridY)
  close (10)
  ! Read Air
  open (10, file="air.700.2019.01.01.txt")
  read (10, *) ((air(1, 1, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="air.700.2019.01.02.txt")
  read (10, *) ((air(2, 1, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="air.700.2019.01.03.txt")
  read (10, *) ((air(3, 1, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="air.500.2019.01.01.txt")
  read (10, *) ((air(1, 2, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="air.500.2019.01.02.txt")
  read (10, *) ((air(2, 2, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="air.500.2019.01.03.txt")
  read (10, *) ((air(3, 2, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="air.200.2019.01.01.txt")
  read (10, *) ((air(1, 3, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="air.200.2019.01.02.txt")
  read (10, *) ((air(2, 3, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="air.200.2019.01.03.txt")
  read (10, *) ((air(3, 3, y, x), x=1, gridX), y=1, gridY)
  close (10)
  ! Read HGT
  open (10, file="hgt.700.2019.01.01.txt")
  read (10, *) ((hgt(1, 1, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="hgt.700.2019.01.02.txt")
  read (10, *) ((hgt(2, 1, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="hgt.700.2019.01.03.txt")
  read (10, *) ((hgt(3, 1, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="hgt.500.2019.01.01.txt")
  read (10, *) ((hgt(1, 2, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="hgt.500.2019.01.02.txt")
  read (10, *) ((hgt(2, 2, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="hgt.500.2019.01.03.txt")
  read (10, *) ((hgt(3, 2, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="hgt.200.2019.01.01.txt")
  read (10, *) ((hgt(1, 3, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="hgt.200.2019.01.02.txt")
  read (10, *) ((hgt(2, 3, y, x), x=1, gridX), y=1, gridY)
  close (10)
  open (10, file="hgt.200.2019.01.03.txt")
  read (10, *) ((hgt(3, 3, y, x), x=1, gridX), y=1, gridY)
  close (10)
  print *, hgt
  open (10, file="internship6.grd", form="Binary")

  do t = 1, timeT
    ! Write PresSFC
    do y = 1, gridY
      do x = 1, gridX
        write (10) presSFC(t, 1, y, x)
      end do
    end do
    ! Write Air
    do z = 1, gridZ
      do y = 1, gridY
        do x = 1, gridX
          write (10) air(t, z, y, x)
        end do
      end do
    end do
    ! Write HGT
    do z = 1, gridZ
      do y = 1, gridY
        do x = 1, gridX
          write (10) hgt(t, z, y, x)
        end do
      end do
    end do
  end do
  close (10)

end program internship6

