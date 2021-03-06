%PA 5- Sarah Dolan
set(0,'DefaultFigureWindowStyle','docked')

nx = 50;
ny = 50;
V = zeros(nx, ny);
G = sparse(nx*ny, nx*ny);

dx = 1;
dx2 = dx^2;

%boundary conditions

BC_top = 0;
BC_bottom = 0;
BC_left = 0;
BC_right = 0;

for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        if i == 1 
            G(n, :) = 0;
            G(n,n) = 1;
       
        elseif i == nx 
            G(n, :) = 0;
            G(n,n) = 1;
      
        elseif j == 1
            nxm = j + (i-2)*ny;
            nxp = j+(i)*ny;
            nyp = j+1+(i-1)*ny;

            G(n,n) =  -4/dx2;
            G(n,nxm) = 1/dx2;
            G(n,nxp) = 1/dx2;
            G(n,nyp) = 1/dx2;
        

        elseif j ==  ny
            nxm = j + (i - 2) * ny;
            nxp = j + (i) * ny;
            nym = j - 1 + (i - 1) * ny;
           
            G(n,n) = -4/dx2 ;
            G(n,nxm) = 1/dx2;
            G(n,nxp) = 1/dx2;
            G(n,nym) = 1/dx2;



         else
            nxm = j + (i-2)*ny;
            nxp = j + (i)*ny;
            nym = j-1 + (i-1)*ny;
            nyp = j+1 + (i-1)*ny;

            G(n,n) = -4/dx2 ;
            G(n,nxm) = 1/dx2;
            G(n,nxp) = 1/dx2;
            G(n,nym) = 1/dx2;
            G(n,nyp) = 1/dx2;


        end
    end

end


figure('name', 'Matrix')
spy(G)


nmodes = 9;
[E,D] = eigs(G, nmodes, 'SM');
figure('name', 'EigenValues')
plot (diag(D), '*');

np = ceil (sqrt(nmodes));
figure ('name','Modes')
for k = 1:nmodes
    M = E(:,k);
    for i = 1:nx
        for j = 1:ny
            n = j +(j-1)*nx;
            V(i,j) = M(n);
        end
        subplot(np,np,k), surf(V, 'linestyle','none')
        title(['EV = ' num2str(D(k,k))])
    end
end




