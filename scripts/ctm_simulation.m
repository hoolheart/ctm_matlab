% @name: ctm_sim
% @objective: run the simulation of the Cell-Transmission Model.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 23rd, 2013

function ctm_simulation(dt)
% dt: run time

% declare the variables
global ctm_valid ctm_sim ctm_w_vf ctm_vf ctm_veh_length ctm_cells ctm_links

if ~ctm_valid
    error('The CTM has not been initialized.');
end
if ~ctm_sim
    error('The simulation has not been started.');
end

% calculate the possible in/out flows
[ctm_cells.in] = deal(0);
[ctm_cells.out] = deal(0);
for i=1:length(ctm_cells)
    switch ctm_cells(i).type
    case 0
        ctm_cells(i).pos_in = min([ctm_cells(i).rate*dt,ctm_w_vf*(ctm_cells(i).cap-ctm_cells(i).length)]);
        ctm_cells(i).pos_out = min([ctm_cells(i).rate*dt,ctm_cells(i).length]);
    case 1
        ctm_cells(i).length = ctm_cells(i).length+ctm_cells(i).rate*dt;
        ctm_cells(i).pos_in = 0;
        ctm_cells(i).pos_out = ctm_cells(i).length;
    case 2
        ctm_cells(i).pos_in = Inf;
        ctm_cells(i).pos_out = 0;
    end
end

% calculate the real flows
for i=1:length(ctm_links)
    if ctm_links(i).access == 0
        continue;
    end
    switch ctm_links(i).type
    case 0
        c1 = ctm_links(i).cells(1); c2 = ctm_links(i).cells(2);
        if c1<=0 || c2<=0
            error('Wrong index of cell');
        end
        f = min([ctm_cells(c1).pos_out,ctm_cells(c2).pos_in]);
        ctm_cells(c1).out = f;
        ctm_cells(c2).in = f;
    case 1
        c1 = ctm_links(i).cells(1); c2 = ctm_links(i).cells(2); c3 = ctm_links(i).cells(3);
        b1 = ctm_links(i).p; b2 = 1-b1;
        if ctm_cells(c3).pos_in>=ctm_cells(c1).pos_out+ctm_cells(c2).pos_out
            f1 = ctm_cells(c1).pos_out; f2 = ctm_cells(c2).pos_out;
        else
            f1 = median([ctm_cells(c1).pos_out,ctm_cells(c3).pos_in-ctm_cells(c2).pos_out,b1*ctm_cells(c3).pos_in]);
            f2 = median([ctm_cells(c2).pos_out,ctm_cells(c3).pos_in-ctm_cells(c1).pos_out,b2*ctm_cells(c3).pos_in]);
        end
        ctm_cells(c1).out = f1;
        ctm_cells(c2).out = f2;
        ctm_cells(c3).in = f1+f2;
    case 2
        c1 = ctm_links(i).cells(1); c2 = ctm_links(i).cells(2); c3 = ctm_links(i).cells(3);
        b1 = ctm_links(i).p; b2 = 1-b1;
        f = min([ctm_cells(c1).pos_out,ctm_cells(c2).pos_in/b1,ctm_cells(c3).pos_in/b2]);
        ctm_cells(c1).out = f;
        ctm_cells(c2).in = f*b1;
        ctm_cells(c3).in = f*b2;
    end
end

% update the cell lengths
% [ctm_cells.length] = [ctm_cells.length]+[ctm_cells.in]-[ctm_cells.out];
for i=1:length(ctm_cells)
%     ctm_cells(i).delay = ctm_cells(i).delay+dt*(ctm_cells(i).length-ctm_cells(i).out*ctm_cells(i).cap*ctm_veh_length/ctm_vf/dt);
    ctm_cells(i).delay = ctm_cells(i).delay+dt*(ctm_cells(i).length-ctm_cells(i).out);
    ctm_cells(i).length = ctm_cells(i).length+ctm_cells(i).in-ctm_cells(i).out;
end
