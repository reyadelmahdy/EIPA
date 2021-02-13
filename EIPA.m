% ELEC4700 PA5
% Reyad ElMahdy
% 101064879

clc;close all;clear
% Creating the matrix
nx=50;
ny=50;
G=sparse(nx*ny,nx*ny);

for i=1:nx
    for j=1:ny
        n=j+(i-1)*ny; % Node mapping equation
        if (i==1||i==nx||j==1||j==ny)
            G(n,:)=0; % Setting BCs to 0
            G(n,n)=1; % Setting the diagonal to 1
        else
            G(n,n)=-4;
            G(n,n+1)=1;
            G(n,n-1)=1;
            G(n,n+ny)=1;
            G(n,n-ny)=1;
        end
        if (i > 10 && i < 20 && j > 10 && j < 20)
            %G(n,n)=-2; trying -2 insteaad of -4 in the matrix diagonals
        end
    end
end
% Plotting the nonzero elements of the matrix
figure(1)
spy(G)

% Finding Eigenvalues and vectors
[E, D]=eigs(G,9,'SM');
figure(2)
plot(diag(D),'x')
EV=zeros(nx,ny);

figure(3)
for k=1:9
    modes=E(:,k);
    for i=1:nx
        for j=1:ny
            n=j+(i-1)*ny; % Node mapping equation
            EV(i,j)=modes(n);
        end
    end
    % Plotting the eigen vectors
    subplot(3,3,k);
    surf(EV)
    title(num2str(D(k,k)))
end