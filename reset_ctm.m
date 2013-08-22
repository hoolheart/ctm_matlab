% @name: reset_ctm
% @objective: reset the Cell-Transmission Model.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 22nd, 2013

function reset_ctm()

% declare the variables
global ctm_valid ctm_w_vf ctm_cells ctm_links ctm_lanes ctm_intersections

% define the parameter w/vf
ctm_w_vf = 1;

% initialize the variables
ctm_cells = struct('type',{},'rate',{},'cap',{},'length',{},'pos_in',{},'pos_out',{},'in',{},'out',{});
ctm_links = struct('type',{},'cells',{},'p',{},'access',{});
ctm_lanes = struct('type',{},'cap',{},'sat_rate',{},'in_rate',{},'out_rate',{},'in_cell',{},'out_cell',{},'o_cell',{},'d_cell',{});
ctm_intersections = struct('in_cells',{},'out_cells',{},'cells',{},'phases',{},'phase',{});

% validate the model
ctm_valid = true;
