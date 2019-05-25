
clc
clear
clearvars
clearvars -global
close all

rgbImage = imread('images/15.jpg');

rgbImage = imresize(rgbImage,[480 640]);
I = rgb2gray(rgbImage);


boxHeight = 45;
boxWidth = 130;

[height, width] = size(I);

global foundRegions;
global foundCharLength;

previousRegions = [];

foundCharLength = 0;

 for i = 0 : 10 : height
     
    for j = 0 : 80 : width
    
        if j + boxWidth <= width        
            cropped = imcrop(I,[j i boxWidth boxHeight]);
            
%             picture=imresize(cropped,[300 500]);
%             figure, imshow(picture);
            
            previousRegions = foundRegions;
            
            finder(rgbImage, cropped); 
            
            if ~isequaln(previousRegions,foundRegions)               
                for n = 1 : size(foundRegions, 1)                        
                    foundRegions(n).BoundingBox(1) = j + foundRegions(n).BoundingBox(1) / 3.84;
                    foundRegions(n).BoundingBox(2) = i + foundRegions(n).BoundingBox(2) / 6.66;
                    foundRegions(n).BoundingBox(3) =  foundRegions(n).BoundingBox(3) / 3.84;
                    foundRegions(n).BoundingBox(4) =  foundRegions(n).BoundingBox(4) / 6.66;
                end 
            end
            
        else
            break
        end
    
    end
     
 end

close all
 
figure, imshow(rgbImage)


 
for n = 1 : size(foundRegions, 1)  
  
  rectangle('Position', foundRegions(n).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 2)  
  
end

