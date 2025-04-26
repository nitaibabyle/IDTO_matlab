function [chafen_yueshu]=opt_discrete_constraint(MMM,slip)
global T
for i=1:20
    Qdd_Qd_q_t(:,i)=MMM(1+(i-1)*24:24*i);
    ut(:,i)=MMM(481+(i-1)*6:480+6*i);
    for j=1:8
        Qdd_t(i,j)=Qdd_Qd_q_t(3*j,i);
        Qd_t(i,j)=Qdd_Qd_q_t(3*j-1,i);
        Q_t(i,j)=Qdd_Qd_q_t(3*j-2,i);
    end
end

time=MMM(681);
Time=T;
dt=Time/19;

for i=1:19
    chafen_yueshu1(1+(i-1)*8:8*i,1)=Q_t(i+1,:)'-Q_t(i,:)'-(Qd_t(i,:)'+Qd_t(i+1,:)')*dt/2;
    chafen_yueshu2(1+(i-1)*8:8*i,1)=Qd_t(i+1,:)'-Qd_t(i,:)'-(Qdd_t(i,:)'+Qdd_t(i+1,:)')*dt/2;
end
chafen_yueshu=[chafen_yueshu1;chafen_yueshu2];
