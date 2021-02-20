# -*- coding: utf-8 -*-
"""
Created on Tue Jul 23 13:27:26 2019

@author: Silvia Massaro; Istituto Nazionale di Geofisica e Vulcanologia (Bologna, Italy)
"""

#Function to create the probability map:
def show_grid_map(heatmap_data, img_file, out_img):
    import matplotlib
    
    #Reading of background image (DEM)
    import matplotlib.image as mpimg 
    map_img = mpimg.imread(img_file) 
    
    #Importing library to create the heatmap 
    import seaborn as sns; sns.set()
    from matplotlib import pyplot as plt 
    my_dpi = 96  #dpi (dots per inch)
    plt.figure(figsize=(1400/my_dpi, 1200/my_dpi), dpi=my_dpi) 
    hmax = sns.heatmap(heatmap_data,
                cmap = matplotlib.cm.inferno, 
                alpha = 0.55, 
                annot = False,
                zorder = 2,
                )
    hmax.imshow(map_img,
              aspect = hmax.get_aspect(),
              extent = hmax.get_xlim() + hmax.get_ylim(),
              zorder = 1) #put the map under the heatmap
    
    plt.xticks([])
    plt.yticks([])
    
    
    plt.savefig(out_img, dpi = my_dpi)
    
################################################################################
#Import the heatmap with weights and then calculate the best-guess probability:

from heatmap_weights import heatmap_data

#################################################################################
# Call function
#################################################################################

from matplotlib import pyplot as plt
background = 'dem.png'
show_grid_map(heatmap_data, background, 'best_guess.png')
plt.savefig('/Users/silviamassaro/Documents/ARTICOLI_in_progresso/La_Soufrière_GBF/GBF_draft_/supplementary_material/spatial_map_vents_opening/map.eps',  format = 'eps')
#change PATH accordingly to your folder

from scipy.ndimage import gaussian_filter
sigma = 40,3 # grid spacing
show_grid_map(gaussian_filter(heatmap_data, sigma=1), 
              background, 
              'filtered.png')
