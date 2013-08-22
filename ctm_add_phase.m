% @name: ctm_add_phase
% @objective: add a phase to an intersection of the Cell-Transmission Model.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 22nd, 2013

function ctm_add_phase(index,links)
% index: index of the intersection
% links: information of the correspondent links of the phase

% declare the variables
global ctm_valid ctm_links ctm_intersections

if !ctm_valid
    error("The CTM has not been initialized.");
end

n_link = length(ctm_links);
n = size(links,1);

l_type = cell(1:n);
l_cells = cell(1:n);
l_p = cell(1:n);
for i=1:n
    l_type(i) = links(i,1);
    switch l_type(i)
    case 0
        l_p(i) = 1;
        switch links(i,3)
        case 0
            a = ctm_intersections(index).cells(links(i,4));
            break;
        case 1
            a = ctm_intersections(index).in_cells(links(i,4));
            break;
        case 2
            a = ctm_intersections(index).out_cells(links(i,4));
            break;
        end
        switch links(i,5)
        case 0
            b = ctm_intersections(index).cells(links(i,6));
            break;
        case 1
            b = ctm_intersections(index).in_cells(links(i,6));
            break;
        case 2
            b = ctm_intersections(index).out_cells(links(i,6));
            break;
        end
        l_cells(i) = [a,b];
        break;
    case 1
    case 2
        l_p(i) = links(i,2);
        switch links(i,3)
        case 0
            a = ctm_intersections(index).cells(links(i,4));
            break;
        case 1
            a = ctm_intersections(index).in_cells(links(i,4));
            break;
        case 2
            a = ctm_intersections(index).out_cells(links(i,4));
            break;
        end
        switch links(i,5)
        case 0
            b = ctm_intersections(index).cells(links(i,6));
            break;
        case 1
            b = ctm_intersections(index).in_cells(links(i,6));
            break;
        case 2
            b = ctm_intersections(index).out_cells(links(i,6));
            break;
        end
        switch links(i,7)
        case 0
            c = ctm_intersections(index).cells(links(i,8));
            break;
        case 1
            c = ctm_intersections(index).in_cells(links(i,8));
            break;
        case 2
            c = ctm_intersections(index).out_cells(links(i,8));
            break;
        end
        l_cells(i) = [a,b,c];
        break;
    end
end
ctm_links(n_link+1:n_link+n) = struct('type',l_type,'cells',l_cells,'p',l_p,'access',0);

ctm_intersections(index).phases = [ctm_intersections(index).phases;n_link+1,n_link+n];

