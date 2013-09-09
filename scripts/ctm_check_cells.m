% @name: ctm_check_cells
% @objective: check the validation of the lengths of all cells.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 23rd, 2013

function is_valid = ctm_check_cells()

% declare the variables
global ctm_valid ctm_cells

if ~ctm_valid
    error('The CTM has not been initialized.');
end

if ctm_cells.length<0 || ctm_cells.length>ctm_cells.cap
    is_valid = false;
else
    is_valid = true;
end

