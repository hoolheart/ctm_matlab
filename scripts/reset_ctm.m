% @name: reset_ctm
% @objective: reset the Cell-Transmission Model.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 22nd, 2013

function reset_ctm(vf,w,v_l,pos_dt)

% declare the variables
global ctm_valid ctm_sim ctm_w_vf ctm_vf ctm_veh_length ctm_cell_length ctm_cells ctm_links ctm_lanes ctm_intersections

% define the parameter w/vf
switch nargin
    case 0
        ctm_vf = 10;
        ctm_w_vf = 1;
        ctm_veh_length = 5;
        ctm_cell_length = 2;
    case 4
        ctm_vf = vf;
        ctm_w_vf = w/vf;
        ctm_veh_length = v_l;
        ctm_cell_length = ceil(vf*pos_dt/v_l);
    otherwise
        error('Wrong number of parameters for reset the cell-transmission model.');
end

% initialize the variables
ctm_cells = struct('type',{},'rate',{},'cap',{},'length',{},'pos_in',{},'pos_out',{},'in',{},'out',{},'delay',{});
ctm_links = struct('type',{},'cells',{},'p',{},'access',{});
ctm_lanes = struct('type',{},'cap',{},'sat_rate',{},'in_rate',{},'out_rate',{},'in_cell',{},'out_cell',{},'o_cell',{},'d_cell',{},'out_link',{});
ctm_intersections = struct('in_cells',{},'out_cells',{},'cells',{},'phases',{},'phase',{});

% validate the model
ctm_valid = true;
ctm_sim = false;
