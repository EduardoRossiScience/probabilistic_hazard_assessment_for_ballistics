# -*- coding: utf-8 -*-
"""
Created on Tue Jul 23 18:08:47 2019
@author: Silvia Massaro, Istituto Nazionale di Geofisica e Vulcanologia (Bologna, Italy)
"""

#Following Selva et al. (2012), we design a domain grid of 98 × 98 cells, thus N=9604.  
#The cell spacing is set to about 40 m. 
#To each cell, we assign a total score ω_k which equals the sum of five scores on the following features: 

#a score of 1 if the cell is inside the domain but outside the dome
#a score of 2 if the cell is inside the domain and inside the dome
#a score of 3 if in the cell  there are main geological structures (fractures and faults)
#a score of 4 if in the cell there have been past observed fumaroles
#a score of 5 if in the cell there is present-day fumarolic activity and/or significant gas fluxes. 

#To do so, we consider different sectors of the domain as follows:

import numpy as np

#############################################
#Weighted matrix
#############################################
n = 98 #number of cells along one direction (x or y)

heatmap_data = np.ones([n,n]) #To start, the matrix has all values = 1 (as default) 

#present-day ACTIVE FUMAROLES
heatmap_data[48:50,46:50] += 5

#FRACTURES
#NS sector
heatmap_data[39:50,46:47] += 3 # righe da 40 a 47 e colonna 46: assegno valore 3
heatmap_data[41:42,44:46] += 4
#E sector
heatmap_data[50:51,47:54] += 3
heatmap_data[51:52,52:54] += 3
#NW sector, fracture Faujas
heatmap_data[42:44,41:43] += 3
heatmap_data[42:43,39:41] += 4
heatmap_data[43:44,38:40] += 4
heatmap_data[44:47,37:38] += 4
#NE sector, fracture du NordEst
heatmap_data[42:44,49:50] += 3
heatmap_data[40:42,50:51] += 3
#S sector, past activity
heatmap_data[65:66,46:48] += 4
heatmap_data[69:71,47:48] += 4
#Ty fault
heatmap_data[62:64,50:52] += 3
heatmap_data[64:68,51:53] += 3
heatmap_data[60:62,49:51] += 3
heatmap_data[68:70,52:54] += 3
#SE sector, fract delCratèr Sud
heatmap_data[51:57,48:50] += 3
#NW sector, fracture du NordOvest
heatmap_data[44:46,44:45] += 3
heatmap_data[45:47,45:46] += 3
#PAST fumarolic activity
#Nord sector, 1976-77 source
heatmap_data[37:38,45:48] += 4
#NE sector, 1976-77 source
heatmap_data[44:47,55:56] += 4
#Est sector, 1976-77 source
heatmap_data[50:53,55:59] += 4
heatmap_data[55:58,54:57] += 4
#SSE 1976-77, Morue Mitan
heatmap_data[60:62,50:55] += 4
#SE sector, 1956 source
heatmap_data[53:54,50:51] += 4
#Sud sector, 2017 source
heatmap_data[61:62,49:50] += 4
#Inside DOME AREA
y,x = np.ogrid[-49:n-49, -45:n-45]
mask = x*x + y*y <= 11*11
heatmap_data[mask] += 2

#Outside the dome area, we do not assign any weight. In this case, weight = 0 above collapsing structures 
bordo = [60,60,60,60,60,60,60,60,60,60,60,58,57,54,51,51,49,47,45,41,39,39,36,
         34,34,33,33,31,31,28,28,27,27,27,26,25,25,25,25,25,25,25,25,25,25,25,25,25,
         28,28,31,30,27,27,27,27,27,27,24,24,24,24,24,24,24,24,24,24,24,31,31,31,31,31,
         33,33,33,33,35,35,35,35,35,35,35,40,40,40,40,43,43,43,45,45,45,45,45,45]
for c,r in enumerate(bordo): 
    heatmap_data[:r,c]=0
    
##############################
# Best guess probability
##############################
heatmap_data = heatmap_data / heatmap_data.sum()
np.savetxt('result_probabilities.txt', heatmap_data, fmt='%.2e') #save a text file of the probabilities 