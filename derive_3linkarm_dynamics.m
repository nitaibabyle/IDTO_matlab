close all; clc;clear;

syms q1 q2 q3 qd1 qd2 qd3 qdd1 qdd2 qdd3 'real' % joint angle, angular rate and acceleration
syms l1 l2 l3 a1 a2 a3 'real'             % CoM distance relative to parent joint and link length
syms m1 m2 m3 'real'     % mass of links and motors
syms I1 I2 I3 'real'     % inertia moment of links and motors
syms g 'real'                       % gravatical acceleration
syms tal1 tal2 tal3 'real'   
syms t 'real'  
syms w 'real' 
%%%注意两杆的质心位置，即transformation
%%%matrix还有动能势能的表达写法，
%%%最重要的是在自己定制的坐标系下，角度与角速度要统一，
%%%就是自己定制坐标系肯定存在一个特定的旋转矩阵，后面相应的角速度也应该跟随这一矩阵而调整
%%%主函数中，验证正确性时，用到的能量图像，也应该跟随这样的旋转矩阵而产生相应的调整，
%%%总结一下就是，先检查旋转矩阵、角速度等，derive后不仅更新mm与ff还要更新ke、kp，最终才能完整验证。
%%%20211111 zjt


% unit vectors

i = [1; 0; 0];  j = [0; 1; 0];  k = [0; 0; 1];
% variables vectorization
q = [q1; q2; q3];
qd = [qd1; qd2; qd3];
qdd = [qdd1; qdd2; qdd3];
G = -g * j; % gravity vector

R1=[cos(q1), -sin(q1), 0;
    sin(q1),  cos(q1), 0;
          0,       0, 1];
O1=[w;0;0];
aaaa=[0,0,0,1];

R2=[cos(q2), -sin(q2), 0;
    sin(q2),  cos(q2), 0;
           0,       0, 1];  
R12=R1*R2;
O2=[l1;0;0];

R3=[cos(q3), -sin(q3), 0;
    sin(q3),  cos(q3), 0;
           0,       0, 1];  
R13=R1*R2*R3;
O3=[l2;0;0];

T1=[R1,O1;
    aaaa];
T2=[R2,O2;
    aaaa];
T3=[R3,O3;
    aaaa];
T12=T1*T2;
T13=T12*T3;
P1=T1*[l1;0;0;1]
P2=T12*[l2;0;0;1]
P3=T13*[l3;0;0;1]
Pc=T13*[l3*t;0;0;1];

V_1 = jacobian(P1,q)*qd;
V_2 = jacobian(P2,q)*qd;
V_3 = jacobian(P3,q)*qd;

V_c = jacobian(Pc,q)*qd;

Jcontact=jacobian(Pc,q)
PG1=T1*[a1;0;0;1]; 
PG2=T12*[a2;0;0;1];
PG3=T13*[a3;0;0;1];

V_l1 = jacobian(PG1,q)*qd;       % link  1 CoM velocity
V_l2 = jacobian(PG2,q)*qd;       % link  2 CoM velocity
V_l3 = jacobian(PG3,q)*qd; 

% angular velocity
W_l1 = qd1 * k;                % link  1 angular velocity
W_l2 = (qd1 + qd2) * k;        % link  2 angular velocity
W_l3 = (qd1 + qd2 + qd3) * k;

I_l1_w = [0,0,0;
    0,0,0;
    0,0,I1];       % link   1 inertia
I_l2_w = [0,0,0;
    0,0,0;
    0,0,I2];       % link   2 inertia
I_l3_w = [0,0,0;
    0,0,0;
    0,0,I3];

% I_m1_w = R_m1 * diag_inertia(I_m1) * R_m1';   % motor  1 inertia
% I_m2_w = R_m2 * diag_inertia(I_m2) * R_m2';   % motor  2 inertia

% kinematic energy
KE = 0.5 * m1 * dot(V_l1, V_l1) + 0.5 *m2 * dot(V_l2, V_l2) + 0.5 *m3 * dot(V_l3, V_l3) + 0.5 * W_l1' * I_l1_w * W_l1 + 0.5 * W_l2' * I_l2_w * W_l2 + 0.5 * W_l3' * I_l3_w * W_l3;

% potential energy
pg1=PG1(1:3);
pg2=PG2(1:3);
pg3=PG3(1:3);

PE = 0;


%% Lagrangian derivation
L = simplify(KE - PE);
DL_Ddq = jacobian(L,qd);
% dDL_Ddq_dt - DL_Dq' = Tau
DL_Dq = jacobian(L,q);

dDL_Ddq_dt = jacobian(DL_Ddq, q) * qd + jacobian(DL_Ddq, qd) *qdd;

tal=[tal1;tal2;tal3];
eqn = simplify(dDL_Ddq_dt - DL_Dq'-tal);

[MM, FF] = equationsToMatrix(eqn, qdd); % convert equation to : MM * ddq = FF
MM
FF
