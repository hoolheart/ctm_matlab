% testing
% simulation of two-intersection system

% modeling
reset_ctm();
ctm_add_lane(1,80,0.6,0.3,0)
ctm_add_lane(0,60,0.6,0.03,0.1)
ctm_add_lane(1,70,0.6,0.3,0)
ctm_add_lane(1,70,0.6,0.3,0)
ctm_add_lane(0,60,0.6,0.03,0.1)
ctm_add_lane(1,80,0.6,0.3,0)
ctm_add_lane(1,70,0.6,0.3,0)
ctm_add_lane(1,70,0.6,0.3,0)
ctm_add_lane(2,0,0,0,1)
ctm_add_lane(2,0,0,0,1)
ctm_add_lane(2,0,0,0,1)
ctm_add_lane(2,0,0,0,1)
ctm_add_lane(2,0,0,0,1)
ctm_add_lane(2,0,0,0,1)
ctm_add_int([1 2 3 4],[5 9 10 11],[2 0.6;2 0.6])
ctm_add_phase(1,...
             [0 0.3 1 1 0 1 0 0;...
              0 0.3 0 1 2 1 0 0;...
              0 0.3 1 2 0 2 0 0;...
              0 0.3 0 2 2 2 0 0]);
ctm_add_phase(1,...
             [0 0.3 1 3 0 1 0 0;...
              0 0.3 0 1 2 4 0 0;...
              0 0.3 1 4 0 2 0 0;...
              0 0.3 0 2 2 3 0 0]);
ctm_add_int([5 6 7 8],[12 2 13 14],[2 0.6;2 0.6])
ctm_add_phase(2,...
             [0 0.3 1 1 0 1 0 0;...
              0 0.3 0 1 2 1 0 0;...
              0 0.3 1 2 0 2 0 0;...
              0 0.3 0 2 2 2 0 0]);
ctm_add_phase(2,...
             [0 0.3 1 3 0 1 0 0;...
              0 0.3 0 1 2 4 0 0;...
              0 0.3 1 4 0 2 0 0;...
              0 0.3 0 2 2 3 0 0]);

% simulation
ctm_start([35 40 45 35 40 15 58 63 0 0 0 0 0 0],[1 1])
x = zeros(14,4);
x(:,1) = ctm_read_lanes();
for i=1:33
    ctm_simulation(1);
end
x(:,2) = ctm_read_lanes();
ctm_switch_int(2);
ctm_read_phases()
for i=34:36
    ctm_simulation(1);
end
x(:,3) = ctm_read_lanes();
ctm_switch_int(1);
ctm_read_phases()
for i=36:90
    ctm_simulation(1);
end
x(:,4) = ctm_read_lanes();
ctm_switch_int(1);
ctm_switch_int(2);
ctm_read_phases()

