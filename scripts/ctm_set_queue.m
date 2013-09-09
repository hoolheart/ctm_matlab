% @name: ctm_set_queue
% @objective: set the queue length of one lane.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 23rd, 2013

function ctm_set_queue(index,q)
% index: index of the lane
% q: queue length

% declare the variables
global ctm_valid ctm_sim ctm_cells ctm_lanes

if ~ctm_valid
    error('The CTM has not been initialized.');
end
if ctm_sim
    error('The queue length can not be set after starting the simulation.');
end

if index<1 || index>length(ctm_lanes)
    error('Wrong index of lane.');
end
if q<0 || q>ctm_lanes(index).cap
    error('Wrong queue length.');
end

if ctm_lanes(index).type == 2
    return;
end

for i=ctm_lanes(index).d_cell:-1:ctm_lanes(index).o_cell
    l = min(q,ctm_cells(i).cap);
    ctm_cells(i).length = l;
    q = q-l;
end

