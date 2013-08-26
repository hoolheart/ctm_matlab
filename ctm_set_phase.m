% @name: ctm_set_phase
% @objective: set the phase of one intersection.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 23rd, 2013

function ctm_set_phase(index,f)
% index: index of the intersection
% f: phase

% declare the variables
global ctm_valid ctm_sim ctm_links ctm_intersections

if ~ctm_valid
    error('The CTM has not been initialized.');
end
if ctm_sim
    error('The phase can not be directly set after starting the simulation.');
end

if index<1 || index>length(ctm_intersections)
    error('Wrong index of intersection.');
end
if f<1 || f>size(ctm_intersections(index).phases,1)
    error('Wrong phase.');
end

ctm_intersections(index).phase = f;
for i=1:size(ctm_intersections(index).phases,1)
    if i==f
        a = 1;
    else
        a=0;
    end
    for j=ctm_intersections(index).phases(i,1):ctm_intersections(index).phases(i,2)
        ctm_links(j).access = a;
    end
end

