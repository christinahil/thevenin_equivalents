function [Z,lu_factors] = Zcs_KLU_gtc_3(A)
% lu_factors : factors from KLU factorization
% Z : thevenin impedances

lu_factors = klu(A.nc);

% lu_factors.L : Lower triangular factor of diagonal blocks only
% lu_factors.U : Upper triangular factor of diagonal blocks only
% lu_factors.F : Triangular factors of off-diagonal blocks -
%                zero for symmetric sqaure matrix with zero-free diagonal
% lu_factors.R : diagonal matrix of row - scale factors
% lu_factors.p : row pivot vector
% lu_factors.q : column pivot vector
% lu_factors.r : block boundaries

% Ync(LU.p,LU.q) - LU.R*LU.L*LU.U

ncnodes = length(A.nc);
vcnodes = length(A.vc);

eye_nc = speye(ncnodes);

Z_cs_u = (lu_factors.R*lu_factors.L) \ eye_nc(lu_factors.p,:);
Z_cs_l_t = lu_factors.U.' \ eye_nc(:,lu_factors.q).';

Z_cs_l = Z_cs_l_t.';

Zth_cs = ones(ncnodes,1);
Zth_vs = ones(vcnodes,1);

parfor i=1:ncnodes
   Zth_cs(i) =  Z_cs_l(i,:)*Z_cs_u(:,i); 
end

parfor  i=1:vcnodes
    U_hat = klu(lu_factors,'\',full(A.link(:,i)));
    U_i = A.vc(i,i)-A.link_T(i,:)*U_hat;
    Zth_vs(i) = U_i^(-1);
end

Z = [Zth_cs ; Zth_vs];

end
