% ---------------------
% This script calculates the SampEn signatures and metrics for a given image
%
% [1] Rozendo, G. B., Nascimento, M. Z., Roberto G. F., Faria, P. R., Silva, A. B., Tosta, T. A. A., Neves, L. A. (2022). Classification of Non-Hodgkin Lymphomas Based on Sample Entropy Signatures. Expert Systems with Applications.
% ---------------------

% Values for the calculations
MAX_M = 4;
R_START = 0.06;
R_INCREMENT = 0.02;
R_END = 0.4;
N = 64;
V = 180;

CLASS_NAME = "Covid";
CLASS_PATH = "../data/Covid19/";
CLASS_DIR = dir(CLASS_PATH);
RESULTS_PATH = "../results/";

for file_index = 1 : size(CLASS_DIR)
  if endsWith(CLASS_DIR(file_index).name, ".png")
    img_name = CLASS_DIR(file_index).name;
    % Input image
    img = imread(strcat(CLASS_PATH, img_name));
    sub_images = alternate_get_sub_images(img, N);
    
    % Formating the file name to create a folder to store all results
    results_name = replace(img_name, " ", "");
    results_name = replace(results_name, ").png", "");
    results_name = replace(results_name, "(", "");
    img_results_path = strcat(RESULTS_PATH, results_name);
    
    % Creating a folder for the results
    mkdir(img_results_path)
    
    sampEn_sig_matrix = zeros(MAX_M, size(R_START:R_INCREMENT:R_END, 2));
    sampEn_met_matrix = zeros(MAX_M, 4);
    
    for m = 1 : MAX_M
      sig = signatures(img, img_name, m, N, V, R_START, R_INCREMENT, R_END, sub_images);
      met = metrics(sig);
      
      plot(R_START : R_INCREMENT : R_END, sig, 'b-s')
      xlabel('r', 'FontSize', 12, 'FontWeight','bold')
      ylabel('SampEn', 'FontSize', 12, 'FontWeight','bold')
      title(strcat("M = ", int2str(m)))
      if size(sub_images, 1) < V
        file_name = strcat(img_results_path, "/", "sig_m", int2str(m), "_v", int2str(size(sub_images, 1)), "_.png");
      else
        file_name = strcat(img_results_path, "/", "sig_m", int2str(m), ".png");
      end     
      saveas(gcf, file_name);
        
      fprintf("Completed for m =  %d\n", m);
      disp(met);
      sampEn_sig_matrix(m, :) = sig;
      sampEn_met_matrix(m, :) = met;
    end
    
    if size(sub_images, 1) < V
      writematrix(sampEn_sig_matrix, strcat(img_results_path, "/", "Covid_attributes_matrix", "_v", int2str(size(sub_images, 1)), "_.csv"));
      writematrix(sampEn_met_matrix, strcat(img_results_path, "/", "Covid_metrics_matrix", "_v", int2str(size(sub_images, 1)), "_.csv"));
    else
      writematrix(sampEn_sig_matrix, strcat(img_results_path, "/", "Covid_attributes_matrix.csv"));
      writematrix(sampEn_met_matrix, strcat(img_results_path, "/", "Covid_metrics_matrix.csv"));
    end
   
  end
end




