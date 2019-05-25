clc
close all;
clear;
load imgfildata;

[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
picture=imread(s);
[~,cc]=size(picture);
picture=imresize(picture,[300 500]);

if size(picture,3)==3
  picture=rgb2gray(picture);
end
 se=strel('rectangle',[5,5]);
 a=imerode(picture,se);
 figure,imshow(a);
 b=imdilate(a,se);
threshold = graythresh(picture);
picture =~im2bw(picture,threshold);
picture = bwareaopen(picture,30);
imshow(picture)
if cc>2000
    picture1=bwareaopen(picture,3500);
else
picture1=bwareaopen(picture,3000);
end
figure,imshow(picture1)
picture2=picture-picture1;
figure,imshow(picture2)
picture2=bwareaopen(picture2,200);
figure,imshow(picture2)

[L,Ne]=bwlabel(picture2);
propied=regionprops(L,'BoundingBox');
hold on
pause(1)
for n=1:size(propied,1)
  rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off

figure
final_output=[];
t=[];
for n=1:Ne
  [r,c] = find(L==n);
  n1=picture(min(r):max(r),min(c):max(c));
  n1=imresize(n1,[42,24]);
  imshow(n1)
  pause(0.2)
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
end
end

file = fopen('number_Plate.txt', 'wt');
    fprintf(file,'%s\n',final_output);
    fclose(file);                     
    winopen('number_Plate.txt')