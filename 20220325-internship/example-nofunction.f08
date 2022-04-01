program main
  implicit none
  integer, parameter::stnN = 160, Year_start = 1951, Year_end = 2021
  integer, parameter::YearN = Year_end - Year_start + 1
  integer::stn_i, Year_i, max_JAN, max_JUL, i, j, max1, max2, min, max
  real::SAT_JAN(stnN, YearN), SAT_JUL(stnN, YearN)
  real::clm1_JAN(stnN), clm2_JAN(stnN), clm1_JUL(stnN), clm2_JUL(stnN)
  real::variance_JAN(stnN), variance_JUL(stnN)
  real::ave_p1(stnN), ave_p2(stnN), ave_change(stnN)
  integer::warming_N, colding_N, warm, cold
  real startTime, endTime
  call cpu_time(startTime)
  !Read Data
  open (11, file='t1601.txt')
  read (11, *) ((SAT_JAN(stn_i, Year_i), stn_i=1, stnN), Year_i=1, YearN)
  close (11)
  SAT_JAN = 0.1*SAT_JAN
  open (11, file='t1607.txt')
  read (11, *) ((SAT_JUL(stn_i, Year_i), stn_i=1, stnN), Year_i=1, YearN)
  close (11)
  SAT_JUL = 0.1*SAT_JUL
  print *, i
  !No.1
  do i = 1, stnN
    ave_p1(i) = 0
    ave_p2(i) = 0
  end do
  do i = 1, stnN
    do j = 1, YearN
      ave_p1(i) = ave_p1(i) + SAT_JAN(i, j)
      ave_p2(i) = ave_p2(i) + SAT_JUL(i, j)
    end do
  end do
  ave_p1 = ave_p1/YearN
  ave_p2 = ave_p2/YearN
  do i = 1, stnN
    print *, i, "站点的一月平均：", ave_p1(i)
    print *, i, "站点的七月平均：", ave_p2(i)
  end do
  !No.2
  min = 1
  max = 1
  do i = 2, stnN
    if (ave_p1(min) > ave_p1(i)) then
      min = i
    end if
    if (ave_p2(max) < ave_p2(i)) then
      max = i
    end if
  end do
  print *, "一月份气温平均最低的站点是：", min, "温度为：", ave_p1(min)
  print *, "七月份气温平均最高的站点是：", max, "温度为：", ave_p2(max)
  !No.3
  do i = 1, stnN
    variance_JAN(i) = 0
    variance_JUL(i) = 0
  end do
  do i = 1, stnN
    do j = 1, YearN
      variance_JAN(i) = variance_JAN(i) + (SAT_JAN(i, j) - ave_p1(i))*(SAT_JAN(i, j) - ave_p1(i))
      variance_JUL(i) = variance_JUL(i) + (SAT_JUL(i, j) - ave_p2(i))*(SAT_JUL(i, j) - ave_p2(i))
    end dO
  end do
  variance_JAN = variance_JAN/YearN
  variance_JUL = variance_JUL/YearN
  max1 = 1
  max2 = 1
  do i = 2, stnN
    if (variance_JAN(max1) < variance_JAN(i)) then
      max1 = i
    end if
    if (variance_JUL(max2) < variance_JUL(i)) then
      max2 = i
    end if
  end do
  print *, "一月份方差最大的站点是：", max1
  print *, "七月份方差最大的站点是：", max2
  !No.4
  do i = 1, stnN
    clm1_JAN(i) = 0
    clm2_JAN(i) = 0
  end do
  do i = 1, stnN
    do j = 1, 30
      clm1_JAN(i) = clm1_JAN(i) + SAT_JAN(i, j)
      clm2_JAN(i) = clm2_JAN(i) + SAT_JAN(i, YearN + 1 - j)
    end do
  end do
  clm1_JAN = clm1_JAN/30
  clm2_JAN = clm2_JAN/30
  warming_N = 0
  colding_N = 0
  warm = 0
  cold = 0
  do i = 1, stnN
    if ((clm2_JAN(i) - clm1_JAN(i)) > 0) then
      warming_N = warming_N + 1
      if (warm == 0) then
        warm = i
      else if ((clm2_JAN(warm) - clm1_JAN(warm)) < (clm2_JAN(i) - clm1_JAN(i))) then
        warm = i
      end if
    end if
    if ((clm2_JAN(i) - clm1_JAN(i)) < 0) then
      colding_N = colding_N + 1
      if (cold == 0) then
        cold = i
      else if ((clm2_JAN(cold) - clm1_JAN(cold)) > (clm2_JAN(i) - clm1_JAN(i))) then
        cold = i
      end if
    end if
  end do
  print *, "January", warming_N, "Warming", colding_N, "Colding", warm, "Warming most", cold, "Colding most"
  !No.5
  do i = 1, stnN
    clm1_JUL(i) = 0
    clm2_JUL(i) = 0
  end do
  do i = 1, stnN
    do j = 1, 30
      clm1_JUL(i) = clm1_JUL(i) + SAT_JUL(i, j)
      clm2_JUL(i) = clm2_JUL(i) + SAT_JUL(i, YearN + 1 - j)
    end do
  end do
  clm1_JUL = clm1_JUL/30
  clm2_JUL = clm2_JUL/30
  warming_N = 0
  colding_N = 0
  warm = 0
  cold = 0
  do i = 1, stnN
    if ((clm2_JUL(i) - clm1_JUL(i)) > 0) then
      warming_N = warming_N + 1
      if (warm == 0) then
        warm = i
      else if ((clm2_JUL(warm) - clm1_JUL(warm)) < (clm2_JUL(i) - clm1_JUL(i))) then
        warm = i
      end if
    end if
    if ((clm2_JUL(i) - clm1_JUL(i)) < 0) then
      colding_N = colding_N + 1
      if (cold == 0) then
        cold = i
      else if ((clm2_JUL(cold) - clm1_JUL(cold)) > (clm2_JUL(i) - clm1_JUL(i))) then
        cold = i
      end if
    end if
  end do
  print *, "July", warming_N, "Warming", colding_N, "Colding", warm, "Warming most", cold, "Colding most"
  call cpu_time(endTime)
  write (*, "(f16.14)") endTime - startTime
end program
