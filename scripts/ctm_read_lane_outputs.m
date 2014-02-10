% @name: ctm_read_lane_outputs
% @objective: read the outputs of all lanes.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: FEB 10th, 2014

function outputs = ctm_read_lane_outputs()

% declare the variables
global ctm_valid ctm_cells ctm_lanes

if ~ctm_valid
    error('The CTM has not been initialized.');
end

outputs = zeros(length(ctm_lanes),1);
for i=1:length(ctm_lanes)
    if ctm_lanes(i).type == 1
        continue;
    end
    outputs(i) = ctm_cells(ctm_lanes(i).out_cell).length;
end
