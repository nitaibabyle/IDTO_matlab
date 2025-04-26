function obj=force_mini_obj(X,slip)

Flx=X(31);
Fly=X(32);
Frx=X(33);
Fry=X(34);

obj1=(Flx'*Flx+Fly'*Fly);
obj2=(Frx'*Frx+Fry'*Fry);

obj=obj1+obj2;
