function [F1,F2]=force_calcu(Pa,Va, Pb,Vb, Pc,Vc, slip)
    d_contact=-100;
    k_contact=400;
    d_contact_fric=-10;
mu=slip.mu;

distance1=Pc-Pa;
direction1=distance1/norm(distance1);
tan_direction1=[direction1(2);-direction1(1)];
relative_v1=Vc-Va;

distance2=Pc-Pb;
direction2=distance2/norm(distance2);
tan_direction2=[direction2(2);-direction2(1)];
relative_v2=Vc-Vb;
F1=[0;0];
F2=[0;0];
if norm(distance1) < slip.R
        
        Fspring=k_contact*(direction1*(slip.R-norm(distance1)))+d_contact*relative_v1;
        F=Fspring;

        A=[direction1,tan_direction1];
        B=[-mu, 1;
            -mu, -1;
            -1,0];
        H=2*(A'*A);
        f=-2*A'*F;
        Aineq=B;bineq=[0;0;0];
        [xNow, ~, ~, ~] = quadprog(H,f,Aineq,bineq);
        F1=xNow(1)*direction1+xNow(2)*tan_direction1;
else
    F1=[0;0];
        
end

if norm(distance2) <slip.R
        
        Fspring=k_contact*(direction2*(slip.R-norm(distance2)))+d_contact*relative_v2;
        F=Fspring;

        A=[direction2,tan_direction2];
        B=[-mu, 1;
            -mu, -1;
            -1,0];
        H=2*(A'*A);
        f=-2*A'*F;
        Aineq=B;bineq=[0;0;0];
        [xNow, ~, ~, ~] = quadprog(H,f,Aineq,bineq);
        F2=xNow(1)*direction2+xNow(2)*tan_direction2;
else
    F2=[0;0];
end

