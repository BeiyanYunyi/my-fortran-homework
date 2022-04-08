program main
  implicit none
  external normalizer
  integer month_N, year_N
  parameter(year_N=73, month_N=3)
  integer year_i, month_i
  real EASMI_input(year_N, month_N)
  real EASMI_JJA(year_N)
  real EASMI_JJA_norm(year_N)

  !Data input
  open (10, file='EASMI_ForClass.txt')
  do year_i = 1, year_N
    read (10, *) (EASMI_input(year_i, month_i), month_i=1, month_N)
  end do
  close (10)

  !****************************************
  !请补充主程序，计算夏季平均EASMI
  !****************************************

  EASMI_JJA = SUM(EASMI_input, dim=2)/3
  print *, "夏季平均EASMI："
  do year_i = 1, year_N
    print *, EASMI_JJA(year_i)
  end do

  !****************************************
  !请补充主程序，调用子程序normalizer进行标准化处理
  !****************************************
  call normalizer(EASMI_JJA, EASMI_JJA_norm, year_N)
  print *, "标准化值："
  do year_i = 1, year_N
    print *, EASMI_JJA_norm(year_i)
  end do
  !****************************************
  !将标准化的EASMI序列输出至文本文件
  !****************************************
  open (11, file="internship3-result.txt")
  do year_i = 1, year_N
    write (11, *) EASMI_JJA_norm(year_i)
  end do
  close (11)
end program

!****************************************
!整个子程序一个遍历也没用到，哈哈
!****************************************
subroutine normalizer(EASMI_JJA, EASMI_JJA_norm, year_N)
  integer, intent(in)::year_N
  real, intent(in)::EASMI_JJA(year_N)
  real, intent(out)::EASMI_JJA_norm(year_N)
  real ::avg, std_dev
  avg = sum(EASMI_JJA)/year_N
  std_dev = sqrt(sum((EASMI_JJA - avg)**2)/year_N)
  EASMI_JJA_norm = (EASMI_JJA - avg)/std_dev
end subroutine normalizer
