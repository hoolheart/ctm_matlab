% @name: ctm_clean_all
% @objective: clean the Cell-Transmission Model to the state before any simulation.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 22nd, 2013

function ctm_clean_all()

% declare the variables
global ctm_valid ctm_sim ctm_cells ctm_links ctm_lanes ctm_intersections

if ctm_valid
    ctm_sim = false;
    [ctm_cells.length] = deal(0);
    [ctm_cells.pos_in] = deal(0);
    [ctm_cells.pos_out] = deal(0);
    [ctm_cells.in] = deal(0);
    [ctm_cells.out] = deal(0);
    [ctm_intersections.phase] = deal(0);
    for i=1:length(ctm_intersections)
        phases = ctm_intersections(i).phases;
        for j=1:size(phases,1)
            for k=phases(j,1):phases(j,2)
                ctm_links(k).access = 0;
            end
        end
    end
end
