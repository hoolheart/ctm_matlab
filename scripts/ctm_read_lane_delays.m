% @name: ctm_read_lane_delays
% @objective: read the delays of all lanes.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: SEP 3rd, 2013

function delays = ctm_read_lane_delays()

% declare the variables
global ctm_valid ctm_cells ctm_lanes

if ~ctm_valid
    error('The CTM has not been initialized.');
end

delays = zeros(length(ctm_lanes),1);
for i=1:length(ctm_lanes)
    if ctm_lanes(i).type == 2
        continue;
    end
    for j=ctm_lanes(i).o_cell:ctm_lanes(i).d_cell
        delays(i) = delays(i)+ctm_cells(j).delay;
    end
    delays(i) = delays(i)+ctm_cells(ctm_lanes(i).in_cell).delay;
end
