
function ranf()
!----------------------------------------------!
! 64-bit congruental generator                 !
! iran64=oran64*2862933555777941757+1013904243 !
!----------------------------------------------!
implicit none
real(kind=8) :: ranf
real(kind=8)    :: dmu64
integer(kind=8) :: ran64,mul64,add64

common/bran64/dmu64,ran64,mul64,add64

ran64=ran64*mul64+add64
ranf=0.5d0+dmu64*dble(ran64)

end function ranf
!----------------!

!---------------------!
subroutine initran(w)
!---------------------!
implicit none

integer(kind=8) :: irmax
integer(kind=8) :: w,IO

real(kind=8)    :: dmu64
integer(kind=8) :: ran64,mul64,add64
common/bran64/dmu64,ran64,mul64,add64
      
irmax=2_8**31
irmax=2*(irmax**2-1)+1
mul64=2862933555777941757_8
add64=1013904243
dmu64=0.5d0/dble(irmax)

ran64=w

! open(10,file='seed.in',status='old')
! read(10,*) ran64
! close(10)


! IO=1
! do while(IO.ne.0)
! open(11,file="seed.in.lock",status="new",IOstat=IO)
! if(IO.eq.0) then
! open(10,file='seed.in',status='old')
! write(10,*)abs((ran64*mul64)/5+5265361)
! close(10)
! close(11,status="delete")
! else
! close(11)
! end if
! end do


! if (w.ne.0) then
! IO=1
! do while(IO.ne.0)
! open(11,file="seed.in.lock",status="new",IOstat=IO)
! if(IO.eq.0) then
! open(10,file='seed.in',status='old')
! write(10,*)abs((ran64*mul64)/5+5265361)
! close(10)
! close(11,status="delete")
! else
! close(11)
! end if
! end do
! end if

end subroutine initran
!----------------------!
