clear functions %
clear all


slip.m3   =  1;
slip.m1  =  0.2;    
slip.m2  =  0.2;  % masses
slip.I1  =  0.5*eye(3);  
slip.I2  =  0.5*eye(3);  % inertias about cmsslip.l1   =  1
slip.I3  =  3*eye(3);
slip.a1  =  0.5;            % dist. from O to G1 and E to G2 (see figures)
slip.a2  =  0.5;
slip.a3  =  0.5;
slip.l1  =  1;
slip.l2  =  1;
slip.l3  =  1;

framespersec=50;  %if view is not speeded or slowed in dbpend_animate
T=5;             %duration of animation  in seconds
tspan=linspace(0,T,T*framespersec);
q1    = pi/2; %angle made by link1 with vertical
qd1    = 0;        %abslolute velocity of link1   
q2    = pi/2 ;      %angle made by link2 with vertical
qd2    = 0;        %abslolute velocity of link2
q3    = -pi/2 ;
qd3    = 0;
z0=[q1 qd1 q2 qd2 q3 qd3]';
 [P1,P2,P3]=kinematic(z0,i,slip);


figure(1)

    plot([0],[0],'ko','MarkerSize',3); %pivot point
    hold on
line([0 P1(1)],[0 P1(2)],'Linewidth',4,'Color',[0.8 0 0]);% first pendulum
line([P1(1) P2(1)],[P1(2) P2(2)],'Linewidth',4,'Color',[0 0.8 0]);% second pendulum
line([P2(1) P3(1)],[P2(2) P3(2)],'Linewidth',4,'Color',[0 0 0.8]);% second pendulum

    axis([-2*slip.l1 2*slip.l1 -2*slip.l1 2*slip.l1]);
    axis square
    hold off