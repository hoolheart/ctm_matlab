% @name: ctm_clean_outputs
% @objective: clean the outputs of all lanes.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: FEB 10th, 2014

function ctm_clean_outputs()

% declare the variables
global ctm_valid ctm_cells ctm_lanes

if ~ctm_valid
    error('The CTM has not been initialized.');
end

for i=1:length(ctm_lanes)
    if ctm_lanes(i).type == 1
        continue;
    end
    ctm_cells(ctm_lanes(i).out_cell).length = 0;
end
