! 我也不知道怎么解释这个程序了，复制进去能跑就行吧
program main
  implicit none
  integer, parameter::stnN = 160, Year_start = 1951, Year_end = 2021
  integer, parameter::YearN = Year_end - Year_start + 1, month_N = 3
  real::satAvg(stnN, YearN - 1), easmiAvg(70)
  external getSatAvg, getAvgEASMI, getCorrelationCoefficient
  integer i, j
  call getSatAvg(stnN, YearN, satAvg)
  call getAvgEASMI(easmiAvg)
  call getCorrelationCoefficient(satAvg, easmiAvg)
end program

! 获得各测站每年夏季平均降水
subroutine getSatAvg(stnN, YearN, satAvg)
  integer, intent(in) :: stnN, YearN
  real::sat6(stnN, YearN), sat7(stnN, YearN), sat8(stnN, YearN)
  real, intent(out)::satAvg(stnN, YearN)
  external loadMonthR
  call loadMonthR(stnN, YearN, 'r1606.txt', sat6)
  call loadMonthR(stnN, YearN, 'r1607.txt', sat7)
  call loadMonthR(stnN, YearN, 'r1608.txt', sat8)
  satAvg = (sat6 + sat7 + sat8)/3
end subroutine getSatAvg

! 读取各测站对应月份降水，跳过最后一年（2021）
subroutine loadMonthR(stnN, YearN, fileName, retval)
  integer, intent(in) :: stnN, YearN
  character*9 fileName
  real temp(stnN, YearN)
  real, intent(out)::retval(stnN, YearN - 1)
  integer::stn_i, Year_i, i, j
  open (11, file=filename)
  read (11, *) ((temp(stn_i, Year_i), stn_i=1, stnN), Year_i=1, YearN)
  close (11)
  ! 讨厌的遍历
  do i = 1, stnN
    ! 这样跳过2021
    do j = 1, YearN - 1
      ! 降水量要÷10
      retval(i, j) = temp(i, j)/10
    end do
  end do
end subroutine loadMonthR

! 获取各年平均EASMI，不要把自己当编译器，结果是对的，只管运行就好
subroutine getAvgEASMI(easmiAvg)
  real EASMI_input(70, 3)
  real, intent(out)::easmiAvg(70)
  open (10, file='EASMI_ForClass.txt')
  ! 重复读三次来移动读取指针，从而跳过 1948-1950
  read (10, *) (EASMI_input(1, month_i), month_i=1, 3)
  read (10, *) (EASMI_input(1, month_i), month_i=1, 3)
  read (10, *) (EASMI_input(1, month_i), month_i=1, 3)
  ! 前面写到的地方这里会覆盖掉，所以结果是对的
  read (10, *) ((EASMI_input(year_i, month_i), month_i=1, 3), year_i=1, 70)
  close (10)
  easmiAvg = SUM(EASMI_input, dim=2)/3
end subroutine getAvgEASMI

! 获取各站点相关系数
subroutine getCorrelationCoefficient(satAvg, easmiAvg)
  real, intent(in)::satAvg(160, 70), easmiAvg(70)
  ! 原谅我实在不知道怎么起名了
  real satAvgAvg(160), easmiAvgAvg, correlationCoefficient(160)
  real numerator(160), denominator(160), satAvgVar(160), easmiAvgVar, readFromDAT(160)
  integer i, j
  satAvgAvg = SUM(satAvg, dim=2)/70
  easmiAvgAvg = SUM(easmiAvg)/70
  easmiAvgVar = SUM((easmiAvg - easmiAvgAvg)**2)
  ! 天天 do i 对身体不好，奈何我也不会用那些高级的函数
  do i = 1, 160
    do j = 1, 70
      numerator(i) = numerator(i) + (satAvg(i, j) - satAvgAvg(i))*(easmiAvg(j) - easmiAvgAvg)
      satAvgVar(i) = satAvgVar(i) + (satAvg(i, j) - satAvgAvg(i))**2
    end do
  end do
  correlationCoefficient = numerator/sqrt(easmiAvgVar*satAvgVar)
  do i = 1, 160
    print *, "The correlation coefficient of station", i, "is", correlationCoefficient(i)
  end do
  open (114, file="internship4-result.txt")
  open (514, file="internship4-result.dat", form="binary")
  write (114, *), correlationCoefficient
  write (514), correlationCoefficient
  close (114)
  close (514)
  ! 输出读取结果来验证二进制文件写入格式是对的，文本的就不验证了，直接能打开看
  open (1919, file="internship4-result.dat", form="binary")
  read (1919) readFromDAT
  close (1919)
  print *, readFromDAT
end subroutine getCorrelationCoefficient
