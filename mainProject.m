% Zarin Subah Shamma : A02368194
% Final Project

clear all
close all 
clc

tStart = tic;
im1 = imread('Crow.jpg');
im2 = imread('Plane.jpg');
im3 = imread('Tree.jpg');
[a,b,~] = size(im3);
im4 = imread('Statues.jpg');
im4 = imresize(im4,[a b]);  % Converting the image size from 481x321 to 321x481
im5 = imread('Boat.jpg');
im5 = imresize(im5,[a b]);  % Converting the image size from 481x321 to 321x481
im6 = imread('Man&Building.jpg');
im7 = imread('Garden.jpg');

%% My Implementation of Proposed Algorithm in Paper

tStart1 = tic;
[R, C, ~] = size(im1);
seed1(1,:) = [round(R/2),round(C/2)];  % Intial seed = Center pixel
[R, C, ~] = size(im2);
seed2(1,:) = [round(R/2),round(C/2)];
[R, C, ~] = size(im3);
seed3(1,:) = [round(R/2),round(C/2)];
[R, C, ~] = size(im4);
seed4(1,:) = [round(R/2),round(C/2)];
[R, C, ~] = size(im5);
seed5(1,:) = [round(R/2),round(C/2)];
[R, C, ~] = size(im6);
seed6(1,:) = [round(R/2),round(C/2)];
[R, C, ~] = size(im7);
seed7(1,:) = [round(R/2),round(C/2)];

[segmentedIm1] = RegionGrowingAlgo(im1,seed1); 
[segmentedIm2] = RegionGrowingAlgo(im2,seed2);
[segmentedIm3] = RegionGrowingAlgo(im3,seed3); 
[segmentedIm4] = RegionGrowingAlgo(im4,seed4); 
[segmentedIm5] = RegionGrowingAlgo(im5,seed5);
[segmentedIm6] = RegionGrowingAlgo(im6,seed6);
[segmentedIm7] = RegionGrowingAlgo(im7,seed7);
tEnd1 = toc(tStart1); 

%% My Implementation of Watershed Algorithm 

tStart2 = tic;
[segmentedImW1] = watershedAlgo(im1);
[segmentedImW2] = watershedAlgo(im2);
[segmentedImW3] = watershedAlgo(im3);
[segmentedImW4] = watershedAlgo(im4);
[segmentedImW5] = watershedAlgo(im5);
[segmentedImW6] = watershedAlgo(im6);
[segmentedImW7] = watershedAlgo(im7);
tEnd2 = toc(tStart2); 

%% Converting Region matrix into RGB 

segmentedImRGB1 = label2rgb(segmentedIm1,'spring','m','shuffle');
segmentedImRGB2 = label2rgb(segmentedIm2,'spring','m','shuffle');
segmentedImRGB3 = label2rgb(segmentedIm3,'jet','b','shuffle');
segmentedImRGB4 = label2rgb(segmentedIm4,'jet','b','shuffle');
segmentedImRGB5 = label2rgb(segmentedIm5,'jet','b','shuffle');
segmentedImRGB6 = label2rgb(segmentedIm6,'jet','b','shuffle');
segmentedImRGB7 = label2rgb(segmentedIm7,'jet','b','shuffle');

segmentedImWRGB1 = mat2gray(segmentedImW1);
segmentedImWRGB2 = mat2gray(segmentedImW2);
segmentedImWRGB3 = mat2gray(segmentedImW3);
segmentedImWRGB4 = mat2gray(segmentedImW4);
segmentedImWRGB5 = mat2gray(segmentedImW5);
segmentedImWRGB6 = mat2gray(segmentedImW6);
segmentedImWRGB7 = mat2gray(segmentedImW7);

%% Calculating F-Value 

tStart3 = tic;
[R1,Fscaled1] = calculateFvalue(segmentedIm1,im1,segmentedImRGB1,1e10);
[R2,Fscaled2] = calculateFvalue(segmentedIm2,im2,segmentedImRGB2,1000);
[R3,Fscaled3] = calculateFvalue(segmentedIm3,im3,segmentedImRGB3,1e10);
[R4,Fscaled4] = calculateFvalue(segmentedIm4,im4,segmentedImRGB4,10000);
[R5,Fscaled5] = calculateFvalue(segmentedIm5,im5,segmentedImRGB5,10000);
[R6,Fscaled6] = calculateFvalue(segmentedIm6,im6,segmentedImRGB6,1000);
[R7,Fscaled7] = calculateFvalue(segmentedIm7,im7,segmentedImRGB7,1e9);

