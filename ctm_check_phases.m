% @name: ctm_check_phases
% @objective: check the validation of the phases of all intersections.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 23rd, 2013

function is_valid = ctm_check_phases()

% declare the variables
global ctm_valid ctm_intersections

if ~ctm_valid
    error('The CTM has not been initialized.');
end

is_valid = true;
for i=1:length(ctm_intersections)
    if ctm_intersections(i).phase<1 ||...
       ctm_intersections(i).phase>size(ctm_intersections(i).phases,1)
        is_valid = false;
        break;
    end
end

