% @name: ctm_read_total_delay
% @objective: read the total delay of the Cell-Transmission Model.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: SEP 3rd, 2013

function delay = ctm_read_total_delay()

% declare the variables
global ctm_valid

if ~ctm_valid
    error('The CTM has not been initialized.');
end

delay = sum(ctm_read_lane_delays());
