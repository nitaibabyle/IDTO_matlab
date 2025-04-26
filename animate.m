%function animate(t,z,slip)
figure(1)

theta = linspace(0, 2*pi, 100); % 生成从0到2*pi的100个点
arrow_head_length=0.2;
arrow_angle=0.2;
arrow_length=0.6;
for i=1:length(t)
    
    window_xmin = -5; window_xmax = 5;
    window_ymin = -5; window_ymax = 5;
    

    x = slip.R*cos(theta)+z(i,1); % 圆上的x坐标
    y = slip.R*sin(theta)+z(i,2); % 圆上的y坐标
     
    plot(x,y,'Linewidth',1,'Color',[0.0 0.0 0.0]); %pivot point
%     line([z(i,1)-slip.R z(i,1)+slip.R],[z(i,2)-slip.R z(i,2)-slip.R],'Linewidth',1,'Color',[0 0.0 0.0]);
%     line([z(i,1)-slip.R z(i,1)+slip.R],[z(i,2)+slip.R z(i,2)+slip.R],'Linewidth',1,'Color',[0 0.0 0.0]);
%     line([z(i,1)-slip.R z(i,1)-slip.R],[z(i,2)-slip.R z(i,2)+slip.R],'Linewidth',1,'Color',[0 0.0 0.0]);
%     line([z(i,1)+slip.R z(i,1)+slip.R],[z(i,2)-slip.R z(i,2)+slip.R],'Linewidth',1,'Color',[0 0.0 0.0]);
%    
    [P1, P2,P3]=kinematic1(z(i,5:10),slip);
    line([P1(1) P2(1)],[P1(2) P2(2)],'Linewidth',1,'Color',[0.0 0.8 0.8]);
    line([P1(1) 0],[P1(2) 0],'Linewidth',1,'Color',[0.8 0.8 0.0]);
    line([P3(1) P2(1)],[P3(2) P2(2)],'Linewidth',1,'Color',[0.8 0.0 0.8]);
    [P1, P2,P3]=kinematic2(z(i,11:16),slip);
    line([P1(1) P2(1)],[P1(2) P2(2)],'Linewidth',1,'Color',[0.0 0.8 0.8]);
    line([P1(1) slip.w],[P1(2) 0],'Linewidth',1,'Color',[0.8 0.8 0.0]);
    line([P3(1) P2(1)],[P3(2) P2(2)],'Linewidth',1,'Color',[0.8 0.0 0.8]);
    
    
    
    axis('equal')
    axis on
    axis([window_xmin window_xmax window_ymin window_ymax])
    F(i)=getframe;
end
v = VideoWriter('ccc.avi');
open(v);
writeVideo(v,F);
close(v);