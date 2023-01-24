function [ se ] = avr_SampEn(img, m, r, v, n, sub_images)
  
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

  if size(sub_images, 1) <= v
    se = zeros(1, size(sub_images, 1));
  
    for i = 1 : size(sub_images, 1)-1
      img_temp = img(sub_images(i, 1):sub_images(i, 2), sub_images(i, 3):sub_images(i, 4)); % sub-image
      
      se(i) = SampEn(img_temp, m, r);
    end

  else
    se = zeros(v);
    map = zeros(size(sub_images, 1));
    
    random_sub_image = randi(size(sub_images, 1));

    for i = 1 : v
      while map(random_sub_image) == 1
        random_sub_image = randi(size(sub_images, 1));
      end

      img_temp = img(sub_images(random_sub_image,1):sub_images(random_sub_image,2), sub_images(random_sub_image,3):sub_images(random_sub_image,4)); % sub-image
      
      se(i) = SampEn(img_temp, m, r);
      map(random_sub_image) = 1;
    end

  end

  se = mean(se);
end