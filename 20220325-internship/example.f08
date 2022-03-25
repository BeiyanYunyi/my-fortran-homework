program main
    implicit none
    !根据需要增减调整
    integer, parameter::stnN = 160, Year_start = 1951, Year_end = 2021
    integer, parameter::YearN = Year_end - Year_start + 1
    integer::stn_i, Year_i, max_JAN, max_JUL
    integer i,j,jan_sum
    real::SAT_JAN(stnN, YearN), SAT_JUL(stnN, YearN)
    real::clm_JAN(stnN), clm_JUL(stnN)
    real::variance_JAN(stnN), variance_JUL(stnN)
    real::ave_p1(stnN)=0, ave_p2(stnN)=0, ave_change(stnN)=0
    integer::warming_N=0, colding_N=0
    logical::first30Mask(stnN,YearN)=.false.,last30Mask(stnN,YearN)=.false.
    !Read Data
    open (11, file='t1601.txt')
    read (11, *) ((SAT_JAN(stn_i, Year_i), stn_i=1, stnN), Year_i=1, YearN)
    close (11)
    SAT_JAN = 0.1*SAT_JAN
    open (11, file='t1607.txt')
    read (11, *) ((SAT_JUL(stn_i, Year_i), stn_i=1, stnN), Year_i=1, YearN)
    close (11)
    SAT_JUL = 0.1*SAT_JUL

    !No.1
    clm_JAN = sum(SAT_JAN,2)/YearN
    print*,"Average tempature of every station in January:"
    do i=1,stnN
        print*,i,":",clm_JAN(i)
    end do
    clm_JUL = sum(SAT_JUL,2)/YearN
    print*,"Average tempature of every station in July:"
    do i=1,stnN
        print*,i,":",clm_JUL(i)
    end do
    !No.2
    print*,"Max tempature station:",maxloc(clm_JUL,1),"Tempature:",clm_JUL(maxloc(clm_JUL,1))
    print*,"Min tempature station:",minloc(clm_JAN,1),"Tempature:",clm_JAN(minloc(clm_JAN,1))
    !No.3
    do i=1,stnN
        variance_JAN(i)=0
        do j=1,YearN
            variance_JAN(i)=variance_JAN(i)+((SAT_JAN(i,j)-clm_JAN(i))*(SAT_JAN(i,j)-clm_JAN(i))/YearN)
        end do
    end do
    do i=1,stnN
        variance_JUL(i)=0
        do j=1,YearN
            variance_JUL(i)=variance_JUL(i)+((SAT_JUL(i,j)-clm_JUL(i))*(SAT_JUL(i,j)-clm_JUL(i))/YearN)
        end do
    end do
    print*,"Max variance station in January:",maxloc(variance_JAN,1)
    print*,"Max variance station in July:",maxloc(variance_JUL,1)
    !No.4
    !先初始化两个Mask
    do i=1,stnN
        do j=1,YearN
            if(j.le.30) first30Mask(i,j)=.true.
            if(j>YearN-30) last30Mask(i,j)=.true.
        end do
    end do
    warming_N=0
    colding_N=0
    do i=1,stnN
        ave_p1(i)=0
        ave_p2(i)=0
        ave_change(i)=0
    end do
    ave_p1=sum(SAT_JAN,2,MASK=first30Mask)/30
    ave_p2=sum(SAT_JAN,2,MASK=last30Mask)/30
    ave_change=ave_p2-ave_p1
    do i=1,stnN
        if(ave_change(i)>0) warming_N=warming_N+1
        if(ave_change(i)<0) colding_N=colding_N+1
    end do
    print*,"January: Warming:",warming_N,"Mostly:",maxloc(ave_change,1)
    print*,"January: Colding:",colding_N,"Mostly:",minloc(ave_change,1)
    !No.5
    warming_N=0
    colding_N=0
    do i=1,stnN
        ave_p1(i)=0
        ave_p2(i)=0
        ave_change(i)=0
    end do
    ave_p1=sum(SAT_JUL,2,MASK=first30Mask)/30
    ave_p2=sum(SAT_JUL,2,MASK=last30Mask)/30
    ave_change=ave_p2-ave_p1
    do i=1,stnN
        if(ave_change(i)>0) warming_N=warming_N+1
        if(ave_change(i)<0) colding_N=colding_N+1
    end do
    print*,"January: Warming:",warming_N,"Mostly:",maxloc(ave_change,1)
    print*,"January: Colding:",colding_N,"Mostly:",minloc(ave_change,1)
end program
