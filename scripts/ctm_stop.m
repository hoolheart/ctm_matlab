% @name: ctm_stop
% @objective: stop the simulation of the Cell-Transmission Model.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 23rd, 2013

function ctm_stop()

% declare the variables
global ctm_valid ctm_sim

if ~ctm_valid
    error('The CTM has not been initialized.');
end
if ~ctm_sim
    error('The simulation has not been started.');
end

ctm_sim = false;
