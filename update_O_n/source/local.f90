

function local(d,spin_f,spin_i,f_id,h)
implicit none
real(kind=8) :: local
integer(kind=4), intent(in) :: f_id,d
real(kind=8), intent(in), dimension(0:d-1) :: spin_i,spin_f
real(kind=8), intent(in) :: h
real(kind=8), external :: Zq

local = 0.0d0
select case (d)
case(1)
select case(f_id)
case(1)
local = h*(spin_f(0)-spin_i(0))
case default 
local=0.0d0
end select

case(2)
select case(f_id)
case(1)
local = h * Zq(1,d,spin_f,spin_i)
case(2)
local = h * Zq(2,d,spin_f,spin_i)
case(3)
local = h * Zq(3,d,spin_f,spin_i)
case(4)
local = h * Zq(4,d,spin_f,spin_i)
case(5)
local = h * Zq(5,d,spin_f,spin_i)
case(6)
local = h * Zq(6,d,spin_f,spin_i)
case(7)
local = h * Zq(7,d,spin_f,spin_i)
case(8)
local = h * Zq(8,d,spin_f,spin_i)
case(9)
local = h * Zq(9,d,spin_f,spin_i)
case(10)
local = h * Zq(10,d,spin_f,spin_i)
case default 
local=0.0d0
end select

case default
local = 0.0d0
end select



end function











function Zq(q,d,spin_f,spin_i)
implicit none
real(kind=8) :: Zq
integer(kind=4), intent(in) :: d,q
real(kind=8), intent(in), dimension(0:d-1) :: spin_f,spin_i
real(kind=8) :: t1,t2

t1 = datan2(spin_i(1),spin_i(0))
t2 = datan2(spin_f(1),spin_f(0))
Zq = dcos(q*t2) - dcos(q*t1)


end function