[Rw1,FscaledW1] = calculateFvalue(segmentedImW1(:,:,1),im1,segmentedImWRGB1,1000);
[Rw2,FscaledW2] = calculateFvalue(segmentedImW2(:,:,1),im2,segmentedImWRGB2,1000);
[Rw3,FscaledW3] = calculateFvalue(segmentedImW3(:,:,1),im3,segmentedImWRGB3,1000);
[Rw4,FscaledW4] = calculateFvalue(segmentedImW4(:,:,1),im4,segmentedImWRGB4,1000);
[Rw5,FscaledW5] = calculateFvalue(segmentedImW5(:,:,1),im5,segmentedImWRGB5,100);
[Rw6,FscaledW6] = calculateFvalue(segmentedImW6(:,:,1),im6,segmentedImWRGB6,1000);
[Rw7,FscaledW7] = calculateFvalue(segmentedImW7(:,:,1),im7,segmentedImWRGB7,1000);
tEnd3 = toc(tStart3); 

%% Showing Images

figure(1)
subplot(1,3,1)
imshow(im1);
title('Original Image');
subplot(1,3,2)
imshow(segmentedImRGB1); 
title(["Segmented Image",sprintf('Region no %d',R1)]);
subplot(1,3,3)
imshow(segmentedImWRGB1); 
title(["Watershed Segmented Image",sprintf('Region no %d',Rw1)]);

figure(2)
subplot(1,3,1)
imshow(im2);
title('Original Image');
subplot(1,3,2)
imshow(segmentedImRGB2); 
title(["Segmented Image",sprintf('Region no %d',R2)]);
subplot(1,3,3)
imshow(segmentedImWRGB2); 
title(["Watershed Segmented Image",sprintf('Region no %d',Rw2)]);

figure(3)
subplot(1,3,1)
imshow(im3);
title('Original Image');
subplot(1,3,2)
imshow(segmentedImRGB3); 
title(["Segmented Image",sprintf('Region no %d',R3)]);
subplot(1,3,3)
imshow(segmentedImWRGB3); 
title(["Watershed Segmented Image",sprintf('Region no %d',Rw3)]);

figure(4)
subplot(1,3,1)
imshow(im4);
title('Original Image');
subplot(1,3,2)
imshow(segmentedImRGB4); 
title(["Segmented Image",sprintf('Region no %d',R4)]);
subplot(1,3,3)
imshow(segmentedImWRGB4); 
title(["Watershed Segmented Image",sprintf('Region no %d',Rw4)]);

figure(5)
subplot(1,3,1)
imshow(im5);
title('Original Image');
subplot(1,3,2)
imshow(segmentedImRGB5); 
title(["Segmented Image",sprintf('Region no %d',R5)]);
subplot(1,3,3)
imshow(segmentedImWRGB5); 
title(["Watershed Segmented Image",sprintf('Region no %d',Rw5)]);

figure(6)
subplot(1,3,1)
imshow(im6);
title('Original Image');
subplot(1,3,2)
imshow(segmentedImRGB6); 
title(["Segmented Image",sprintf('Region no %d',R6)]);
subplot(1,3,3)
imshow(segmentedImWRGB6); 
title(["Watershed Segmented Image",sprintf('Region no %d',Rw6)]);

figure(7)
subplot(1,3,1)
imshow(im7);
title('Original Image');
subplot(1,3,2)
imshow(segmentedImRGB7); 
title(["Segmented Image",sprintf('Region no %d',R7)]);
subplot(1,3,3)
imshow(segmentedImWRGB7); 
title(["Watershed Segmented Image",sprintf('Region no %d',Rw7)]);

%% Making Table to Compare F-Values 

Image = string({'Crow';'Plane';'Tree';'Statues';'Boat';'Man&Building';'Garden'});
My_Version_of_Proposed_Algorithm = double([Fscaled1;Fscaled2;Fscaled3;Fscaled4;Fscaled5;Fscaled6;Fscaled7]);
My_Watershed_Algorithm = double([FscaledW1;FscaledW2;FscaledW3;FscaledW4;FscaledW5;FscaledW6;FscaledW7]);

T = table(Image,My_Version_of_Proposed_Algorithm,My_Watershed_Algorithm);
fprintf('\n<strong>Comparison between F-Values: </strong>\n\n');
disp(T);

%% My Improvement to Proposed Algorithm in Paper 

tStart4 = tic;
[segmentedImNew1, outlineImNew1] = improvedAlgorithm(im1);
[segmentedImNew7, outlineImNew7] = improvedAlgorithm(im7);

segmentedImNewRGB1 = label2rgb(segmentedImNew1,'spring','m','shuffle');
segmentedImNewRGB7 = label2rgb(segmentedImNew7,'jet','b','shuffle');

[Rnew1,FscaledNew1] = calculateFvalue(segmentedImNew1,im1,segmentedImNewRGB1,1e10);
[Rnew7,FscaledNew7] = calculateFvalue(segmentedImNew7,im7,segmentedImNewRGB7,1e9);

