MATLAB Toolkit for Cell-Transmission Model
====

> By Huide Zhou  
> Université de Technologie de Belfort-Montbéliard  
> E-mail: ![prettyage.new@gmail.com][person_gmail]  
> Version: 0.1

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

1. `reset_ctm(vf,w,v_l,pos_dt)`

    @objective: reset the Cell-Transmission Model  
    `vf`: free speed of the vehicles (m/s)  
    `w`: spill back speed (m/s)  
    `v_l`: average vehicle length (m)  
    `pos_dt`: possible simulation interval (s)  
    @note: if the parameters are default, their values are set to be `(10,10,5,1)`

1. `index = ctm_add_lane(t,cap,sat_rate,in_rate,out_rate)`

    @objective: add a lane to the Cell-Transmission Model  
    `t(type)`: 0(normal)|1(input)|2(output); int  
    `cap`: capacity; int  
    `sat_rate`: saturation flow rate; float  
    `in_rate`: input flow rate; float  
    `out_rate`: rate of exit flow to all input flow; float \[0,1]  
    `index`: return index of the new lane

1. `index = ctm_add_int(in_lanes,out_lanes,cells)`

    @objective: add an intersection to the Cell-Transmission Model  
    `in_lanes`: list of input lanes  
    `out_lanes`: list of output lanes  
    `cells`: information of the inner cells of the intersection \[cap rate;...]  
    `index`: return the index of new intersection

1. `ctm_add_phase(index,links)`

    @objective: add a phase to an intersection of the Cell-Transmission Model  
    `index`: index of the intersection  
    `links`: information of the correspondent links of the phase \[type p c1t c1i c2t c2i c3t c3i;...]

1. `ctm_set_queue(index,q)`

    @objective: set the queue length of one lane  
    `index`: index of the lane  
    `q`: queue length

1. `ctm_set_phase(index,f)`

    @objective: set the phase of one intersection  
    `index`: index of the intersection  
    `f`: phase

1. `is_valid = ctm_check_cells()`

    @objective: check the validation of the lengths of all cells  
    `is_valid`: return the checking result; true|false

1. `is_valid = ctm_check_phases()`

    @objective: check the validation of the phases of all intersections  
    `is_valid`: return the checking result; true|false

1. `ctm_clean_all()`

    @objective: clean the Cell-Transmission Model to the state before any simulation

1. `ctm_start(queues,phases)`

    @objective: start the simulation of the Cell-Transmission Model  
    `queues`: list of queue lengths of all lanes  
    `phases`: list of phases of all intersections  
    @note: when this function is called without parameters, it will check the current states and start the simulation directly if the current states are valid

1. `ctm_stop`
1. `ctm_simulation(dt)`

    @objective: run the simulation of the Cell-Transmission Model  
    `dt`: simulation interval

1. `ctm_add_inputs(inputs)`

    @objective: add impulsive input to the lanes  
    `inputs`: impulsive inputs to all lanes

1. `ctm_mod_lane_rate(index,attr,rate)`

    @objective: modify the rate of lane  
    `index`: index of the lane  
    `attr`: specify the objective rate, 'in'|'out'|'sat'  
    `rate`: new value of rate

1. `ctm_switch_int(index)`

    @objective: switch the intersection into next phase  
    `index`: index of the intersection

1. `c_lens = ctm_read_cells()`

    @objective: read the lengths of all cells  
    `c_lens`: return the vector of all cell lengths

1. `queues = ctm_read_lanes()`

    @objective: read the lengths of all lanes  
    `queues`: return the vector of all queue lengths

1. `phases = ctm_read_phases()`

    @objective: read the current phases of all intersections  
    `phases`: return the vector of all intersection current phases

1. `delays = ctm_read_lane_delays()`

    @objective: read the delays of all lanes  
    `delays`: return the vector of delays of all lanes

1. `delay = ctm_read_total_delay()`

    @objective: read the total delay of the Cell-Transmission Model  
    `delay`: return the total delay

1. `ctm_reset_delay()`

    @objective: reset the delay of all cells

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

