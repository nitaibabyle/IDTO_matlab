function [F1,F2]=contact_model_optuse(Pa,Va, Pb,Vb, Pc,Vc, slip)
d_contact=-100;
k_contact=400;
comply_parak=10;
comply_parad=10;
distance1=Pc-Pa;
direction1=distance1/norm(distance1);
relative_v1=Vc-Va;

distance2=Pc-Pb;
direction2=distance2/norm(distance2);
relative_v2=Vc-Vb;
%% calculate the ref contact force
x11=slip.R-norm(distance1);
Fn1=x11*direction1*k_contact/(1+exp(-x11/comply_parak))+d_contact/(1+exp(-x11/comply_parad))*relative_v1;
F1=Fn1;

x22=slip.R-norm(distance2);
Fn2=x22*direction2*k_contact/(1+exp(-x22/comply_parak))+d_contact/(1+exp(-x22/comply_parad))*relative_v2;
F2=Fn2;


