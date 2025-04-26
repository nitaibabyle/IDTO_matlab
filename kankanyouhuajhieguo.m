for i=1:20
    Qdd_Qd_q_t(:,i)=ccc(1+(i-1)*24:24*i);
    ut(:,i)=ccc(481+(i-1)*6:480+6*i);
    Flt(:,i)=ccc(601+(i-1)*2:600+2*i);
    Frt(:,i)=ccc(641+(i-1)*2:640+2*i);
    for j=1:8
        Qdd_t(i,j)=Qdd_Qd_q_t(3*j,i);
        Qd_t(i,j)=Qdd_Qd_q_t(3*j-1,i);
        Q_t(i,j)=Qdd_Qd_q_t(3*j-2,i);
    end
end

global T;
global z_0 z_ed;
for i=1:20
        z(i,1:2)=Q_t(i,1:2);
        z(i,3:4)=Qd_t(i,1:2);
        z(i,5:7)=Q_t(i,3:5);
        z(i,8:10)=Qd_t(i,3:5);
        z(i,11:13)=Q_t(i,6:8);
        z(i,14:16)=Qd_t(i,6:8);
        z(i,17:18)=Flt(:,i)';
        z(i,19:20)=Frt(:,i)';
end

t=0:T/19:T;


figure(1)

theta = linspace(0, 2*pi, 100); % 生成从0到2*pi的100个点
arrow_head_length=0.2;
arrow_angle=0.2;
arrow_length=0.6;
for i=1:length(t)
    
    window_xmin = -5; window_xmax = 6;
    window_ymin = -1; window_ymax = 5;
    

    x = [slip.R*cos(theta)+z(i,1),slip.R*cos(theta)+z_ed(1)]; % 圆上的x坐标
    y = [slip.R*sin(theta)+z(i,2),slip.R*sin(theta)+z_ed(4)]; % 圆上的y坐标
    scatter(x,y, 0.5, 'k', 'Marker', 'o', 'LineWidth', 1); %pivot point
%     plot(slip.R*cos(theta)+z_ed(1),slip.R*sin(theta)+z_ed(4),'Linewidth',1); %pivot point
%     line([z(i,1)-slip.R z(i,1)+slip.R],[z(i,2)-slip.R z(i,2)-slip.R],'Linewidth',1,'Color',[0 0.0 0.0]);
%     line([z(i,1)-slip.R z(i,1)+slip.R],[z(i,2)+slip.R z(i,2)+slip.R],'Linewidth',1,'Color',[0 0.0 0.0]);
%     line([z(i,1)-slip.R z(i,1)-slip.R],[z(i,2)-slip.R z(i,2)+slip.R],'Linewidth',1,'Color',[0 0.0 0.0]);
%     line([z(i,1)+slip.R z(i,1)+slip.R],[z(i,2)-slip.R z(i,2)+slip.R],'Linewidth',1,'Color',[0 0.0 0.0]);
%    
    [P1, P2,P3]=kinematic1(z(i,5:10),slip);
    line([P1(1) P2(1)],[P1(2) P2(2)],'Linewidth',1,'Color',[0.0 0.8 0.8]);
    line([P1(1) 0],[P1(2) 0],'Linewidth',1,'Color',[0.8 0.8 0.0]);
    line([P3(1) P2(1)],[P3(2) P2(2)],'Linewidth',1,'Color',[0.8 0.0 0.8]);
    line([P3(1) P3(1)+z(i,17)],[P3(2) P3(2)+z(i,18)],'Linewidth',1,'Color',[1 0.0 0]);
    [P1, P2,P3]=kinematic2(z(i,11:16),slip);
    line([P1(1) P2(1)],[P1(2) P2(2)],'Linewidth',1,'Color',[0.0 0.8 0.8]);
    line([P1(1) slip.w],[P1(2) 0],'Linewidth',1,'Color',[0.8 0.8 0.0]);
    line([P3(1) P2(1)],[P3(2) P2(2)],'Linewidth',1,'Color',[0.8 0.0 0.8]);
    line([P3(1) P3(1)+z(i,19)],[P3(2) P3(2)+z(i,20)],'Linewidth',1,'Color',[1 0.0 0]);
    
    
    
    axis('equal')
    axis on
    axis([window_xmin window_xmax window_ymin window_ymax])
    F(i)=getframe;
end
v = VideoWriter('ccc.avi');
open(v);
writeVideo(v,F);
close(v);

