function obj=force_track_obj(X,slip)

x=X(1);
dx=X(2);
ddx=X(3);
y=X(4);
dy=X(5);
ddy=X(6);

lq1=X(7);
lqd1=X(8);
lqdd1=X(9);
lq2=X(10);
lqd2=X(11);
lqdd2=X(12);
lq3=X(13);
lqd3=X(14);
lqdd3=X(15);

rq1=X(16);
rqd1=X(17);
rqdd1=X(18);
rq2=X(19);
rqd2=X(20);
rqdd2=X(21);
rq3=X(22);
rqd3=X(23);
rqdd3=X(24);

ltal1=X(25);
ltal2=X(26);
ltal3=X(27);

rtal1=X(28);
rtal2=X(29);
rtal3=X(30);

Flx=X(31);
Fly=X(32);
Frx=X(33);
Fry=X(34);

z_l_arm=[lq1;lq2;lq3;lqd1;lqd2;lqd3];
z_2_arm=[rq1;rq2;rq3;rqd1;rqd2;rqd3];

[~, ~,lP3,~,~,lV3]=kinematic1(z_l_arm,slip);
[~, ~,rP3,~,~,rV3]=kinematic2(z_2_arm,slip);

Pc=[x;y];
Vc=[dx;dy];
[Fref1,Fref2]=contact_model_optuse(lP3,lV3, rP3,rV3, Pc,Vc, slip);

F1=[Flx;Fly];
F2=[Frx;Fry];

% obj1=(F1'*F1-2*F1'*Fref1);
% obj2=(F2'*F2-2*F2'*Fref2);
obj1=(F1-Fref1)'*(F1-Fref1);
obj2=(F2-Fref2)'*(F2-Fref2);

obj=obj1+obj2;
