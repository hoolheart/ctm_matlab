% @name: ctm_reset_delay
% @objective: reset the delay of all cells.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: SEP 3rd, 2013

function ctm_reset_delay()

% declare the variables
global ctm_valid ctm_cells

if ~ctm_valid
    error('The CTM has not been initialized.');
end

[ctm_cells.delay] = deal(0);
