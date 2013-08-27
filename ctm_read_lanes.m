% @name: ctm_read_lanes
% @objective: read the lengths of all lanes.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 23rd, 2013

function queues = ctm_read_lanes()

% declare the variables
global ctm_valid ctm_cells ctm_lanes

if ~ctm_valid
    error('The CTM has not been initialized.');
end

queues = zeros(length(ctm_lanes),1);
for i=1:length(ctm_lanes)
    if ctm_lanes(i).type == 2
        continue;
    end
    for j=ctm_lanes(i).o_cell:ctm_lanes(i).d_cell
        queues(i) = queues(i)+ctm_cells(j).length;
    end
    queues(i) = queues(i)+ctm_cells(ctm_lanes(i).in_cell).length;
    if queues(i)>ctm_lanes(i).cap
        queues(i) = ctm_lanes(i).cap;
    end
end

