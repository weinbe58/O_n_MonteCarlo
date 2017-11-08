

subroutine hybrid(N,d,spins,z,NN,nd,dims,measure,NMs,NM,Ms,beta,Jc,mcsteps,nwolff,nmetrop,dm,f_id,h)
implicit none
integer(kind=4), intent(in) :: N,d,nd,z,mcsteps,NM,NMs,dm,f_id,nwolff,nmetrop
logical(kind=4), intent(in) :: measure
real(kind=8), intent(in) :: beta,Jc,h
real(kind=8), intent(inout), dimension(0:N-1,0:d-1) :: spins
real(kind=8), intent(inout), dimension(0:NMs-1,NM) :: Ms
integer(kind=4), intent(in), dimension(0:N-1,0:z-1) :: NN
integer(kind=4), intent(in), dimension(0:nd-1) :: dims
real(kind=8), dimension(0:d-1) :: spin,diff
integer(kind=4), dimension(0:N-1) :: c
real(kind=8), external :: ranf,local
integer(kind=4) :: i,j,k,l,o
real(kind=8) :: dE,P

Ms = 0.0d0

do i=0,mcsteps

! monte carlo step
do j=0,nmetrop*N-1

k = floor(N*ranf())

select case(d)
case(1)
spin = -spins(k,:)
case default
call random_spin(d,spin)
end select


!print*, k,datan2(spins(k,1),spins(k,0)),datan2(spin(1),spin(0))
dE=0.0d0

dE = dE + local(d,spin,spins(k,:),f_id,h)
diff = spin - spins(k,:)
do l=0,z-1
if(NN(k,l) .ge. 0) then
o = NN(k,l)
dE = dE + Jc*dot_product(spins(o,:),diff)
end if
end do

P=min(1.0d0,dexp(-beta*dE))


if(ranf() .lt. P) then
spins(k,:) = spin
end if

end do

do j=0,nwolff-1

select case(d)
case(1)
spin = 1
case default
call random_spin(d,spin)
end select
! reset cluster marker
c = 0

k=int(floor(ranf()*N))
call flip_cluster(N,d,spins,z,NN,beta,Jc,f_id,h,spin(0:0),k,c,.false.)

end do


! measure
if(modulo(i,dm) .eq. 0 .and. measure) then
call measure_local(N,d,NN,nd,dims,spins,NM,Ms(i/dm,:),f_id)
end if

end do


end subroutine


subroutine hybrid_aniso(N,d,spins,z,NN,nd,dims,measure,NMs,NM,Ms,beta,Jc,delta,mcsteps,nwolff,nmetrop,dm,f_id,h)
implicit none
integer(kind=4), intent(in) :: N,d,nd,z,mcsteps,NM,NMs,dm,f_id,nwolff,nmetrop
logical(kind=4), intent(in) :: measure
real(kind=8), intent(in) :: beta,Jc,h,delta
real(kind=8), intent(inout), dimension(0:N-1,0:d-1) :: spins
real(kind=8), intent(inout), dimension(0:NMs-1,NM) :: Ms
integer(kind=4), intent(in), dimension(0:N-1,0:z-1) :: NN
integer(kind=4), intent(in), dimension(0:nd-1) :: dims
real(kind=8), dimension(0:d-1) :: spin,diff
real(kind=8), dimension(0:N-1) :: spinsz
integer(kind=4), dimension(0:N-1) :: c
real(kind=8), external :: ranf,local
integer(kind=4) :: i,j,k,l,o
real(kind=8) :: dE,P,diff_delta

Ms = 0.0d0

diff_delta = delta - Jc

do i=0,mcsteps

! monte carlo step
do j=0,nmetrop*N-1

k = floor(N*ranf())

select case(d)
case(1)
spin = -spins(k,:)
case default
call random_spin(d,spin)
end select


!print*, k,datan2(spins(k,1),spins(k,0)),datan2(spin(1),spin(0))
dE=0.0d0

dE = dE + local(d,spin,spins(k,:),f_id,h)
diff = spin - spins(k,:)
do l=0,z-1
if(NN(k,l) .ge. 0) then
o = NN(k,l)
dE = dE + Jc*dot_product(spins(o,:),diff) + diff_delta*spins(o,d-1)*diff(d-1)
end if
end do

P=min(1.0d0,dexp(-beta*dE))


if(ranf() .lt. P) then
spins(k,:) = spin
end if

end do

spin=1
spinsz(:) = sign(1.0d0,spins(:,d-1))

do j=0,nwolff-1

! reset cluster marker
c = 0
k=int(floor(ranf()*N))
call flip_cluster(N,1,spinsz,z,NN,beta,delta,f_id,h,spin(0:0),k,c,.false.)

end do

spins(:,d-1) = sign(spins(:,d-1),spinsz)

! measure
if(modulo(i,dm) .eq. 0 .and. measure) then
call measure_local(N,d,NN,nd,dims,spins,NM,Ms(i/dm,:),f_id)
end if

end do


end subroutine





