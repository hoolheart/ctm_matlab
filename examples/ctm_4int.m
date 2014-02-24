% simulation one cycle

function [x] = ctm_4int(q,c,u)

for i=1:16
    ctm_mod_lane_rate(i,'in',q(i));
end

Dt = zeros(5,1);
sw = zeros(4,1);
t = 0;
for i=1:4
    [~,k] = min(u);
    Dt(i) = u(k)-t;
    sw(i) = k;
    t = u(k);
    u(k) = c;
end
Dt(5) = c-t;

for i=1:4
    while Dt(i)>0
        dt = min([Dt(i),1]);
        ctm_simulation(dt);
        Dt(i) = Dt(i)-dt;
    end
    ctm_switch_int(sw(i));
end

while Dt(5)>0
    dt = min([Dt(5),1]);
    ctm_simulation(dt);
    Dt(5) = Dt(5)-dt;
end

ctm_switch_int(1); ctm_switch_int(2); ctm_switch_int(3); ctm_switch_int(4);
x0 = ctm_read_lanes();
x = x0(1:16);
