% @name: ctm_add_phase
% @objective: add a phase to an intersection of the Cell-Transmission Model.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 22nd, 2013

function ctm_add_phase(index,links)
% index: index of the intersection
% links: information of the correspondent links of the phase [type p c1t c1i c2t c2i c3t c3i;...]

% declare the variables
global ctm_valid ctm_sim ctm_links ctm_intersections

if ~ctm_valid
    error('The CTM has not been initialized.');
end
if ctm_sim
    error('No construction after starting the simulation.');
end

n_link = length(ctm_links);
n = size(links,1);

%l_type = cell(1:n);
l_type = num2cell(links(:,1));
l_cells = cell(n,1);
l_p = cell(n,1);
for i=1:n
%    l_type{i} = links(i,1);
    switch l_type{i}
    case 0
        l_p{i} = 1;
        switch links(i,3)
        case 0
            a = ctm_intersections(index).cells(links(i,4));
        case 1
            a = ctm_intersections(index).in_cells(links(i,4));
        case 2
            a = ctm_intersections(index).out_cells(links(i,4));
        end
        switch links(i,5)
        case 0
            b = ctm_intersections(index).cells(links(i,6));
        case 1
            b = ctm_intersections(index).in_cells(links(i,6));
        case 2
            b = ctm_intersections(index).out_cells(links(i,6));
        end
        l_cells{i} = [a,b];
    case {1, 2}
        l_p{i} = links(i,2);
        switch links(i,3)
        case 0
            a = ctm_intersections(index).cells(links(i,4));
        case 1
            a = ctm_intersections(index).in_cells(links(i,4));
        case 2
            a = ctm_intersections(index).out_cells(links(i,4));
        end
        switch links(i,5)
        case 0
            b = ctm_intersections(index).cells(links(i,6));
        case 1
            b = ctm_intersections(index).in_cells(links(i,6));
        case 2
            b = ctm_intersections(index).out_cells(links(i,6));
        end
        switch links(i,7)
        case 0
            c = ctm_intersections(index).cells(links(i,8));
        case 1
            c = ctm_intersections(index).in_cells(links(i,8));
        case 2
            c = ctm_intersections(index).out_cells(links(i,8));
        end
        l_cells{i} = [a,b,c];
    end
end
ctm_links(n_link+1:n_link+n) = struct('type',l_type,'cells',l_cells,'p',l_p,'access',0);

ctm_intersections(index).phases = [ctm_intersections(index).phases;n_link+1,n_link+n];

