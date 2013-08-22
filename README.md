# ctm_matlab

Implementation of Cell-Transmission Model in platform of MATLAB

### construction of the model
> Date: August 22nd, 2013

The model variables are put into the global workspace. The lists of cells and links are the fundamental elements of the model. But, the cells and links are not created directly for avoiding the complexity. Instead, the lists of lanes and intersections are constructed, and when a lane or an intersection is added, the correspondent cells and links are added into the model.

In detail, the construction of the model consists of the following functions:

    reset_ctm()
    ctm_add_lane(t,cap,sat_rate,in_rate,out_rate)
    ctm_add_int(in_lanes,out_lanes,cells)
    ctm_add_phase(index,links)
