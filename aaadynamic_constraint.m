function [dynamic]=aaadynamic_constraint(X,slip)

m=slip.m;
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


tal_left=[ltal1;ltal2;ltal3];
tal_right=[rtal1;rtal2;rtal3];

z_l_arm=[lq1;lq2;lq3;lqd1;lqd2;lqd3];
z_2_arm=[rq1;rq2;rq3;rqd1;rqd2;rqd3];


F1=[Flx;Fly];
F2=[Frx;Fry];

z_l_armdot=rhs_3link1(0,z_l_arm,slip,1,-F1,tal_left);
z_l_armdotdot=[lqd1;lqd2;lqd3;lqdd1;lqdd2;lqdd3];
dynamic1=z_l_armdot-z_l_armdotdot;

z_2_armdot=rhs_3link2(0,z_2_arm,slip,1,-F2,tal_right);
z_2_armdotdot=[rqd1;rqd2;rqd3;rqdd1;rqdd2;rqdd3];
dynamic2=z_2_armdot-z_2_armdotdot;

F_man=F1+F2;
Fc=[-100*dx;-100*dy];

dynamic3=[ddx-(Fc(1)+F_man(1))/m;
ddy-(Fc(2)+F_man(2))/m];

dynamic = [dynamic1;dynamic2;dynamic3];