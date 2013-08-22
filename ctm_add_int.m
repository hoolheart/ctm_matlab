% @name: ctm_add_int
% @objective: add an intersection to the Cell-Transmission Model.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 22nd, 2013

function ctm_add_int(in_lanes,out_lanes,cells)
% in_lanes: list of input lanes
% out_lanes: list of output lanes
% cells: information of the inner cells of the intersection

% declare the variables
global ctm_valid ctm_cells ctm_lanes ctm_intersections

if !ctm_valid
    error("The CTM has not been initialized.");
end

n_cell = length(ctm_cells);
n_int = length(ctm_intersections);

in_cells = zeros(1,length(in_lanes));
for i=1:length(in_lanes)
    in_cells(i) = ctm_lanes(in_lanes(i)).d_cell;
end
out_cells = zeros(1,length(out_lanes));
for i=1:length(out_lanes)
    out_cells(i) = ctm_lanes(out_lanes(i)).o_cell;
end

n = size(cells,1);
c_cap = cell(1,n); c_rate = cell(1,n);
for i=1:n
    c_cap(i) = cells(i,1);
    c_rate(i) = cells(i,2);
end
ctm_cells(n_cell+1:n_cell+n) = struct('type',0,'rate',c_rate,'cap',c_cap,...
                                      'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
inner_cells = n_cell+1:n_cell+n;

ctm_intersections(n_int+1) = struct('in_cells',in_cells,'out_cells',out_cells,'cells',inner_cells,...
                                    'phases',zeros(0,2),'phase',0);

