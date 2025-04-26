function obj=state_obj(X,slip)
global z_ed

ball_state=[1,1,0,1,1,0];
left_arm_state=[1,1,0,1,1,0,1,1,0];
right_arm_state=[1,1,0,1,1,0,1,1,0];
weight_vec=[ball_state';left_arm_state';right_arm_state'];
w=diag(weight_vec);
err=X(1:24)-z_ed';
obj1=err'*w*err;

obj=obj1;
