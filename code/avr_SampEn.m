function [ se ] = avr_SampEn(img, m, r, v, n, subImages)
  
  % ---------------------
  % This function calculates the average SampEn of the sub-images (Equation 9 in [1])
  %
  % Input:
  % img - image
  % m, r - SampEn parameters
  % v - number of sub-images
  % n - subimage size
  %
  % Output: 
  % se - a SampEn value
  %
  % [1] Rozendo, G. B., Nascimento, M. Z., Roberto G. F., Faria, P. R., Silva, A. B., Tosta, T. A. A., Neves, L. A. (2022). Classification of Non-Hodgkin Lymphomas Based on Sample Entropy Signatures. Expert Systems with Applications.
  % ---------------------
  
  %img = im2int16(img);

  if size(subImages, 2) <= v
    fprintf("Doing for a different V value (V = %d)\n", size(subImages, 2));
    se = zeros(1, size(subImages, 2));
  
    for i = 1 : size(subImages, 2)
      img_temp = img(subImages(i).xStart:subImages(i).xEnd, subImages(i).yStart:subImages(i).yEnd); % sub-image
      
      se(1, i) = SampEn(img_temp, m, r);
    end

  else
    fprintf("Doing for expected V value.\n");
    se = zeros(1, v);
    map = zeros(1, size(subImages, 2));
    
    random_sub_image = randi(size(subImages, 2));

    for i = 1 : v
      while map(random_sub_image) == 1
        random_sub_image = randi(size(subImages, 2));
      end

      img_temp = img(subImages(random_sub_image).xStart:subImages(random_sub_image).xEnd, subImages(random_sub_image).yStart:subImages(random_sub_image).yEnd); % sub-image
      
      se(1, i) = SampEn(img_temp, m, r);
      map(random_sub_image) = 1;
    end

  end

  se = mean(se);
  fprintf("Mean for (M = %d) : %f\n", m, se);
end