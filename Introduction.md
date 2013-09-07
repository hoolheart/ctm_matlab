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

### Cells

A cell is the minimum unit of CTM. Generally, there are three types:

1. normal cell

    A normal cell represents a piece of traffic area. The vehicles can move into a cell, stay there or move out of it. Its setting consists of the capacity, the number of contained vehicles and the possible maximum flow rate.

2. input cell

    An input cell represents the outside of the transportation system which feeds the vehicles into the traffic area. It is only the abstract representation of the traffic demands, which doesn't physically exist. Its setting consists of the input flow rate and the number of vehicles which want to enter the system currently.

3. output cell

    An output cell represents the outside which absorbs the vehicles from the system. It is the abstract representation of the destination, which doesn't physically exist either. Its setting consists of the number of vehicles which have leave the system to this cell.

### Links
