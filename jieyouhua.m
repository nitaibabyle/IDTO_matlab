clear all
clc
slip.m  =  2;    
slip.R=0.5;
slip.w=2;
slip.mu=0.2;

slip.m3   =  1;
slip.m1  =  1;    
slip.m2  =  1;  % masses
slip.I1  =  0.33;  
slip.I2  =  0.33;  % inertias about cmsslip.l1   =  1
slip.I3  =  0.33;
slip.a1  =  0.5;            % dist. from O to G1 and E to G2 (see figures)
slip.a2  =  0.5;
slip.a3  =  0.5;
slip.l1  =  1;
slip.l2  =  1;
slip.l3  =  1;
slip.g   =  0;
 global T
 T=5;
% Initial conditions and other settings.
framespersec=1000;  %if view is not speeded or slowed in dbpend_animate
T=5;             %duration of animation  in seconds
time=T;
% 
x_ed=-0;        dx_ed=0;      ddx_ed=0;
y_ed=1.2;        dy_ed=0;      ddy_ed=0;
lq1_ed=pi/2+pi/3;        dlq1_ed=0;      ddlq1_ed=0;
lq2_ed=-pi*2/3;        dlq2_ed=0;      ddlq2_ed=0;
lq3_ed=pi/3;        dlq3_ed=0;      ddlq3_ed=0;
rq1_ed=pi/2-pi/3;        drq1_ed=0;      ddrq1_ed=0;
rq2_ed=pi*2/3;        drq2_ed=0;      ddrq2_ed=0;
rq3_ed=-pi/3;        drq3_ed=0;      ddrq3_ed=0;

%theta_ed=0.0573;    dtheta_ed=0;

x_0=1;        dx_0=0;      ddx_0=0;
y_0=2.5;        dy_0=0;      ddy_0=0;
lq1_0=pi/2;        dlq1_0=0;      ddlq1_0=0;
lq2_0=0;        dlq2_0=0;      ddlq2_0=0;
lq3_0=0;        dlq3_0=0;      ddlq3_0=0;
rq1_0=pi/2;        drq1_0=0;      ddrq1_0=0;
rq2_0=0;        drq2_0=0;      ddrq2_0=0;
rq3_0=0;        drq3_0=0;      ddrq3_0=0;
%theta_0=0.0573;    dtheta_0=0;
u0=zeros(120,1);%6*20

F0=zeros(80,1);%2*20*2
global z_0 z_ed
z_0=[x_0,        dx_0,      ddx_0,...
    y_0,        dy_0,      ddy_0,...
    lq1_0,        dlq1_0,      ddlq1_0,...
    lq2_0,        dlq2_0,      ddlq2_0,...
    lq3_0,        dlq3_0,      ddlq3_0,...
    rq1_0,        drq1_0,      ddrq1_0,...
    rq2_0,        drq2_0,      ddrq2_0,...
    rq3_0,        drq3_0,      ddrq3_0];
z_0=[    1.0004,   -0.0000,   -0.0000,...
    2.5995,    0.0001,   -0.0000,...
    1.5715,   -0.0004,    0.0000,...
   -0.0006,   -0.0001,    0.0000,...
    0.0004,   -0.0001,    0.0000,...
    1.5703,    0.0001,   -0.0000,...
    0.0006,   -0.0000,   -0.0000,...
   -0.0004,    0.0001,   -0.0000];
z_ed=[x_ed,        dx_ed,      ddx_ed,...
    y_ed,        dy_ed,      ddy_ed,...
    lq1_ed,        dlq1_ed,      ddlq1_ed,...
    lq2_ed,        dlq2_ed,      ddlq2_ed,...
    lq3_ed,        dlq3_ed,      ddlq3_ed,...
    rq1_ed,        drq1_ed,      ddrq1_ed,...
    rq2_ed,        drq2_ed,      ddrq2_ed,...
    rq3_ed,        drq3_ed,      ddrq3_ed];

MMM0=[z_0';
    (18*z_0'+1*z_ed')/19;
    (17*z_0'+2*z_ed')/19;
    (16*z_0'+3*z_ed')/19;
    (15*z_0'+4*z_ed')/19;
    (14*z_0'+5*z_ed')/19;
    (13*z_0'+6*z_ed')/19;
    (12*z_0'+7*z_ed')/19; 
    (11*z_0'+8*z_ed')/19;
    (10*z_0'+9*z_ed')/19;
    (9*z_0'+10*z_ed')/19;
    (8*z_0'+11*z_ed')/19;
    (7*z_0'+12*z_ed')/19;
    (6*z_0'+13*z_ed')/19;
    (5*z_0'+14*z_ed')/19;
    (4*z_0'+15*z_ed')/19; 
    (3*z_0'+16*z_ed')/19;
    (2*z_0'+17*z_ed')/19;
    (1*z_0'+18*z_ed')/19; 
    z_ed';   u0;F0;T];
      %Kp_spring1;Kp_spring2;Kp_spring3;Kp_spring4;Kp_spring5;Kd_spring1;Kd_spring2;Kd_spring3;Kd_spring4;Kd_spring5;Time0];
% MMM0=ccc;
% options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
options = optimoptions('fmincon',...
    'Algorithm','interior-point','Display','iter','ConstraintTolerance',1e-12, 'MaxFunEvals', 50000);
%     options = optimoptions('fmincon','Display','iter');
[ccc,y]=fmincon('objective',MMM0,[],[],[],[],[],[],'nlconstraint',options,slip);



