rgbImage = imread('test.jpg');
figure,imshow(rgbImage)

% rgbImage = imresize(rgbImage,[480 640]);
I = rgb2gray(rgbImage);
figure,imshow(I)

picture = imadjust(I);
figure,imshow(picture)

 se=strel('rectangle',[5,5]);
 a=imerode(picture,se);
 figure,imshow(a);
 
 picture=imdilate(a,se);
 figure,imshow(picture)

picture =~imbinarize(picture);
figure,imshow(picture)

picture = bwareaopen(picture,30);
figure,imshow(picture)

picture1=bwareaopen(picture,3000);
figure,imshow(picture1)

picture2=picture-picture1;
figure,imshow(picture2)

picture2=bwareaopen(picture2,200);
figure,imshow(picture2);
