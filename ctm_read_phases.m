% @name: ctm_read_phases
% @objective: read the current phases of all intersections.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 23rd, 2013

function phases = ctm_read_phases()

% declare the variables
global ctm_valid ctm_intersections

if ~ctm_valid
    error("The CTM has not been initialized.");
end

phases = zeros(length(ctm_intersections),1);
phases(:) = arrayfun(@(c)(c.phase),ctm_intersections);
%phases(:) = deal(ctm_intersections.phase);