figure(8)
subplot(2,11,1:3)
imshow(im1);
title('Original Image');
subplot(2,11,5:7)
imshow(segmentedImRGB1); 
title(["Segmented Image",sprintf('Region no %d',R1)]);
subplot(2,11,9:11)
imshow(segmentedImNewRGB1);
title(["Improved Segmented Image",sprintf('Region no %d',Rnew1)]);
subplot(2,11,14:16)
imshow(outlineImNew1);
title('Improved Segmented Image Outline');
subplot(2,11,18:20)
imshow(segmentedImWRGB1); 
title(["Watershed Segmented Image",sprintf('Region no %d',Rw1)]);

figure(9)
subplot(2,11,1:3)
imshow(im7);
title('Original Image');
subplot(2,11,5:7)
imshow(segmentedImRGB7); 
title(["Segmented Image",sprintf('Region no %d',R1)]);
subplot(2,11,9:11)
imshow(segmentedImNewRGB7)
title(["New Segmented Image",sprintf('Region no %d',Rnew7)]);
subplot(2,11,14:16)
imshow(outlineImNew7);
title('Improved Segmented Image Outline');
subplot(2,11,18:20)
imshow(segmentedImWRGB7); 
title(["Watershed Segmented Image",sprintf('Region no %d',Rw7)]);

Image = string({'Crow';'Garden'});
My_Version_of_Proposed_Algorithm = double([Fscaled1;Fscaled7]);
My_Improvement_to_Proposed_Algorithm = double([FscaledNew1;FscaledNew7]);
My_Watershed_Algorithm = double([FscaledW1;FscaledW7]);

T1 = table(Image,My_Version_of_Proposed_Algorithm,My_Improvement_to_Proposed_Algorithm,My_Watershed_Algorithm);
fprintf('\n<strong>Comparison between F-Values: </strong>\n\n');
disp(T1);


% Checking the Compatibility of the Improved Algorithm to HSV, YCbCr and Grayscale 

im1 = rgb2hsv(im1);
im2 = rgb2ycbcr(im2);
im3 = rgb2gray(im3);

[segmentedImHSV1, outlineImHSV1] = improvedAlgorithm(im1);
[segmentedImYCbCr2, outlineImYCbCr2] = improvedAlgorithm(im2);
[segmentedImGray3, outlineImGray3] = improvedAlgorithm(im3);

segmentedImHSVRGB1 = label2rgb(segmentedImHSV1,'spring','m','shuffle');
segmentedImYCbCrRGB2 = label2rgb(segmentedImYCbCr2,'spring','y','shuffle');
segmentedImGrayRGB3 = label2rgb(segmentedImGray3,'jet','b','shuffle');


figure(10)
subplot(2,11,1:3)
imshow(im1);
title('Original Image in HSV');
subplot(2,11,5:7)
imshow(segmentedImHSVRGB1);
title('Improved Segmented Image');
subplot(2,11,9:11)
imshow(segmentedImRGB1); 
title('Segmented Image');
subplot(2,11,14:16)
imshow(outlineImHSV1);
title('Improved Segmented Image Outline');
subplot(2,11,18:20)
imshow(segmentedImWRGB1); 
title('Watershed Segmented Image');

figure(11)
subplot(2,11,1:3)
imshow(im2);
title('Original Image in YCbCr');
subplot(2,11,5:7)
imshow(segmentedImYCbCrRGB2);
title('Improved Segmented Image');
subplot(2,11,9:11)
imshow(segmentedImRGB2); 
title('Segmented Image');
subplot(2,11,14:16)
imshow(outlineImYCbCr2);
title('Improved Segmented Image Outline');
subplot(2,11,18:20)
imshow(segmentedImWRGB2); 
title('Watershed Segmented Image');

figure(12)
subplot(2,11,1:3)
imshow(im3);
title('Original Image in Grayscale');
subplot(2,11,5:7)
imshow(segmentedImGrayRGB3);
title('Improved Segmented Image');
subplot(2,11,9:11)
imshow(segmentedImRGB3); 
title('Segmented Image');
subplot(2,11,14:16)
imshow(outlineImGray3);
title('Improved Segmented Image Outline');
subplot(2,11,18:20)
imshow(segmentedImWRGB3); 
title('Watershed Segmented Image');
tEnd4 = toc(tStart4);

tEnd = toc(tStart);

fprintf('\n<strong>Elapsed time for my implementation of Proposed method: %f seconds</strong>\n',tEnd1);
fprintf('\n<strong>Elapsed time for my implementation of Watershed method: %f seconds</strong>\n',tEnd2);
fprintf('\n<strong>Elapsed time for calculating F-factor of both methods: %f seconds</strong>\n',tEnd3);
fprintf('\n<strong>Elapsed time for my Improvement: %f seconds</strong>\n',tEnd4);
fprintf('\n<strong>Total elapsed time for the project: %f seconds</strong>\n\n',tEnd);



