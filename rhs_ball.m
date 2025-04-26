function zdot=rhs_ball(t,z,slip,F_man)
m=slip.m;

x=z(1);
y=z(2);
dx=z(3);
dy=z(4);


mu=0.6;


if sqrt(dx^2+dy^2)>1e-6
    F(1)=mu*m*9.8*(-dx/sqrt(dx^2+dy^2));
    F(2)=mu*m*9.8*(-dy/sqrt(dx^2+dy^2));
else
    F(1)=-F_man(1);
    F(2)=-F_man(2);
    dx=0;
    dy=0;
    if sqrt(F_man(1)^2+F_man(2)^2)>mu*m*9.8
        F(1)=mu*m*9.8*(-F_man(1)/sqrt(F_man(1)^2+F_man(2)^2));
        F(2)=mu*m*9.8*(-F_man(2)/sqrt(F_man(1)^2+F_man(2)^2));
    end
end



qd(1)=dx;
qd(2)=dy;

ddx=(F(1)+F_man(1))/m;
ddy=(F(2)+F_man(2))/m;

qdd(1)=ddx;
qdd(2)=ddy;

zdot=[qd(1) qd(2) qdd(1) qdd(2)]';

