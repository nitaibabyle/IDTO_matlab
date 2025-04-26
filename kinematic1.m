function [P1, P2,P3,V1,V2,V3]=kinematic1(z,slip)
q1 = z(1);
qd1 = z(4);
q2 = z(2);
qd2 = z(5);
q3 = z(3);
qd3 = z(6);

l1=slip.l1;
l2=slip.l2;
l3=slip.l3;

P1 =[l1*cos(q1);
l1*sin(q1)];

P2 =[l2*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) + l1*cos(q1);
l2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + l1*sin(q1)];

P3 =[l2*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) + l1*cos(q1) + l3*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)));
l2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + l1*sin(q1) + l3*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)))];
 
V1 =[-l1*qd1*sin(q1);
 l1*qd1*cos(q1)];
 
V2 =[- qd1*(l2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + l1*sin(q1)) - l2*qd2*(cos(q1)*sin(q2) + cos(q2)*sin(q1));
  qd1*(l2*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) + l1*cos(q1)) + l2*qd2*(cos(q1)*cos(q2) - sin(q1)*sin(q2))];
 
V3 =[- qd2*(l2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + l3*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)))) - qd1*(l2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + l1*sin(q1) + l3*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)))) - l3*qd3*(cos(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + sin(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)));
  qd2*(l2*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) + l3*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)))) + qd1*(l2*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) + l1*cos(q1) + l3*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)))) + l3*qd3*(cos(q3)*(cos(q1)*cos(q2) - sin(q1)*sin(q2)) - sin(q3)*(cos(q1)*sin(q2) + cos(q2)*sin(q1)))];