
clear functions %
clear all

%%%%%%%%% INITIALIZE PARAMETERS %%%%%%
%Mechanical parameters.


slip.m  =  2;    
slip.R=0.5;
slip.w=1.5;

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

slip.mu=0.1;

% Initial conditions and other settings.
framespersec=1000;  %if view is not speeded or slowed in dbpend_animate
T=5;             %duration of animation  in seconds

x=4;
dx=-10;
y=3;
dy=-0;

lq1    = pi/2; %angle made by link1 with vertical
lqd1    =0;
lq2    = 0 ;      %angle made by link2 with vertical
lqd2    =0;
lq3      =0;
lqd3       =  0;

rq1    = pi/2; %angle made by link1 with vertical
rqd1    =0;
rq2    = 0 ;      %angle made by link2 with vertical
rqd2    =0;
rq3      =0;
rqd3       =  0;
z0=[];

z0=[x y dx dy lq1 lq2 lq3 lqd1 lqd2 lqd3 rq1 rq2 rq3 rqd1 rqd2 rqd3];

global t_ode;
global z_ode;
t0=0;
t_ode=t0;
z_ode=z0;
fps = 50;


[t_ode,z_ode]=floatingbaseode(t0,z0,slip);

[t,z] = loco_interpolate(t_ode,z_ode,fps);

animate(t,z,slip);

function [t_ode,z_ode]=floatingbaseode(t0,z0,slip)
global t_ode;
global z_ode;

dt=0.001;
N=5000;
interg_t=0;
F1=[0;0];
F2=[0;0];

for i=1:3000
    i
    x=z0(1);
    y=z0(2);

    dx=z0(3);
    dy=z0(4);

    
    lq1=z0(5);
    lq2=z0(6);
    lq3=z0(7);
    ldq1=z0(8);
    ldq2=z0(9);
    ldq3=z0(10);
    
    rq1=z0(11);
    rq2=z0(12);
    rq3=z0(13);
    rdq1=z0(14);
    rdq2=z0(15);
    rdq3=z0(16);
    
    options1 = odeset('Abstol',1e-8,'Reltol',1e-8);
    tspan = linspace(t0,t0+dt,dt*N);
    tal_left=[-50*ldq1;-50*ldq2;-50*ldq3];
    tal_right=[-50*rdq1;-50*rdq2;-50*rdq3];
    [t_temp1 z_temp1] = ode113(@rhs_3link1,tspan,z0(5:10),options1,slip,interg_t,-F1,tal_left);
    [~, ~,lP3,~,~,lV3]=kinematic1(z_temp1(end,:),slip);
    [t_temp2 z_temp2] = ode113(@rhs_3link2,tspan,z0(11:16),options1,slip,interg_t,-F2,tal_right);
    [~, ~,rP3,~,~,rV3]=kinematic2(z_temp2(end,:),slip);


   %% end point contact
   [F1,F2]=force_calcu(lP3,lV3, rP3,rV3, [x;y],[dx;dy], slip);
    F_man=F1+F2;
 
    [t_temp3 z_temp3] = ode113(@rhs_ball,tspan,z0(1:4),options1,slip,F_man);
    
    t0 = t_temp3(end,:);
    z0(1:4) = z_temp3(end,:);
    z0(5:10) = z_temp1(end,:);
    z0(11:16) = z_temp2(end,:);
    t_ode = [t_ode;t_temp2(2:end)];
    z_ode = [z_ode;z_temp3(2:end,:),z_temp1(2:end,:),z_temp2(2:end,:)];
    
    
end
end