function [ sig ] = signatures(img, m, n, v, r_start, r_increment, r_end, subImages)
    
  % ---------------------
  % This function calculates the SampEn signatures for a given image (Section 3.2.1 in [1])
  %  % [1] Rozendo, G. B., Nascimento, M. Z., Roberto G. F., Faria, P. R., Silva, A. B., Tosta, T. A. A., Neves, L. A. (2022). Classification of Non-Hodgkin Lymphomas Based on Sample Entropy Signatures. Expert Systems with Applications.
  % ---------------------
  
  n_sigs = size(r_start:r_increment:r_end, 2);
  sig = zeros(1, n_sigs);
  
  i = 1;
  for r = r_start : r_increment : r_end
    fprintf("Calculating SampEn for m = %d and r = %f ...\n", m, r);
    sig(i) = avr_SampEn(img, m, r, v, n, subImages); % Equation 9 in [1]
    i = i + 1;
  end

end