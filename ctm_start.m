% @name: ctm_start
% @objective: start the simulation of the Cell-Transmission Model.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 23rd, 2013

function ctm_start(queues,phases)
% queues: list of queue lengths of all lanes
% phases: list of phases of all intersections

% declare the variables
global ctm_valid ctm_sim ctm_lanes ctm_intersections

if ~ctm_valid
    error("The CTM has not been initialized.");
end
if ctm_sim
    error("The simulation has been started.");
end

switch nargin
case 0
    if ctm_check_phases() && ctm_check_cells()
        ctm_sim = true;
    else
        error("The phases must be set valid before starting the simulation.");
    end
    break;
case 2
    if length(queues)~=length(ctm_lanes) || length(phases)~=length(ctm_intersections)
        error("Wrong parameters.");
    end
    for i=1:length(queues)
        ctm_set_queue(i,queues(i));
    end
    for i=1:length(phases)
        ctm_set_phase(i,phases(i));
    end
    ctm_sim = true;
    break;
otherwise
    error("Wrong number of parameters for starting the simulation.");
end

