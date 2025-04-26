function f=objective(MMM,slip)
for i=1:20
    Qdd_Qd_q_t(:,i)=MMM(1+(i-1)*24:24*i);
    ut(:,i)=MMM(481+(i-1)*6:480+6*i);
    Flt(:,i)=MMM(601+(i-1)*2:600+2*i);
    Frt(:,i)=MMM(641+(i-1)*2:640+2*i);
    X(:,i)=[Qdd_Qd_q_t(:,i);ut(:,i);Flt(:,i);Frt(:,i)];
end
%% define objective fun
obj=0;
%% transfor obj
for j=1:19
    obj=obj+1*force_track_obj(X(:,j),slip);%contact force tracking error minimal
    %obj=obj+10*force_mini_obj(X(:,i),slip);%contact force minimal
    %obj=obj+1*ut(:,i)'*ut(:,i);%input minimal
    obj=obj+100*state_obj(X(:,j+1),slip);%state tracking error minimal
end
%%
f=obj;



