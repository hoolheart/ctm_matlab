% @name: ctm_read_cells
% @objective: read the lengths of all cells.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 23rd, 2013

function c_lens = ctm_read_cells()

% declare the variables
global ctm_valid ctm_cells

if ~ctm_valid
    error('The CTM has not been initialized.');
end

c_lens = zeros(length(ctm_cells),1);
c_lens(:) = arrayfun(@(c)(c.length),ctm_cells);
%c_lens(:) = deal(ctm_cells.length);

