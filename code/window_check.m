function [valid] = window_check(subImage)
  valid = false;
  blackPixels = 0;

  imgHeight = size(subImage, 1);
  imgWidth = size(subImage, 2);

  tolerance = 0.1;

  for y = 1 : imgHeight
    for x = 1 : imgWidth
      if subImage(y, x) == 0
        blackPixels = blackPixels + 1;
      end
    end
  end

  if blackPixels <= floor((imgHeight * imgWidth) * tolerance)
    valid = true;
  end
  
end

