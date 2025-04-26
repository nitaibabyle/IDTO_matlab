function zdot=rhs_3link1(T,z,slip,t,F,tal)   

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


q1 = z(1);  
q2 = z(2);
q3 = z(3);
qd1=z(4);
qd2=z(5);
qd3=z(6);
qd=[qd1;qd2;qd3];
tal1=tal(1);tal2=tal(2);tal3=tal(3);

t=1;
Jcontact1 =[- l2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) - l1*sin(q1) - l3*t*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2))), - l2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) - l3*t*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2))), -l3*t*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)));
    l2*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) + l1*cos(q1) + l3*t*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1))),   l2*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) + l3*t*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1))),  l3*t*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)))];
 

M1 =[I1 + I2 + I3 + a1^2*m1 + a2^2*m2 + a3^2*m3 + l1^2*m2 + l1^2*m3 + l2^2*m3 + 2*a3*l1*m3*cos(q2 + q3) + 2*a2*l1*m2*cos(q2) + 2*a3*l2*m3*cos(q3) + 2*l1*l2*m3*cos(q2), m2*a2^2 + l1*m2*cos(q2)*a2 + m3*a3^2 + 2*m3*cos(q3)*a3*l2 + l1*m3*cos(q2 + q3)*a3 + m3*l2^2 + l1*m3*cos(q2)*l2 + I2 + I3, I3 + a3^2*m3 + a3*l1*m3*cos(q2 + q3) + a3*l2*m3*cos(q3);
    m2*a2^2 + l1*m2*cos(q2)*a2 + m3*a3^2 + 2*m3*cos(q3)*a3*l2 + l1*m3*cos(q2 + q3)*a3 + m3*l2^2 + l1*m3*cos(q2)*l2 + I2 + I3,                                                               m2*a2^2 + m3*a3^2 + 2*m3*cos(q3)*a3*l2 + m3*l2^2 + I2 + I3,                         m3*a3^2 + l2*m3*cos(q3)*a3 + I3;
    I3 + a3^2*m3 + a3*l1*m3*cos(q2 + q3) + a3*l2*m3*cos(q3),                                                                                          m3*a3^2 + l2*m3*cos(q3)*a3 + I3,                                            m3*a3^2 + I3];
 
 
RHS1 =[tal1 + a3*l1*m3*qd2^2*sin(q2 + q3) + a3*l1*m3*qd3^2*sin(q2 + q3) + a2*l1*m2*qd2^2*sin(q2) + a3*l2*m3*qd3^2*sin(q3) + l1*l2*m3*qd2^2*sin(q2) + 2*a3*l1*m3*qd1*qd2*sin(q2 + q3) + 2*a3*l1*m3*qd1*qd3*sin(q2 + q3) + 2*a3*l1*m3*qd2*qd3*sin(q2 + q3) + 2*a2*l1*m2*qd1*qd2*sin(q2) + 2*a3*l2*m3*qd1*qd3*sin(q3) + 2*a3*l2*m3*qd2*qd3*sin(q3) + 2*l1*l2*m3*qd1*qd2*sin(q2);
                                                                                                                                                                                              tal2 - a3*l1*m3*qd1^2*sin(q2 + q3) - a2*l1*m2*qd1^2*sin(q2) + a3*l2*m3*qd3^2*sin(q3) - l1*l2*m3*qd1^2*sin(q2) + 2*a3*l2*m3*qd1*qd3*sin(q3) + 2*a3*l2*m3*qd2*qd3*sin(q3);
                                                                                                                                                                                                                                                    tal3 - a3*l1*m3*qd1^2*sin(q2 + q3) - a3*l2*m3*qd1^2*sin(q3) - a3*l2*m3*qd2^2*sin(q3) - 2*a3*l2*m3*qd1*qd2*sin(q3)];
%RHS=RHS+Jcontact'*F;
A1=Jcontact1'*F;
qdd1= M1 \ (RHS1+A1);


zdot=[qd(1) qd(2) qd(3) qdd1(1) qdd1(2) qdd1(3)]';

