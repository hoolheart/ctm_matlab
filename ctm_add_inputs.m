% @name: ctm_add_inputs
% @objective: add impulsive input to the lanes.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 26th, 2013

function ctm_add_inputs(inputs)
% inputs: impulsive inputs to all lanes

% declare the variables
global ctm_valid ctm_cells ctm_lanes

if ~ctm_valid
    error('The CTM has not been initialized.');
end

for i=1:length(ctm_lanes)
    if ctm_lanes(i).type == 2
        continue;
    end
    ctm_cells(ctm_lanes(i).in_cell).length = ctm_cells(ctm_lanes(i).in_cell).length+inputs(i);
end
