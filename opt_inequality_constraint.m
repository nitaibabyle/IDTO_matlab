function [budengshi_constraint]=opt_inequality_constraint(MMM,slip) 
for i=1:20
    Qdd_Qd_q_t(:,i)=MMM(1+(i-1)*24:24*i);
    ut(:,i)=MMM(481+(i-1)*6:480+6*i);
    Flt(:,i)=MMM(601+(i-1)*2:600+2*i);
    Frt(:,i)=MMM(641+(i-1)*2:640+2*i);
    X(:,i)=[Qdd_Qd_q_t(:,i);ut(:,i);Flt(:,i);Frt(:,i)];
    [budengshi(:,i)]=aaabudengshi_constraint(X(:,i),slip);
end

time=MMM(681);

for i=1:20
    n=length(budengshi(:,i));
    constraint(1+(i-1)*n:n*i,1)=budengshi(:,i);
end
budengshi_constraint=[constraint];

