program ex1
  implicit none
  integer i, t
  external sum, times
  integer sum, times
  i = sum()
  t = times()
  print *, "求和结果", i
  print *, "求积结果", t
end program ex1

function sum()
  integer n, i, a, sum
  print *, "输入要求和的数字个数"
  read *, n
  sum = 0
  do i = 1, n
    print *, "输入第", i, "个数字"
    read *, a
    sum = sum + a
  end do
end

function times()
  integer n, i, a, times
  print *, "输入要求积的数字个数"
  read *, n
  times = 1
  do i = 1, n
    print *, "输入第", i, "个数字"
    read *, a
    times = times*a
  end do
end
