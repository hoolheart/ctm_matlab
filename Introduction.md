# Introduction to Matlab Toolkit for Cell-Transmission Model
> By Huide Zhou  
> Université de Technologie de Belfort-Montbéliard  
> E-mail: prettyage.new@gmail.com

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

    A normal cell represents a piece of traffic area. The vehicles can move into a cell, stay there or move out of it. Its setting consists of the capacity, the number of contained vehicles and the possible maximum flow rate.

2. input cell

    An input cell represents the outside of the transportation system which feeds the vehicles into the traffic area. It is only the abstract representation of the traffic demands, which doesn't physically exist. Its setting consists of the input flow rate and the number of vehicles which want to enter the system currently.

3. output cell

    An output cell represents the outside which absorbs the vehicles from the system. It is the abstract representation of the destination, which doesn't physically exist either. Its setting consists of the number of vehicles which have leave the system to this cell.

#### Links

The links describe how the cells are connected. There are also three types:

1. direct link

    The direct link is the most common type, which connects two cells. In any interval, the flow volume of a direct link is the minimum of the possible output of the upstream cell and the possible input of the downstream cell.

2. merge link

    The merge link describes the case that the vehicles from two cells want to enter the same third cell. Its volume is determined by the possible outputs of two upstream cells, the possible input of the downstream cell and the proportion (spill back) of two directions.

3. diverge link

    The diverge link describes the case that the vehicles from a cell will separate into two cells. Its volume is determined by the possible output of the upstream cell, the possible inputs of two downstream cells and the proportion of two directions.

**Note** that in order to simplify the model and increase the simulation efficiency, the merge link and diverge link both only concern two directions. If the real merge or the diverge involves more than two directions, it should be represented by more than one links.

#### Traffic Lanes

The traffic lanes are usually the minimal measurable units of the traffic area. Indeed, they are also the minimal controlled units by the signals. That's why I choose them as the upper-element for the modeling.

In detail, by considering the positions, the lanes can be classified into three types:

1. normal lane

    Most lanes belong to this class. A normal lane has input flow, output flow, and it connects two intersections. The traffic area of a lane will be separated into several cells automatically after the parameters of the lane are given. Furthermore, a normal lane also includes a input cell and a output cell to represent its input and output flow.

2. input lane

    The input lane is like the normal lane. There are two major differences. One is that the input lane has no upper intersection. The other is that there is no need to consider the output flow on it, so it has no output cell.

3. output lane

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
