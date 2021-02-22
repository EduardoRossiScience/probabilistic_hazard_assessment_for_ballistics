function probability_maps_GBF(allData, dem_X, dem_Y, dem_Z)

% This function determines the probability maps as presented in the paper 
% "Assessing hazard and potential impact associated with volcanic ballistic projectiles: 
% the example of La Soufrière de Guadeloupe volcano (Lesser Antilles)"
%
% Input data: 
% - allData: it is a structure with all the data obtained running GBF (Biass et al. 2016) 
%            in different conditions
% - dem_X, dem_Y, dem_Z: dem structure of the case under analysis
 
    close all;
    dim_vent = size(allData.bocca);
    mydata.N_vents = dim_vent(2);
    mydata.n_clasti_tot = 2e6;                                              % Number of clasts used in the simulations with GBF
    mydata.tabella_prototype = allData.bocca(1).nowind.soglia.table_prob;
    dim = size(mydata.tabella_prototype);
    mydata.id_matrix_i = dim(1);
    mydata.id_matrix_j = dim(2);
    
    %Weights according to Strategy 1 (w'_j):
%   mydata.weight_st1 = [0, 0.21, 0.25, 0.21, 0.33, 0, 0, 0, 0, 0, 0];
    mydata.weight_st1 = [1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0];

    %Weights according to Strategy 2 - (whenever the user needs to change the w'_j values):
    mydata.weight_st2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; 

    mydata.N_min = 1;
    mydata.X_vent = allData.X_vent;
    mydata.Y_vent = allData.Y_vent;

    
    % Maps without wind
    
    for id_matrix_i = 1:mydata.id_matrix_i
        for id_matrix_j = 1:mydata.id_matrix_j
              
            somma_1_st1_nowind = 0;
            somma_2_st1_nowind = 0;
            somma_3_st1_nowind = 0;
            
            somma_1_st2_nowind = 0;
            somma_2_st2_nowind = 0;
            somma_3_st2_nowind = 0;
            
            
            somma_Nclasti_st1_nowind = 0;
            somma_Nclasti_st2_nowind = 0;
            
        
            somma_1_st1_wind = 0;
            somma_2_st1_wind = 0;
            somma_3_st1_wind = 0;
            
            somma_1_st2_wind = 0;
            somma_2_st2_wind = 0;
            somma_3_st2_wind = 0;
            
            
            somma_Nclasti_st1_wind = 0;
            somma_Nclasti_st2_wind = 0;
            
            
           for id_vent = 1:mydata.N_vents
                
               
                %%% Weighted Average on N clasts 
                somma_Nclasti_st1_nowind = mydata.weight_st1(id_vent) * ...
                                           allData.bocca(id_vent).nowind.soglia(1).table_N(id_matrix_i, id_matrix_j) + ...
                                           somma_Nclasti_st1_nowind;
                                       
                somma_Nclasti_st2_nowind = mydata.weight_st2(id_vent) * ...
                                           allData.bocca(id_vent).nowind.soglia(1).table_N(id_matrix_i, id_matrix_j) + ...
                                           somma_Nclasti_st2_nowind;                       
               
                                       
                somma_Nclasti_st1_wind =   mydata.weight_st1(id_vent) * ...
                                           allData.bocca(id_vent).wind.soglia(1).table_N(id_matrix_i, id_matrix_j) + ...
                                           somma_Nclasti_st1_wind;
%                                        
                somma_Nclasti_st2_wind =   mydata.weight_st2(id_vent) * ...
                                           allData.bocca(id_vent).wind.soglia(1).table_N(id_matrix_i, id_matrix_j) + ...
                                           somma_Nclasti_st2_wind; 
              
                                       
                
                %%% NO wind
               
                % Threshold 1 (360 J), Strategy 1 and 2
                
                N_cella = allData.bocca(id_vent).nowind.soglia(1).table_N(id_matrix_i, id_matrix_j);
                
                if N_cella<mydata.N_min
                    somma_1_st1_nowind = 0 + somma_1_st1_nowind;
                    somma_1_st2_nowind = 0 + somma_1_st2_nowind;
                    
                else
                    
                    prob = allData.bocca(id_vent).nowind.soglia(1).table_prob(id_matrix_i, id_matrix_j);
                    
                    if isnan(prob)>0
                        prob = 0;
                    end
                    somma_1_st1_nowind = mydata.weight_st1(id_vent) * prob + somma_1_st1_nowind;
                    somma_1_st2_nowind = mydata.weight_st2(id_vent) * prob + somma_1_st2_nowind;
                end
                
               
                % Threshold 2 (650 J), Strategy 1 and 2
                
                N_cella = allData.bocca(id_vent).nowind.soglia(2).table_N(id_matrix_i, id_matrix_j);
                
                if N_cella<mydata.N_min
                    somma_2_st1_nowind = 0 + somma_2_st1_nowind;
                    somma_2_st2_nowind = 0 + somma_2_st2_nowind;
                else
                    
                    prob = allData.bocca(id_vent).nowind.soglia(2).table_prob(id_matrix_i, id_matrix_j);
                    
                    if isnan(prob)>0
                        prob = 0;
                    end
                    somma_2_st1_nowind = mydata.weight_st1(id_vent) * prob + somma_2_st1_nowind;
                    somma_2_st2_nowind = mydata.weight_st2(id_vent) * prob + somma_2_st2_nowind;
                end
                
                
                % Threshold 3 (2750 J), Strategy 1 and 2
                
                N_cella = allData.bocca(id_vent).nowind.soglia(3).table_N(id_matrix_i, id_matrix_j);
                
                if N_cella<mydata.N_min
                    somma_3_st1_nowind = 0 + somma_3_st1_nowind;
                    somma_3_st2_nowind = 0 + somma_3_st2_nowind;
                else
                    
                    prob = allData.bocca(id_vent).nowind.soglia(3).table_prob(id_matrix_i, id_matrix_j);
                    
                    if isnan(prob)>0
                        prob = 0;
                    end
                    somma_3_st1_nowind = mydata.weight_st1(id_vent) * prob + somma_3_st1_nowind;
                    somma_3_st2_nowind = mydata.weight_st2(id_vent) * prob + somma_3_st2_nowind;
                end
                                       
                                       
                                       
                %%% YES wind
               
                % Threshold 1 (360 J), Strategy 1 and 2
                
                N_cella = allData.bocca(id_vent).wind.soglia(1).table_N(id_matrix_i, id_matrix_j);
                
                if N_cella<mydata.N_min
                    somma_1_st1_wind = 0 + somma_1_st1_wind;
                    somma_1_st2_wind = 0 + somma_1_st2_wind;
                else
                    
                    prob = allData.bocca(id_vent).wind.soglia(1).table_prob(id_matrix_i, id_matrix_j);
                    
                    if isnan(prob)>0
                        prob = 0;
                    end
                    somma_1_st1_wind = mydata.weight_st1(id_vent) * prob + somma_1_st1_wind;
                    somma_1_st2_wind = mydata.weight_st2(id_vent) * prob + somma_1_st2_wind;
                end
                
                % Threshold 2 (650 J), Strategy 1 and 2
                
                N_cella = allData.bocca(id_vent).wind.soglia(2).table_N(id_matrix_i, id_matrix_j);
                
                if N_cella<mydata.N_min
                    somma_2_st1_wind = 0 + somma_2_st1_wind;
                    somma_2_st2_wind = 0 + somma_2_st2_wind;
                else
                    
                    prob = allData.bocca(id_vent).nowind.soglia(2).table_prob(id_matrix_i, id_matrix_j);
                    
                    if isnan(prob)>0
                        prob = 0;
                    end
                    somma_2_st1_wind = mydata.weight_st1(id_vent) * prob + somma_2_st1_wind;
                    somma_2_st2_wind = mydata.weight_st2(id_vent) * prob + somma_2_st2_wind;
                end
                
                
                % Threshold 3 (2750 J), Strategy 1 and 2
                
                N_cella = allData.bocca(id_vent).wind.soglia(3).table_N(id_matrix_i, id_matrix_j);
                
                if N_cella<mydata.N_min
                    somma_3_st1_wind = 0 + somma_3_st1_wind;
                    somma_3_st2_wind = 0 + somma_3_st2_wind;
                else
                    
                    prob = allData.bocca(id_vent).wind.soglia(3).table_prob(id_matrix_i, id_matrix_j);
                    
                    if isnan(prob)>0
                        prob = 0;
                    end
                    somma_3_st1_wind = mydata.weight_st1(id_vent) * prob + somma_3_st1_wind;
                    somma_3_st2_wind = mydata.weight_st2(id_vent) * prob + somma_3_st2_wind;
                end
                
              %%%              
                
                
           end 
           
           mydata.matrice_finale.nowind.stategia(1).soglia(1).table_prob_final(id_matrix_i, id_matrix_j) = somma_1_st1_nowind;
           mydata.matrice_finale.nowind.stategia(1).soglia(2).table_prob_final(id_matrix_i, id_matrix_j) = somma_2_st1_nowind;
           mydata.matrice_finale.nowind.stategia(1).soglia(3).table_prob_final(id_matrix_i, id_matrix_j) = somma_3_st1_nowind;
           mydata.matrice_finale.nowind.stategia(1).N_clasti_media_pesata(id_matrix_i, id_matrix_j) = somma_Nclasti_st1_nowind;
           
           mydata.matrice_finale.nowind.stategia(2).soglia(1).table_prob_final(id_matrix_i, id_matrix_j) = somma_1_st2_nowind;
           mydata.matrice_finale.nowind.stategia(2).soglia(2).table_prob_final(id_matrix_i, id_matrix_j) = somma_2_st2_nowind;
           mydata.matrice_finale.nowind.stategia(2).soglia(3).table_prob_final(id_matrix_i, id_matrix_j) = somma_3_st2_nowind;
           mydata.matrice_finale.nowind.stategia(2).N_clasti_media_pesata(id_matrix_i, id_matrix_j) = somma_Nclasti_st2_nowind;
               
           mydata.matrice_finale.wind.stategia(1).soglia(1).table_prob_final(id_matrix_i, id_matrix_j) = somma_1_st1_wind;
           mydata.matrice_finale.wind.stategia(1).soglia(2).table_prob_final(id_matrix_i, id_matrix_j) = somma_2_st1_wind;
           mydata.matrice_finale.wind.stategia(1).soglia(3).table_prob_final(id_matrix_i, id_matrix_j) = somma_3_st1_wind;
           mydata.matrice_finale.wind.stategia(1).N_clasti_media_pesata(id_matrix_i, id_matrix_j) = somma_Nclasti_st1_wind;
           
           mydata.matrice_finale.wind.stategia(2).soglia(1).table_prob_final(id_matrix_i, id_matrix_j) = somma_1_st2_wind;
           mydata.matrice_finale.wind.stategia(2).soglia(2).table_prob_final(id_matrix_i, id_matrix_j) = somma_2_st2_wind;
           mydata.matrice_finale.wind.stategia(2).soglia(3).table_prob_final(id_matrix_i, id_matrix_j) = somma_3_st2_wind;
           mydata.matrice_finale.wind.stategia(2).N_clasti_media_pesata(id_matrix_i, id_matrix_j) = somma_Nclasti_st2_wind;
           
        
        end
    end
   
    
    mydata.table_X_coord = allData.bocca(1).nowind.soglia(1).table_X;
    mydata.table_Y_coord = allData.bocca(1).nowind.soglia(1).table_Y;
    mydata.dem_X = dem_X;
    mydata.dem_Y = dem_Y;
    mydata.dem_Z = dem_Z;
    
   
    % Plotting Section. 
    %Figures from 1 to 12 represent the probability P' to exceed the three
    %energy thresholds:
    
    % no wind
%     
%    Figure 1
%     tabella_prob = mydata.matrice_finale.nowind.stategia(1).soglia(1).table_prob_final;
%     tabella_N_clasts = mydata.matrice_finale.nowind.stategia(1).N_clasti_media_pesata;
%     drawFinalMaps_P_apex(mydata, tabella_prob, tabella_N_clasts, 1, 'Strategy 1 - Threshold 1 (no wind)');


%     Figure 2
%     tabella_prob = mydata.matrice_finale.nowind.stategia(1).soglia(2).table_prob_final;
%     tabella_N_clasts = mydata.matrice_finale.nowind.stategia(1).N_clasti_media_pesata;
%     drawFinalMaps_P_apex(mydata, tabella_prob, tabella_N_clasts, 2, 'Strategy 1 - Threshold 2 (no wind)');
  

%   Figure 3
    tabella_prob = mydata.matrice_finale.nowind.stategia(1).soglia(3).table_prob_final;
    tabella_N_clasts = mydata.matrice_finale.nowind.stategia(1).N_clasti_media_pesata;
    drawFinalMaps_P_apex(mydata, tabella_prob, tabella_N_clasts, 3, 'Strategy 1 - Threshold 3 (no wind)');
    
    
%   Figure 4

%     tabella_prob = mydata.matrice_finale.nowind.stategia(2).soglia(1).table_prob_final;
%     tabella_N_clasts = mydata.matrice_finale.nowind.stategia(2).N_clasti_media_pesata;
%     drawFinalMaps_P_apex(mydata, tabella_prob, tabella_N_clasts, 4, 'Strategy 2 - Threshold 1 (no wind)');


%     Figure 5
%     tabella_prob = mydata.matrice_finale.nowind.stategia(2).soglia(2).table_prob_final;
%     tabella_N_clasts = mydata.matrice_finale.nowind.stategia(2).N_clasti_media_pesata;
%     drawFinalMaps_P_apex(mydata, tabella_prob, tabella_N_clasts, 5, 'Strategy 2 - Threshold 2 (no wind)');
   
%     Figure 6
%     tabella_prob = mydata.matrice_finale.nowind.stategia(2).soglia(3).table_prob_final;
%     tabella_N_clasts = mydata.matrice_finale.nowind.stategia(2).N_clasti_media_pesata;
%     drawFinalMaps_P_apex(mydata, tabella_prob, tabella_N_clasts, 6, 'Strategy 2 - Threshold 3 (no wind)');

%    
% wind    
%     Figure 7
%     tabella_prob = mydata.matrice_finale.wind.stategia(1).soglia(1).table_prob_final;
%     tabella_N_clasts = mydata.matrice_finale.wind.stategia(1).N_clasti_media_pesata;
%     drawFinalMaps_P_apex(mydata, tabella_prob, tabella_N_clasts, 7, 'Strategy 1 - Threshold 1 (wind)');
    
%      Figure 8
%     tabella_prob = mydata.matrice_finale.wind.stategia(1).soglia(2).table_prob_final;
%     tabella_N_clasts = mydata.matrice_finale.wind.stategia(1).N_clasti_media_pesata;
%     drawFinalMaps_P_apex(mydata, tabella_prob, tabella_N_clasts, 8, 'Strategy 1 - Threshold 2 (wind)');
    
%     Figure 9
%     tabella_prob = mydata.matrice_finale.wind.stategia(1).soglia(3).table_prob_final;
%     tabella_N_clasts = mydata.matrice_finale.wind.stategia(1).N_clasti_media_pesata;
%     drawFinalMaps_P_apex(mydata, tabella_prob, tabella_N_clasts, 9, 'Strategy 1 - Threshold 3 (wind)');
% 
%    Figure 10
%    tabella_prob = mydata.matrice_finale.wind.stategia(2).soglia(1).table_prob_final;
%    tabella_N_clasts = mydata.matrice_finale.wind.stategia(2).N_clasti_media_pesata;
%    drawFinalMaps_P_apex(mydata, tabella_prob, tabella_N_clasts, 10, 'Strategy 2 - Threshold 1 (wind)');
%     
%    Figure 11
%    tabella_prob = mydata.matrice_finale.wind.stategia(2).soglia(2).table_prob_final;
%    tabella_N_clasts = mydata.matrice_finale.wind.stategia(2).N_clasti_media_pesata;
%    drawFinalMaps_P_apex(mydata, tabella_prob, tabella_N_clasts, 11, 'Strategy 2 - Threshold 2 (wind)');
  
%     Figure 12
%    tabella_prob = mydata.matrice_finale.wind.stategia(2).soglia(3).table_prob_final;
%    tabella_N_clasts = mydata.matrice_finale.wind.stategia(2).N_clasti_media_pesata;
%    drawFinalMaps_P_apex(mydata, tabella_prob, tabella_N_clasts, 12, 'Strategy 2 - Threshold 3 (wind)');


  %Figures from 13 to 15 represent the probability P' to exceed the three
   %energy thresholds:   
% Figure 13
%     tabella_prob = mydata.matrice_finale.nowind.stategia(1).soglia(1).table_prob_final;
%     tabella_N_clasts = mydata.matrice_finale.nowind.stategia(1).N_clasti_media_pesata;
%     drawFinalMaps_P(mydata, tabella_prob, tabella_N_clasts, 1, ' Pfin - Threshold 1 (no wind)');

%  Figure 14
%     tabella_prob = mydata.matrice_finale.nowind.stategia(1).soglia(2).table_prob_final;
%     tabella_N_clasts = mydata.matrice_finale.nowind.stategia(1).N_clasti_media_pesata;
%     drawFinalMaps_P(mydata, tabella_prob, tabella_N_clasts, 2, 'Pfin - Threshold 2 (no wind)');
      
%     Figure 15
%     tabella_prob = mydata.matrice_finale.nowind.stategia(1).soglia(3).table_prob_final;
%     tabella_N_clasts = mydata.matrice_finale.nowind.stategia(1).N_clasti_media_pesata;
%     drawFinalMaps_P(mydata, tabella_prob, tabella_N_clasts, 3, 'Pfin - Threshold 3 (no wind)');
    

end

function drawFinalMaps_P_apex(mydata, output_prob, counts_total_single_cell, id_figure, stringa) %figure che rappresentano P'

    cmap=zeros(100,3);
    aa=white(1000); bb=parula(100); %to set a white background using a color map "parula"
    cmap(1,:)=aa(1,:); 
    cmap(2:end,:)=bb(2:end,:); 
    
   figure(id_figure)
   hold on
   ax = subplot(1,1,1);
   h = pcolor(mydata.table_X_coord, mydata.table_Y_coord, output_prob);
  
%    shading interp;
   set(h, 'EdgeColor', 'none');
   colorLim = ax.CLim;
   [C,h] = contour(mydata.table_X_coord, mydata.table_Y_coord, log10(counts_total_single_cell),[1 2 3 4 5],'-k');
   clabel(C,h)
   [C,h] = contour(mydata.table_X_coord, mydata.table_Y_coord, log10(counts_total_single_cell),[1 1],'-r', 'LineWidth', 5);
   clabel(C,h)
   ax.CLim = colorLim;
   colorbar
   caxis([0 1]);

   [C2, h2] = contour(mydata.dem_X,mydata.dem_Y,mydata.dem_Z,[1, 1], 'LineWidth',2, 'LineColor', 'k'); 
   axis equal
%    caxis([0 max(max(output_prob))]);
   caxis([0 1]);
   title(stringa);
   colormap(cmap)
   set(gca,'FontSize',10)
   
end

%Figures representing the overall final probability (P) calculated as P' * f(Aij) 
function drawFinalMaps_P(mydata, output_prob, counts_total_single_cell, id_figure, stringa) 
    x_claude = 637557; 
    y_claude = 1770064;
    z_claude = 50;
    
    x_basterre = 639996.5;
    y_basterre = 1766429.5;
    z_basterre = 50;

   cmap=zeros(100,3);
    aa=white(1000); bb=parula(100); 
    cmap(1,:)=aa(1,:); 
    cmap(2:end,:)=bb(2:end,:);
    
   prob_b=counts_total_single_cell./mydata.n_clasti_tot; % (fAij)
   probA_B= prob_b.*output_prob; %P' * f(Aij) 
    
   figure(id_figure)
   hold on
   ax = subplot(1,1,1);
   h = pcolor(mydata.table_X_coord, mydata.table_Y_coord, probA_B);

    set(h, 'EdgeColor', 'none');
   colorLim = ax.CLim;
   [C,h] = contour(mydata.table_X_coord, mydata.table_Y_coord, log10(counts_total_single_cell),[1 2 3 4 5],'-k');
   clabel(C,h)
   [C,h] = contour(mydata.table_X_coord, mydata.table_Y_coord, log10(counts_total_single_cell),[1 1],'-r', 'LineWidth', 5);
   clabel(C,h)
   ax.CLim = colorLim;
   colorbar;
   

   plot3(mydata.X_vent, mydata.Y_vent, 1000, 'pr', 'MarkerSize', 30);
   plot3(x_claude, y_claude, z_claude, '.k', 'MarkerSize', 30);
   plot3(x_basterre, y_basterre, z_basterre, '.k', 'MarkerSize', 30);
   [C2, h2] = contour(mydata.dem_X,mydata.dem_Y,mydata.dem_Z,[1, 1], 'LineWidth',2, 'LineColor', 'k'); 
   axis equal
   caxis([0 max(max(probA_B))]);
   title(stringa);
   xlabel('X coordinate');
   ylabel('Y coordinate');
   set(gca,'FontSize',20)
   colormap(cmap)
   
end

