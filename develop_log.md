# Cell-Transmission Model on MATLAB

Implementation of Cell-Transmission Model in platform of MATLAB

### type of cell, link and lane
> Date: August 23rd, 2013

type | cell   | lane   | link
-----|--------|--------|----------
0    | normal | normal | straight
1    | input  | input  | merge
2    | output | output | diverge

### construction of the model
> Date: August 22nd, 2013

The model variables are put into the global workspace. The lists of cells and links are the fundamental elements of the model. But, the cells and links are not created directly for avoiding the complexity. Instead, the lists of lanes and intersections are constructed, and when a lane or an intersection is added, the correspondent cells and links are added into the model.

In detail, the construction of the model consists of the following functions:

    reset_ctm()
    ctm_add_lane(t,cap,sat_rate,in_rate,out_rate)
    ctm_add_int(in_lanes,out_lanes,cells)
    ctm_add_phase(index,links)

### simulation
> Date: August 23rd, 2013

Every step of the simulation consists of three steps:

1. calculate the possible in/out flows (based on cell settings)
2. calculate the real flows (based on link settings)
3. update the lengths of cells

Furthermore, during the simulation, some parameters should be able to be modified, such as the phases of intersections (+1) and the rates of lanes.

### read results
> Date: August 23rd, 2013

The simulation result should be able to be appropriately read. In detail, the following reading functions should be defined.

    c_lens = ctm_read_cells()
    queues = ctm_read_lanes()
    phases = ctm_read_phases()

### read outputs and inputs
> Date: February 10th, 2014

For each lane, it is very useful to read its outputs and remaining inputs to evaluate the performance of the system:

1. `outputs = ctm_read_lane_outputs()`: return the number of vehicles that leave the lanes to the outside.
2. `inputs = ctm_read_lane_intputs()`: return the number of vehicles that are supposed to enter the lanes but prevented by the congestions.

Furthermore, to make the evaluation conviente, the function `ctm_clean_outputs()` is used to clean all output data for the lanes.

### DEBUG: delay calculation
> Date: February 10th, 2014

The original delay calculation is wrong. Indeed, the formula can be reduced to a very simple form:

	$$D_i(k) = dT(n_i(k)-out_i(k))$$

### add link including more than one lanes
> Date: February 24th, 2014

The version 1.0 doesn't support adding the link which consists of more than one lanes. For such case, the lanes should be modeled individually, which is complex and inconvenient.

To this end, the following function is added today:

	index = ctm_add_link(t,len,n_lanes,sat_rate,in_rate,out_rate)
