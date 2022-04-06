program factorial
  implicit none
  integer res, subb, n
  print *, "想计算哪个数字的阶乘？"
  read *, n
  res = subb(n)
  print *, res

end program factorial

recursive function subb(n) result(res)
  implicit none
  integer:: res, n
  if (n == 1) then
    res = 1
  else
    res = n*subb(n - 1)
  end if
end function subb
