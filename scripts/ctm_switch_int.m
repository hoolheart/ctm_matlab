% @name: ctm_switch_int
% @objective: switch the intersection into next phase.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 23rd, 2013

function ctm_switch_int(index)
% index: index of the intersection

% declare the variables
global ctm_valid ctm_sim ctm_links ctm_intersections

if ~ctm_valid
    error('The CTM has not been initialized.');
end
if ~ctm_sim
    error('The simulation has not been started.');
end

if index<1 || index>length(ctm_intersections)
    error('Wrong index of intersection.');
end

f = ctm_intersections(index).phase;
for i=ctm_intersections(index).phases(f,1):ctm_intersections(index).phases(f,2)
    ctm_links(i).access = 0;
end

f = f+1;
if f>size(ctm_intersections(index).phases,1)
    f = 1;
end
for i=ctm_intersections(index).phases(f,1):ctm_intersections(index).phases(f,2)
    ctm_links(i).access = 1;
end
ctm_intersections(index).phase = f;

