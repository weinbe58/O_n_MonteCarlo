
function i_pop(stack,N)
implicit none
integer(kind=4) :: i_pop
integer(kind=4), intent(in) :: N
integer(kind=4), intent(inout), dimension(0:N) :: stack
integer(kind=4) :: top


top=int(stack(0),4)
if(top.gt.0) then
i_pop=stack(top)
stack(top)=0
top=top-1
stack(0)=int(top)
else
i_pop=0
end if

end function

function f_pop(stack,N)
implicit none
real(kind=8) :: f_pop
integer(kind=4), intent(in) :: N
real(kind=8), intent(inout), dimension(0:N) :: stack
integer(kind=4) :: top


top=int(stack(0),4)
if(top.gt.0) then
f_pop=stack(top)
stack(top)=0
top=top-1
stack(0)=float(top)
else
f_pop=0
end if

end function






subroutine i_append(stack,N,element)
implicit none
integer(kind=4), intent(in) ::  element
integer(kind=4), intent(in) :: N
integer(kind=4), intent(inout), dimension(0:N) :: stack
integer(kind=4) :: top

top=int(stack(0),4)
if(top+1.gt.N) then
print*, "stack overflow"
stop
else
top=top+1
stack(top)=element
stack(0)=int(top)
end if

end subroutine





subroutine f_append(stack,N,element)
implicit none
real(kind=8), intent(in) ::  element
integer(kind=4), intent(in) :: N
real(kind=8), intent(inout), dimension(0:N) :: stack
integer(kind=4) :: top

top=int(stack(0),4)
if(top+1.gt.N) then
print*, "stack overflow"
stop
else
top=top+1
stack(top)=element
stack(0)=float(top)
end if

end subroutine








