function [subImages] = alternate_get_sub_images(img, sub_im_size)
  
  N = size(img, 1);
  M = size(img, 2); 
  sub_M = floor(M/sub_im_size);
  sub_N = floor(N/sub_im_size);
  
  % Store all subimages points
  subImages = struct();
  subImagesCounter = 1;

  if M-(sub_M*sub_im_size)>=floor(M/4) && N-(sub_N*sub_im_size)>=floor(N/4)
    im_x_from=floor((N-(sub_N*sub_im_size))/2);
    im_x_to=floor((N-(sub_N*sub_im_size))/2)+sub_im_size-1;
    im_y_from=floor((M-(sub_M*sub_im_size))/2);
    im_y_to=floor((M-(sub_M*sub_im_size))/2)+sub_im_size-1; 
  %Necessary adjustment in width only for scraps in a proportion of 25%
  elseif M-(sub_M*sub_im_size)>=floor(M/4)
    im_x_from=1;
    im_x_to=sub_im_size;
    im_y_from=floor((M-(sub_M*sub_im_size))/2);
    im_y_to=floor((M-(sub_M*sub_im_size))/2)+sub_im_size-1; 
  %Necessary adjustment in height only for scraps in a proportion of 25%
  elseif N-(sub_N*sub_im_size)>=floor(N/4)
    im_x_from=floor((N-(sub_N*sub_im_size))/2);
    im_x_to=floor((N-(sub_N*sub_im_size))/2)+sub_im_size-1;
    im_y_from=1;
    im_y_to=sub_im_size;
   %No necessary adjustment
   else
    im_x_from=1;
    im_x_to=sub_im_size;
    im_y_from=1;
    im_y_to=sub_im_size;
  end
  
  sub_amount=(sub_M*sub_N); %amounts of sub-images inside image
        
  for im1=1:sub_M
    for im2=1:sub_N
      qtd_black=0;

      for z=im_x_from:im_x_to
        for l=im_y_from:im_y_to
          if img(z,l) == 0
            qtd_black = qtd_black + 1;
          end
        end
      end

      %Consider background until 90%
      if qtd_black/(sub_im_size*sub_im_size)>=0.90  
        sub_amount=sub_amount-1;
      else
        subImages(subImagesCounter).xStart = im_x_from;
        subImages(subImagesCounter).xEnd = im_x_to;
        subImages(subImagesCounter).yStart = im_y_from;
        subImages(subImagesCounter).yEnd = im_y_to;
        subImagesCounter = subImagesCounter + 1;
      end
      %Sub-image sliding in height
        im_x_from=im_x_from+sub_im_size;
        im_x_to=im_x_to+sub_im_size;
    end
      %Sub-image sliding in width
      im_y_from=im_y_from+sub_im_size;
      im_y_to=im_y_to+sub_im_size;
            
      %Re-centering the height case necessary 
      if N-(sub_N*sub_im_size)>=floor(N/4)
        im_x_from=floor((N-(sub_N*sub_im_size))/2);
        im_x_to=floor((N-(sub_N*sub_im_size))/2)+sub_im_size-1;
      else
        im_x_from=1;
        im_x_to=sub_im_size;
      end
  end
end

