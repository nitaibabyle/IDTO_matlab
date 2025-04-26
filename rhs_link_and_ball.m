function zdot=rhs_link_and_ball(T,z,slip,t,F)   

l3=slip.l3;
l2=slip.l2;
l1=slip.l1;
m1=slip.m3;
m2=slip.m2;
m3=slip.m1;

a1=slip.a3;
a2=slip.a2;
a3=slip.a1;
I1=slip.I1;
I2=slip.I2;
I3=slip.I3;

m=slip.m;
I=slip.I;


mu=0.6;
mu_omega=mu*slip.R*2/3;

x=z(1);
y=z(2);
phi=z(3);
dx=z(4);
dy=z(5);
dphi=z(6);

q1 = z(7);  
q2 = z(8);
q3 = z(9);
qd1=z(10);
qd2=z(11);
qd3=z(12);
qd=[qd1;qd2;qd3];

tal1=-1;tal2=-2;tal3=-2;
t=1;

P3 =[l2*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) + l1*cos(q1) + l3*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)));
l2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + l1*sin(q1) + l3*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)))];

V3 =[- qd2*(l2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + l3*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)))) - qd1*(l2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + l1*sin(q1) + l3*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)))) - l3*qd3*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)));
  qd2*(l2*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) + l3*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)))) + qd1*(l2*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) + l1*cos(q1) + l3*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)))) + l3*qd3*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)))];

%F=P3,V3,x,y,dx,dy;
Jcontact =[- l2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) - l1*sin(q1) - l3*t*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2))), - l2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) - l3*t*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2))), -l3*t*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)));
    l2*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) + l1*cos(q1) + l3*t*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1))),   l2*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) + l3*t*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1))),  l3*t*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)))];
 

M =[I1 + I2 + I3 + a1^2*m1 + a2^2*m2 + a3^2*m3 + l1^2*m2 + l1^2*m3 + l2^2*m3 + 2*a3*l1*m3*cos(q2 + q3) + 2*a2*l1*m2*cos(q2) + 2*a3*l2*m3*cos(q3) + 2*l1*l2*m3*cos(q2), m2*a2^2 + l1*m2*cos(q2)*a2 + m3*a3^2 + 2*m3*cos(q3)*a3*l2 + l1*m3*cos(q2 + q3)*a3 + m3*l2^2 + l1*m3*cos(q2)*l2 + I2 + I3, I3 + a3^2*m3 + a3*l1*m3*cos(q2 + q3) + a3*l2*m3*cos(q3);
    m2*a2^2 + l1*m2*cos(q2)*a2 + m3*a3^2 + 2*m3*cos(q3)*a3*l2 + l1*m3*cos(q2 + q3)*a3 + m3*l2^2 + l1*m3*cos(q2)*l2 + I2 + I3,                                                               m2*a2^2 + m3*a3^2 + 2*m3*cos(q3)*a3*l2 + m3*l2^2 + I2 + I3,                         m3*a3^2 + l2*m3*cos(q3)*a3 + I3;
    I3 + a3^2*m3 + a3*l1*m3*cos(q2 + q3) + a3*l2*m3*cos(q3),                                                                                          m3*a3^2 + l2*m3*cos(q3)*a3 + I3,                                            m3*a3^2 + I3];
 
 
RHS =[tal1 + a3*l1*m3*qd2^2*sin(q2 + q3) + a3*l1*m3*qd3^2*sin(q2 + q3) + a2*l1*m2*qd2^2*sin(q2) + a3*l2*m3*qd3^2*sin(q3) + l1*l2*m3*qd2^2*sin(q2) + 2*a3*l1*m3*qd1*qd2*sin(q2 + q3) + 2*a3*l1*m3*qd1*qd3*sin(q2 + q3) + 2*a3*l1*m3*qd2*qd3*sin(q2 + q3) + 2*a2*l1*m2*qd1*qd2*sin(q2) + 2*a3*l2*m3*qd1*qd3*sin(q3) + 2*a3*l2*m3*qd2*qd3*sin(q3) + 2*l1*l2*m3*qd1*qd2*sin(q2);
                                                                                                                                                                                              tal2 - a3*l1*m3*qd1^2*sin(q2 + q3) - a2*l1*m2*qd1^2*sin(q2) + a3*l2*m3*qd3^2*sin(q3) - l1*l2*m3*qd1^2*sin(q2) + 2*a3*l2*m3*qd1*qd3*sin(q3) + 2*a3*l2*m3*qd2*qd3*sin(q3);
                                                                                                                                                                                                                                                    tal3 - a3*l1*m3*qd1^2*sin(q2 + q3) - a3*l2*m3*qd1^2*sin(q3) - a3*l2*m3*qd2^2*sin(q3) - 2*a3*l2*m3*qd1*qd2*sin(q3)];
%RHS=RHS+Jcontact'*F;
A=Jcontact'*(-F);
qlinkdd= M \ (RHS+A);

Fc=[-50*dx;-50*dy;-50*dphi];

ddx=(Fc(1)+F(1))/m;
ddy=(Fc(2)+F(2))/m;

F(3)=F(1)*
ddphi=(Fc(3)+F(3))/I;

qballdd(1)=ddx;
qballdd(2)=ddy;
qballdd(3)=ddphi;

zdot=[dx dy dphi qballdd(1) qballdd(2) qballdd(3) qd1 qd2 qd3 qlinkdd(1) qlinkdd(2) qlinkdd(3)]';

