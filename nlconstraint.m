function [ineq,eq]=nlconstraint(MMM,slip)
ineq=opt_inequality_constraint(MMM,slip);
eq=[opt_dynamic_constraint(MMM,slip);...
    opt_discrete_constraint(MMM,slip);...
    opt_boundary_constraint(MMM,slip)];
    %MMM(366)+50;MMM(367)+50;MMM(368)+50;MMM(369)+50;MMM(370)+50];

