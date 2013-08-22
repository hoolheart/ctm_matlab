% @name: ctm_add_lane
% @objective: add a lane to the Cell-Transmission Model.
% @author: Huide ZHOU
% @institute: Lab IRTES-SeT, UTBM, France
% @date: AUG 22nd, 2013

function ctm_add_lane(t,cap,sat_rate,in_rate,out_rate)
% t(type): 0(normal)|1(input)|2(output); int
% cap: capacity; int
% sat_rate: saturation flow rate; float
% in_rate: input flow rate; float
% out_rate: rate of exit flow to all input flow; float<1

% declare the variables
global ctm_valid ctm_cells ctm_links ctm_lanes

if !ctm_valid
    error("The CTM has not been initialized.");
end

n_cell = length(ctm_cells);
n_link = length(ctm_links);
n_lane = length(ctm_lanes);

switch t
case 0
%    ctm_lanes(n_lane+1).type = 0;
%    ctm_lanes(n_lane+1).cap = cap;
%    ctm_lanes(n_lane+1).sat_rate = sat_rate;
%    ctm_lanes(n_lane+1).in_rate = in_rate;
%    ctm_lanes(n_lane+1).out_rate = out_rate;
    if cap<30
        c_cap={cap/3,cap/3,cap/3};
        n=3;
    else
        n=floor(cap/10);
        c_cap = cell(1,n);
        for i=1:(n-1)
            c_cap(i) = 10;
        end
        c_cap(n) = cap-10*(n-1);
    end
    ctm_cells(n_cell+1:n_cell+n) = struct('type',0,...
                                          'rate',sat_rate,...
                                          'cap',c_cap,...
                                          'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
%    for i=1:n
%        ctm_cells(n_cell+i).type = 0;
%        ctm_cells(n_cell+i).rate = sat_rate;
%        ctm_cells(n_cell+i).cap = c_cap;
%        ctm_cells(n_cell+i).length = 0;
%        ctm_cells(n_cell+i).pos_in = 0;
%        ctm_cells(n_cell+i).pos_out = 0;
%        ctm_cells(n_cell+i).in = 0;
%        ctm_cells(n_cell+i).out = 0;
%    end
%    ctm_cells(n_cell+n+1).type = 2;
    ctm_cells(n_cell+n+1) = struct('type',2,...
                                   'rate',Inf,...
                                   'cap',Inf,...
                                   'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
%    ctm_cells(n_cell+n+2).type = 1;
%    ctm_cells(n_cell+n+2).rate = in_rate;
    ctm_cells(n_cell+n+2) = struct('type',1,...
                                   'rate',in_rate,...
                                   'cap',Inf,...
                                   'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
%    ctm_lanes(n_lane+1).in_cell = n_cell+n+2;
%    ctm_lanes(n_lane+1).out_cell = n_cell+n+1;
%    ctm_lanes(n_lane+1).o_cell = n_cell+1;
%    ctm_lanes(n_lane+1).d_cell = n_cell+n;
    ctm_lanes(n_lane+1)=struct('type',1,'cap',cap,'sat_rate',sat_rate,'in_rate',in_rate,'out_rate',out_rate,...
                               'in_cell',n_cell+n+2,'out_cell',n_cell+n+1,'o_cell',n_cell+1,'d_cell',n_cell+n);
    l_type = cell(1,n-1); l_cells = cell(1,n-1); l_p = cell(1,n-1);
    l_type(1) = 2; l_cells(1) = [n_cell+1,n_cell+2,n_cell+n+1]; l_p(1) = 1-out_rate;
    l_type(2) = 1; l_cells(2) = [n_cell+2,n_cell+n+2,n_cell+3]; l_p(2) = sat_rate/(sat_rate+in_rate);
    for i=3:(n-1)
        l_type(i) = 0; l_cells(i) = [n_cell+i,n_cell+i+1]; l_p(i) = 1;
    end
    ctm_links(n_link+1:n_link+n-1) = struct('type',l_type,'cells',l_cells,'p',l_p,'access',1);
    break;
case 1
%    ctm_lanes(n_lane+1).type = 1;
%    ctm_lanes(n_lane+1).cap = cap;
%    ctm_lanes(n_lane+1).sat_rate = sat_rate;
%    ctm_lanes(n_lane+1).in_rate = in_rate;
    n=floor(cap/10);
    c_cap = cell(1,n);
    for i=1:(n-1)
        c_cap(i) = 10;
    end
    c_cap(n) = cap-10*(n-1);
%    ctm_cells(n_cell+1).type = 1;
%    ctm_cells(n_cell+1).rate = in_rate;
    ctm_cells(n_cell+1) = struct('type',1,...
                                 'rate',in_rate,...
                                 'cap',Inf,...
                                 'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
    ctm_cells(n_cell+2:n_cell+n+1) = struct('type',0,...
                                          'rate',sat_rate,...
                                          'cap',c_cap,...
                                          'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
%    ctm_lanes(n_lane+1).in_cell = n_cell+1;
%    ctm_lanes(n_lane+1).out_cell = 0;
%    ctm_lanes(n_lane+1).o_cell = n_cell+2;
%    ctm_lanes(n_lane+1).d_cell = n_cell+n+1;
    ctm_lanes(n_lane+1)=struct('type',1,'cap',cap,'sat_rate',sat_rate,'in_rate',in_rate,'out_rate',0,...
                               'in_cell',n_cell+1,'out_cell',0,'o_cell',n_cell+2,'d_cell',n_cell+n+1);
    l_cells = cell(1,n);
    for i=1:n
        l_cells(i) = [n_cell+i,n_cell+i+1];
    end
    ctm_links(n_link+1:n_link+n-1) = struct('type',0,'cells',l_cells,'p',1,'access',1);
    break;
case 2
    ctm_cells(n_cell+1) = struct('type',2,...
                                 'rate',Inf,...
                                 'cap',Inf,...
                                 'length',0,'pos_in',0,'pos_out',0,'in',0,'out',0);
    ctm_lanes(n_lane+1)=struct('type',2,'cap',Inf,'sat_rate',Inf,'in_rate',0,'out_rate',1,...
                               'in_cell',0,'out_cell',n_cell+1,'o_cell',0,'d_cell',0);
    break;
end

