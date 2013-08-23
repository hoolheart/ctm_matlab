% @name: ctm_mod_lane_rate
% @objective: modify the rate of lane.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 23rd, 2013

function ctm_mod_lane_rate(index,attr,rate)
% index: index of the lane
% attr: specify the objective rate, "in"|"out"|"sat"
% rate: new value of rate

% declare the variables
global ctm_valid ctm_sim ctm_cells ctm_links ctm_lanes

if ~ctm_valid
    error("The CTM has not been initialized.");
end

if index<1 || index>length(ctm_lanes)
    error("Wrong index of lane.");
end

switch attr
case "in"
    if ctm_lanes(index).type == 2
        break;
    end
    ctm_lanes(index).in_rate = rate;
    ctm_cells(ctm_lanes(index).in_cell).rate = rate;
    break;
case "out"
    if ctm_lanes(index).type == 0
        if rate<0 || rate>1
            error("The out rate of a lane must be inside [0,1].");
        end
        ctm_lanes(index).out_rate = rate;
        ctm_links(ctm_lanes(index).out_link).p = 1-rate;
    end
    break;
case "sat"
    if ctm_lanes(index).type == 2
        break;
    end
    ctm_lanes(index).sat_rate = rate;
    [ctm_cells(ctm_lanes(index).o_cell:ctm_lanes(index).d_cell).rate] = deal(rate);
    break;
end

