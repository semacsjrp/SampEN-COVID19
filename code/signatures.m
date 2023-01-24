function [ sig ] = signatures(img, img_name, m, n, v, r_start, r_increment, r_end, sub_images)
    
  % ---------------------
  % This function calculates the SampEn signatures for a given image (Section 3.2.1 in [1])
  %  % [1] Rozendo, G. B., Nascimento, M. Z., Roberto G. F., Faria, P. R., Silva, A. B., Tosta, T. A. A., Neves, L. A. (2022). Classification of Non-Hodgkin Lymphomas Based on Sample Entropy Signatures. Expert Systems with Applications.
  % ---------------------
  
  r_values = r_start : r_increment : r_end;
  n_sigs = size(r_values, 2);
  sig = zeros(1, n_sigs);
  
  parfor r = 1 : n_sigs
    fprintf("Calculating SampEn for (%s) m = %d and r = %f ...\n", img_name, m, r_values(r));
    sig(r) = avr_SampEn(img, m, r_values(r), v, n, sub_images); % Equation 9 in [1]
  end

end