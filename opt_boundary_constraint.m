function [bianjie_tiaojian]=opt_boundary_constraint(MMM,slip)
global z_0 z_ed
for i=1:20
    Qdd_Qd_q_t(:,i)=MMM(1+(i-1)*24:24*i);
end
for i=1:8
    if i<=2
        c(1+(i-1)*3:3*i)=[1,1,0];
    else
        c(1+(i-1)*3:3*i)=[0,0,0];
    end
end
b=diag(c);

for i=1:8
    d(1+(i-1)*3:3*i)=[1,1,0];
end
a=diag(d);

bianjie_tiaojian=[(Qdd_Qd_q_t(:,20)-z_ed');a*(Qdd_Qd_q_t(:,1)-z_0')];

