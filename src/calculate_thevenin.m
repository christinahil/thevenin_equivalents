function [V] = calculate_thevenin(A,Z,lu_factors)
% V : Thevenin impedances
% t : time spend on calculations

nc_nodes = size(A.nc,1);
Vvs = A.V0(nc_nodes+1:end);
Ics = A.I0(1:nc_nodes);

Zth_cs = Z(1:nc_nodes);
Zth_vs = Z(nc_nodes+1:end);

Ics_con = klu(lu_factors,'\',Ics);
Vcs_con = klu(lu_factors,'\',-A.link*Vvs);

Vth_cs = Vcs_con + Ics_con-Zth_cs.*Ics;
Vth_vs = Vvs-Zth_vs.*(A.vc*Vvs+A.link_T*(Vcs_con+Ics_con));

V = [Vth_cs ; Vth_vs];

end
