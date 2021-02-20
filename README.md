# Probabilistic Hazard Assessment for Ballistics
Silvia Massaro. Istituto Nazionale di Geofisica e Vulcanologia, Bologna, Italy. Email: silvia.massaro@ingv.it
Eduardo Rossi. Univèrsite de Genève, Switzerland. Email: Eduardo.Rossi@unige.ch

### PACKAGES CONTENT AND DESCRIPTION ###

The package contains the following scripts:
- "heatmap.py", in the "spatial_map_vents_opening" folder. This script is able to provide the spatial probability map of vent opening for future explosive explosions at La Soufrière de Guadeloupe volcano (Lesser Antilles). 
This probability is derived on the base of existing literature data on the main geological structures, historical eruptive vents, past observed fumarolic activity and measurements of the present-day gas emission rates. 
Following the approach by Selva et al. (2012), the script considers indicators of the susceptibility to vent opening, ranking them in terms of importance and considering potential uncertainty on data. 
According to this approach, we quantify the conditional probability of vent opening, given an explosive event, in the generic k-th cell out of all possible number of cells (N) into which the volcanic domain has been divided. 
In this case a domain grid of 98 × 98 cells is set, considering a cell spacing of 40 m. 
To each k-th cell, we assign a total score ω_k which equals the sum of five scores on the following features: 

	- a score of 1 if the k-th cell is inside the domain but outside the dome
	- a score of 2 if the k-th cell is inside the domain and inside the dome
	- a score of 3 if in the k-th cell  there are main geological structures (fractures and faults)
	- a score of 4 if in the k-th cell there have been past observed fumaroles
	- a score of 5 if in the k-th cell there is present-day fumarolic activity and/or significant gas fluxes.

The weights are imported from the heatmap_weights.py, in order to calculated the best-guess probability of vent opening. To do this, the topography of the interested area is required as background image in .png. 
This spatial probability map can be reproduced for La Soufrière de Guadeloupe case study, but the script can be properly modified to other areas. 
The outputs return the best-guess probability map (in png and eps formats), the filtred best-guess probability map in png, and the "results_probabilities.txt" file containing the matrix of the spatial probability for each cell of the computational domain. 


- "probability_maps_GBF.m", in the "GBF_postprocessing_tool" folder. This script is built to reproduce the probability to exceed a given energy threshold E_t in each cell of the computational domain, considering La Soufrière de Guadeloupe case study. In particular, it is possible to plot two different types of maps in presence and absence of wind:
 
- a map showing the probability P' which defines the probability to exceed a given threshold E_t as a function of the number of VBPs fallen in the cell A_ij; 
a map showing the overall probability P which combines the probability P' with the f_A_ij, which is the probability that a clast reaches that cell. 

For the sake of simplicity, a data structure is provided ("allData_11vents.mat") containing the whole set of simulations carried out with the Great Balls of Fire (GBF) model. The simulations are referred to 11 vents (10 vents located at the centre of the macroareas defined on the spatial probability map of vent opening, and 1 vent located at the centre of the dome). Each vent has a weight w'_k which derives from the sum of the probabilities of vent opening of the N_j cells of the finer vent-grid belonging to the considered macroarea. 

### DEPENDENCIES AND INSTALLATION INSTRUCTIONS ###
The following software are required:

-python3 

-MATLAB

-Great Balls of Fire (GBF): A probabilistic approach to quantify the hazard related to ballistics model (Sébastien Biass, Jean-Luc Falcone, Costanza Bonadonna). GBF is a free and open source software. Last Release:*Apr 2018*.



