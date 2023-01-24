% ---------------------
% This script calculates the SampEn signatures and metrics for a given image
%
% [1] Rozendo, G. B., Nascimento, M. Z., Roberto G. F., Faria, P. R., Silva, A. B., Tosta, T. A. A., Neves, L. A. (2022). Classification of Non-Hodgkin Lymphomas Based on Sample Entropy Signatures. Expert Systems with Applications.
% ---------------------

MAX_M = 4;
R_START = 0.06;
R_INCREMENT = 0.02;
R_END = 0.4;
N = 64;
V = 180;

% Input image
img = imread('../data/Covid19/Covid (104).png');
subImages = alternate_get_sub_images(img, N);

parfor m = 1 : MAX_M
  sig = signatures(img, m, N, V, R_START, R_INCREMENT, R_END, subImages);
  met = metrics(sig);
    
  save_fig(sig, m, R_START, R_INCREMENT, R_END);
    
  fprintf("Completed for m =  %d\n", m);
  disp(met);
  fprintf("\n");
end


