function [subImages] = get_sub_images(img, v ,n)
  
  %img = int16(img);
  imgHeight = size(img, 1);
  imgWidth = size(img, 2); 

  subImages = zeros(v, 4); % Stores the starting point, and the ending point

  xStart = randi(imgWidth-n+1);
  xEnd = xStart + (n-1);
  yStart = randi(imgHeight-n+1);
  yEnd = yStart + (n-1);

  map = zeros(imgHeight, imgWidth);

  for i = 1 : v
    while map(yStart, xStart) == 1 || window_check(img(yStart:yEnd, xStart:xEnd)) == false
      xStart = randi(imgWidth-n+1);
      xEnd = xStart + (n-1);
      yStart = randi(imgHeight-n+1);
      yEnd = yStart + (n-1);
    end
    map(yStart, xStart) = 1;
    subImages(i, 1) = yStart;
    subImages(i, 2) = yEnd;
    subImages(i, 3) = xStart;
    subImages(i, 4) = xEnd;
    imwrite(img(yStart:yEnd, xStart:xEnd), strcat("C:\Users\Pedro\Desktop\windows\", int2str(i), ".png"));
  end
end

