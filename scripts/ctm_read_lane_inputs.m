% @name: ctm_read_lane_outputs
% @objective: read the remaining intputs of all lanes: the vehicles that
% are sopposed to enter the lane but prevented by the congestions
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: FEB 10th, 2014

function inputs = ctm_read_lane_inputs()

% declare the variables
global ctm_valid ctm_cells ctm_lanes

if ~ctm_valid
    error('The CTM has not been initialized.');
end

inputs = zeros(length(ctm_lanes),1);
for i=1:length(ctm_lanes)
    if ctm_lanes(i).type == 2
        continue;
    end
    inputs(i) = ctm_cells(ctm_lanes(i).in_cell).length;
end
