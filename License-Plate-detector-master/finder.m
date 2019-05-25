function finder(rgbImage, grayImage)

load imgfildata;
global foundCharLength;
global foundRegions;

% [file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
% s=[path,file];
% picture=imread(s);
[~,cc]=size(rgbImage);

picture = grayImage;

picture=imresize(picture,[300 500]);
% 
picture = imadjust(picture);

 se=strel('rectangle',[5,5]);
 a=imerode(picture,se);
%  figure,imshow(a);
 picture=imdilate(a,se);
% threshold = graythresh(picture);
picture =~imbinarize(picture);
picture = bwareaopen(picture,30);
% imshow(picture)
if cc>2000
    picture1=bwareaopen(picture,3500);
else
picture1=bwareaopen(picture,3000);
end
%figure,imshow(picture1)
picture2=picture-picture1;
%figure,imshow(picture2)
picture2=bwareaopen(picture2,200);
% figure,imshow(picture2);

[L,Ne]=bwlabel(picture2);
propied=regionprops(L,'BoundingBox');
hold on
% pause(1)

if size(propied, 1) < 3 || size(propied, 1) > 8
    return
end

% for n=1:size(propied,1)
%   rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
% end
% hold off

% figure
final_output=[];
t=[];
for n=1:Ne
  [r,c] = find(L==n);
  n1=picture(min(r):max(r),min(c):max(c));
  n1=imresize(n1,[42,24]);
%   imshow(n1)
%   pause(0.2)
  x=[ ];

totalLetters=size(imgfile,2);

 for k=1:totalLetters
    
    y=corr2(imgfile{1,k},n1);
    x=[x y];
    
 end
 t=[t max(x)];
 if max(x)>.45
 z=find(x==max(x));
 out=cell2mat(imgfile(2,z));

final_output=[final_output out];
% disp(length(final_output))
% disp(foundChars)

if length(final_output) > foundCharLength
    
    foundCharLength = length(final_output);
    foundRegions = propied;
    
    X = sprintf('foundChars: %s, foundRegions: %d', num2str(foundCharLength), size(foundRegions,1));
    disp(X)
    
end


end
end

% file = fopen('number_Plate.txt', 'wt');
%     fprintf(file,'%s\n',final_output);
%     fclose(file);                     
%     winopen('number_Plate.txt')
    
end % function end