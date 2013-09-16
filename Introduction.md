# Introduction to Matlab Toolkit for Cell-Transmission Model
> By Huide Zhou  
> Université de Technologie de Belfort-Montbéliard  
> E-mail: ![prettyage.new@gmail.com][person_gmail]

### Table of Content

[TOC]

### Motive

The Cell-Transmission Model (CTM) is an accurate model for the transportation system. It was originally employed for simulating the highway system. Later, its application was expanded into the urban transportation. Now, CTM has become a widely-used simulation tool, and an important element of the related commercial software TRANSYT since its 13th version.

However, to my knowledge, there has not been a non-commercial CTM software for the simulation of the urban transportation system yet. The objective of this project is to design such a toolkit in platform of MATLAB which can build up and run CTM  models for any transportation system by following certain principles. The subsequent part will describe these modeling principles and the way to use this toolkit.

### Overview

CTM is composed by "cells" which are connected by "links". The behaviors of cells and links determine the dynamic of the system. But, if the modeling is performed in the level of cells and links, it would be very inconvenience. Because even a simple system, like a single intersection, can contain enormous cells and links. Hence, as the effective modeling tool, it must allow people build the model in an upper level.

The current version chooses the lanes and intersections. People need only concern the traffic lanes and the intersections, the corresponding cells and links can be automatically created and controlled.

### Modeling

#### Cells

A cell is the minimum unit of CTM. Generally, there are three types:

1. normal cell

    ![Normal Cell][cell_nor]
    A normal cell represents a piece of traffic area. The vehicles can move into a cell, stay there or move out of it. Its setting consists of the capacity, the number of contained vehicles and the possible maximum flow rate.

2. input cell

    ![Input Cell][cell_in]
    An input cell represents the outside of the transportation system which feeds the vehicles into the traffic area. It is only the abstract representation of the traffic demands, which doesn't physically exist. Its setting consists of the input flow rate and the number of vehicles which want to enter the system currently.

3. output cell

    ![Output Cell][cell_out]
    An output cell represents the outside which absorbs the vehicles from the system. It is the abstract representation of the destination, which doesn't physically exist either. Its setting consists of the number of vehicles which have leave the system to this cell.

#### Links

The links describe how the cells are connected. There are also three types:

1. direct link

    ![Direct Link][link_direct]
    The direct link is the most common type, which connects two cells. In any interval, the flow volume of a direct link is the minimum of the possible output of the upstream cell and the possible input of the downstream cell.

2. merge link

    ![Merge Link][link_merge]
    The merge link describes the case that the vehicles from two cells want to enter the same third cell. Its volume is determined by the possible outputs of two upstream cells, the possible input of the downstream cell and the proportion (spill back) of two directions.

3. diverge link

    ![Diverge Link][link_diverge]
    The diverge link describes the case that the vehicles from a cell will separate into two cells. Its volume is determined by the possible output of the upstream cell, the possible inputs of two downstream cells and the proportion of two directions.

**Note** that in order to simplify the model and increase the simulation efficiency, the merge link and diverge link both only concern two directions. If the real merge or the diverge involves more than two directions, it should be represented by more than one links.

#### Traffic Lanes

The traffic lanes are usually the minimal measurable units of the traffic area. Indeed, they are also the minimal controlled units by the signals. That's why I choose them as the upper-element for the modeling.

In detail, by considering the positions, the lanes can be classified into three types:

1. normal lane

    ![Normal Lane][lane_nor]
    Most lanes belong to this class. A normal lane has input flow, output flow, and it connects two intersections. The traffic area of a lane will be separated into several cells automatically after the parameters of the lane are given. Furthermore, a normal lane also includes a input cell and a output cell to represent its input and output flow.

2. input lane

    ![Input Lane][lane_in]
    The input lane is like the normal lane. There are two major differences. One is that the input lane has no upper intersection. The other is that there is no need to consider the output flow on it, so it has no output cell.

3. output lane

    ![Output Lane][lane_out]
    The output lane is the simplest type of lane. It only corresponds to an output cell.

#### Traffic Intersections

The traffic intersections are the areas where different traffic flows meet and conflict. A typical intersection consists of the input lanes, the output lanes and the conflict area.

To describe the flows within the intersection, the conflict area should be separated into several cells to simplify the modeling.

Then, in different phase, the flows in one intersection are different. Hence, every phase corresponds to a set of links.

The setting of an intersection consists of two steps:

1. Add the intersection with the setting of the inner cells;
2. Add phases by defining their correspondent sets of links.

### Example

To explain better the modeling process, this part will build the CTM for a network including four intersections.

These four intersections all have two phases corresponding to the horizontal and vertical directions. According to the following picture, the conflict area is divided into 6 inner cells, and the two phases both have 6 links.

![Intersection with Two Phases][int_2phase]

The Cell-Transmission Model of the whole system is illustrated as follows. It is observed that the system includes 8 normal lanes, 8 input lanes and 8 output lanes.

![Transportation Network Including 4 Intersections][sys_4int]

`examples\example_4intersection.m` describes the modeling process and the simulation in detail.

### Function References

The functions in `scripts` forder are introduced in this section.

1. `reset_ctm`
1. `ctm_add_lane`
1. `ctm_add_int`
1. `ctm_add_phase`
1. `ctm_set_queue`
1. `ctm_set_phase`
1. `ctm_check_cells`
1. `ctm_check_phases`
1. `ctm_clean_all`
1. `ctm_start`
1. `ctm_stop`
1. `ctm_simulation`
1. `ctm_add_inputs`
1. `ctm_mod_lane_rate`
1. `ctm_switch_int`
1. `ctm_read_cells`
1. `ctm_read_lanes`
1. `ctm_read_phases`
1. `ctm_read_lane_delays`
1. `ctm_read_total_delay`
1. `ctm_reset_delay`

[person_gmail]: mailto:prettyage.new@gmail.com
[cell_nor]: /pics/cell_nor.png
[cell_in]: /pics/cell_in.png
[cell_out]: /pics/cell_out.png
[link_direct]: /pics/link_nor.png
[link_merge]: /pics/link_merge.png
[link_diverge]: /pics/link_diverge.png
[lane_nor]: /pics/lane_nor.png
[lane_in]: /pics/lane_in.png
[lane_out]: /pics/lane_out.png
[int_2phase]: /pics/int_2phase.png
[sys_4int]: /pics/ctm_4int.png

