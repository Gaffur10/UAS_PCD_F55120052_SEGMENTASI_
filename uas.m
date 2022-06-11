clear;
clc;
close all;

img = imread ('daun1.jpg');
Lab = rgb2lab(img);
ab = double(Lab(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2); 
numberOfClasses = 2;
indexes = kmeans(ab,numberOfClasses);
classImage = reshape(indexes,nrows,ncols);
area = zeros(numberOfClasses,1);
for n = 1:numberOfClasses
    area(n) = sum(sum(classImage==n));
end
[~,min_area] = min(area);
bw = classImage==min_area;
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
bw2 = ~imbinarize(B);
bw3 = imsubtract(bw2,bw);
bw4 = bwareaopen(bw3,60);
R(~bw4) = 0;
G(~bw4) = 0;
B(~bw4) = 0;
RGB = cat(3,R,G,B);
 

figure
subplot (4,4,1),imshow(img); title('citra asli');
subplot (4,4,2),imshow(Lab); title('citra L*a*b');
subplot (4,4,3),imshow(classImage,[]); title('K-means');
subplot (4,4,4),imshow(bw); title('area terkecil');
subplot (4,4,5),imshow(B); title('thresholding');
subplot (4,4,6),imshow(bw3); title('subtraksi');
subplot (4,4,7),imshow(bw4); title('morfologi');
subplot (4,4,8),imshow(RGB); title('hasil segmentasi');

figure
subplot (1,2,1),imshow(img); title('citra asli');
subplot (1,2,2),imshow(RGB); title('hasil segmentasi');