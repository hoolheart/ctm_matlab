% @name: ctm_add_lane
% @objective: add a lane to the Cell-Transmission Model.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 22nd, 2013

function index = ctm_add_lane(t,cap,sat_rate,in_rate,out_rate)
% t(type): 0(normal)|1(input)|2(output); int
% cap: capacity; int
% sat_rate: saturation flow rate; float
% in_rate: input flow rate; float
% out_rate: rate of exit flow to all input flow; float<1
% index: return index of the new lane

% declare the variables
global ctm_valid ctm_sim ctm_cells ctm_links ctm_lanes

if ~ctm_valid
    error('The CTM has not been initialized.');
end
if ctm_sim
    error('No construction after starting the simulation.');
end

n_cell = length(ctm_cells);
n_link = length(ctm_links);
n_lane = length(ctm_lanes);

switch t
case 0
    if cap<30
        n=3;
    else
        n=round(cap/10);
    end
    c_cap = num2cell(cap/n*ones(1,n));
    ctm_cells(n_cell+1:n_cell+n) = struct('type',0,...
                                          'rate',sat_rate,...
                                          'cap',c_cap,...
                                          'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
    ctm_cells(n_cell+n+1) = struct('type',2,...
                                   'rate',Inf,...
                                   'cap',Inf,...
                                   'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
    ctm_cells(n_cell+n+2) = struct('type',1,...
                                   'rate',in_rate,...
                                   'cap',Inf,...
                                   'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
    l_type = cell(1,n-1); l_cells = cell(1,n-1); l_p = cell(1,n-1);
    l_type{1} = 2; l_cells{1} = [n_cell+1,n_cell+2,n_cell+n+1]; l_p{1} = 1-out_rate;
    l_type{2} = 1; l_cells{2} = [n_cell+2,n_cell+n+2,n_cell+3]; l_p{2} = sat_rate/(sat_rate+in_rate);
    for i=3:(n-1)
        l_type{i} = 0; l_cells{i} = [n_cell+i,n_cell+i+1]; l_p{i} = 1;
    end
    ctm_links(n_link+1:n_link+n-1) = struct('type',l_type,'cells',l_cells,'p',l_p,'access',1);
    ctm_lanes(n_lane+1)=struct('type',0,'cap',cap,'sat_rate',sat_rate,'in_rate',in_rate,'out_rate',out_rate,...
                               'in_cell',n_cell+n+2,'out_cell',n_cell+n+1,'o_cell',n_cell+1,'d_cell',n_cell+n,'out_link',n_link+1);
case 1
    n=max(round(cap/10),1);
    c_cap = num2cell(cap/n*ones(1,n));
    ctm_cells(n_cell+1) = struct('type',1,...
                                 'rate',in_rate,...
                                 'cap',Inf,...
                                 'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
    ctm_cells(n_cell+2:n_cell+n+1) = struct('type',0,...
                                            'rate',sat_rate,...
                                            'cap',c_cap,...
                                            'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
    ctm_lanes(n_lane+1)=struct('type',1,'cap',cap,'sat_rate',sat_rate,'in_rate',in_rate,'out_rate',0,...
                               'in_cell',n_cell+1,'out_cell',0,'o_cell',n_cell+2,'d_cell',n_cell+n+1,'out_link',0);
    l_cells = cell(1,n);
    for i=1:n
        l_cells{i} = [n_cell+i,n_cell+i+1];
    end
    ctm_links(n_link+1:n_link+n) = struct('type',0,'cells',l_cells,'p',1,'access',1);
case 2
    ctm_cells(n_cell+1) = struct('type',2,...
                                 'rate',Inf,...
                                 'cap',Inf,...
                                 'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
    ctm_lanes(n_lane+1)=struct('type',2,'cap',Inf,'sat_rate',Inf,'in_rate',0,'out_rate',1,...
                               'in_cell',0,'out_cell',n_cell+1,'o_cell',n_cell+1,'d_cell',n_cell+1,'out_link',0);
end
index = n_lane+1;
