program main 
implicit none
integer i,j,ni,nj,kk
parameter(ni=61,nj=31)
real*8 :: x(1:ni,1:nj), y(1:ni,1:nj), T(1:ni,1:nj), Tnew(1:ni,1:nj)
real*8 :: beta, dx, dy, res, omega, K(1:ni,1:nj)

do i=1,ni
    do j=1,nj
        x(i,j) = 0.2*real(i-1)/real(ni-1)
        y(i,j) = 0.1*real(j-1)/real(nj-1)
    end do 
end do 

dx = 1.0/real(ni-1)
dy = 1.0/real(nj-1)
beta = dx/dy

print*, "Welcome"
print*, "This program calculates steady 2D conduction in a square plate" 
print*, "---------------------------------------------------------"
print*, "Please input relaxation factor"
read(*,*), omega
print*, "---------------------------------------------------------"

T = 0.d0
Tnew = 0.0

! Material properties (copper)
K = 400.d0

res = 1.d0
do kk=1,20000
    Tnew = T
    do i=2,ni-1
        do j=2,nj-1
            res = 0.d0
            ! Boundary conditions
            ! Adiabatic boundary
            T(i,1) = T(i,2)
            Tnew(i,1) = T(i,2)
            ! Convective boundary
            T(i,nj) = (1/20)*(K(i,j)*((T(i+1,nj)-T(i,nj))/dx)+25)
            Tnew(i,nj) = (1/20)*(K(i,j)*((Tnew(i+1,nj)-Tnew(i,nj))/dx)+25)
            ! Heat flux boundary
            T(1,j) = (-2500/K(i,j))*dx + T(2,j)
            Tnew(1,j) = (-2500/K(i,j))*dx + T(2,j)
            ! Constant temperature boundary
            T(ni,j) = 50.0
            Tnew(ni,j) = 50.0

            Tnew(i,j) = (1-omega)*T(i,j) + omega*(-Tnew(i+1,j)-Tnew(i-1,j)-beta*beta*T(i,j+1)-beta*beta*T(i,j-1))/(-2-2*beta*beta)
            res = res + sqrt(abs(T(i,j) - Tnew(i,j)))
            T(i,j) = Tnew(i,j)
        end do
    end do 
    print *, "Iter =", kk, "Res =", res

    if (res <= 1e-5) then
        exit
    end if
end do 

! Output results
open(1, file='RESULT.dat')
do j=1,nj
    do i=1,ni
        write(1,*) x(i,j), y(i,j), T(i,j)
    end do
end do
close(1)

end program main

