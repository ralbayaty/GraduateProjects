%%%%%
%	EEE 6512 Image Processing and Computer Vision
%   Fall 2014
%	Final Project
%      Using RPCA methods, perform automatic background subtraction
%      of known video sequences. 
% 
%   Written by:   Dick Al-Bayaty (ralbayaty@ufl.edu)
%   Created:      12/04/2014
%%%%%

clear,clc

%% Load the data:
base_path = 'C:\Users\Dick\Copy\School\UF\2014-2 Fall\EEL6512 Image Processing\Project';
code_path = '\Programs';
output_path = '\Output';
addpath(genpath([base_path '\Programs\External\lrslibrary-master\algorithms']));
addpath([base_path '\Programs\External\lrslibrary-master']);
addpath([base_path '\Programs\R2_PCA\RRPCP']);
addpath([base_path code_path]);


data_type = 'highway';
path = ['C:\Users\Dick\Desktop\dataset2014\dataset\baseline\' data_type '\input'];
cd(path);
list = dir(path);
h = waitbar(0,'Please wait while loading data.');
N = size(list,1);
for i = 3:N
    imgName = list(i).name;
    img = rgb2gray(imread([path '\' imgName]));
    M(:,i-2) = double(img(:)');
    waitbar(i/N);
end
close(h);
[n1,n2] = size(img);
nFrames = size(M,2);
clear img N h imgName

fprintf('--> Data loaded.\n')

%% Robust PCA

cd([base_path '\Output\FPCP'])
tic;resultsFPCA = process_matrix('RPCA', 'FPCP', M, []);runTime(1) = toc
plot_results2(M,resultsFPCA,nFrames,n1,n2,'showO','save',data_type);
clear resultsFPCA

cd([base_path '\Output\GoDec'])
tic;resultsGoDec = process_matrix('RPCA', 'GoDec', M, []);runTime(2) = toc
plot_results2(M,resultsGoDec,nFrames,n1,n2,'showO','save',data_type);
clear resultsGoDec

cd([base_path '\Output\SSGoDec'])
tic;resultsSSGoDec = process_matrix('RPCA', 'SSGoDec', M, []);runTime(3) = toc
plot_results2(M,resultsSSGoDec,nFrames,n1,n2,'showO','save',data_type);
clear resultsSSGoDec

% cd([base_path '\Output\RRPCP'])
% scale = 0.5;
% M2 = batchResize(M,scale,n1,n2);
% tic;resultsRRPCP = runR2PCP(M2,2,21,10,1000,100);runTime(4) = toc
% plot_results2(M2,resultsRRPCP,nFrames,n1*scale,n2*scale,'showO','save',data_type);

% cd(output_path);
% F1 = results2frames(M,resultsRPCA,nFrames,n1,n2);
% F2 = results2frames(M,resultsGoDec,nFrames,n1,n2);
% frames2movie(F1,[data_name '_RPCA.avi']);
% frames2movie(F2,[data_name '_GoDec.avi']);


%% Output testing
% testFrames1 = 470:1700;
data_type = 'highway';
path = ['C:\Users\Dick\Desktop\dataset2014\dataset\baseline\' data_type '\groundtruth'];
Truth1 = loadImages(path);
Truth1 = uint8(hard_threshold(Truth1));
[M,N] = size(Truth1);

path = [base_path '\Output\FPCP\' data_type '\outliers'];
FPCP = uint8(loadImages(path));

path = [base_path '\Output\GoDec\' data_type '\outliers'];
GoDec = uint8(loadImages(path));

path = [base_path '\Output\SSGoDec\' data_type '\outliers'];
SSGoDec = uint8(loadImages(path));

% MSE1(1) = sum(sum((Truth1-FPCP).^2))/(M*N);
% MSE1(2) = sum(sum((Truth1-GoDec).^2))/(M*N);
% MSE1(3) = sum(sum((Truth1-SSGoDec).^2))/(M*N);
% PSNR1 = 10*log10(256*256./MSE1);

PSNR1(1) = psnr(Truth1,FPCP);
PSNR1(2) = psnr(Truth1,GoDec);
PSNR1(3) = psnr(Truth1,SSGoDec)

clear FPCP GoDec SSGoDec


% testFrames2 = 300:1099;
data_type = 'pedestrians';
path = ['C:\Users\Dick\Desktop\dataset2014\dataset\baseline\' data_type '\groundtruth'];
Truth2 = loadImages(path);
Truth2 = uint8(hard_threshold(Truth2));
[M,N] = size(Truth2);

path = [base_path '\Output\FPCP\' data_type '\outliers'];
FPCP = uint8(loadImages(path));

path = [base_path '\Output\GoDec\' data_type '\outliers'];
GoDec = uint8(loadImages(path));

path = [base_path '\Output\SSGoDec\' data_type '\outliers'];
SSGoDec = uint8(loadImages(path));

% MSE2(1) = sum(sum((Truth1-FPCP).^2))/(M*N);
% MSE2(2) = sum(sum((Truth1-GoDec).^2))/(M*N);
% MSE2(3) = sum(sum((Truth1-SSGoDec).^2))/(M*N);
% PSNR2 = 10*log10(256*256./MSE2);

PSNR2(1) = psnr(Truth2,FPCP);
PSNR2(2) = psnr(Truth2,GoDec);
PSNR2(3) = psnr(Truth2,SSGoDec)


clear FPCP GoDec SSGoDec

%% Plot the ground truth outputs

num = 797;
data_type = 'highway';
path = ['C:\Users\Dick\Desktop\dataset2014\dataset\baseline\' data_type '\groundtruth'];
GT1 = imread([path '\gt000' num2str(num) '.png']);
GT1 = uint8(hard_threshold(double(GT1)));
path = [base_path '\Output\FPCP\' data_type '\outliers'];
FPCP = imread([path '\outlier' num2str(num) '.jpg']);
path = [base_path '\Output\GoDec\' data_type '\outliers'];
GoDec = imread([path '\outlier' num2str(num) '.jpg']);
path = [base_path '\Output\SSGoDec\' data_type '\outliers'];
SSGoDec = imread([path '\outlier' num2str(num) '.jpg']);

figure()
    subplot(1,2,1)
imshow(GT1,[])
title('Ground Truth')
    subplot(3,2,2)
imshow(FPCP)
title('FPCP')
    subplot(3,2,4)
imshow(GoDec)
title('GoDec')
    subplot(3,2,6)
imshow(SSGoDec)
title('SSGoDec')

clear FPCP GoDec SSGoDec



num = 478;
data_type = 'pedestrians';
path = ['C:\Users\Dick\Desktop\dataset2014\dataset\baseline\' data_type '\groundtruth'];
GT1 = imread([path '\gt000' num2str(num) '.png']);
GT1 = uint8(hard_threshold(double(GT1)));
path = [base_path '\Output\FPCP\' data_type '\outliers'];
FPCP = imread([path '\outlier' num2str(num) '.jpg']);
path = [base_path '\Output\GoDec\' data_type '\outliers'];
GoDec = imread([path '\outlier' num2str(num) '.jpg']);
path = [base_path '\Output\SSGoDec\' data_type '\outliers'];
SSGoDec = imread([path '\outlier' num2str(num) '.jpg']);

figure()
    subplot(1,2,1)
imshow(GT1,[])
title('Ground Truth')
    subplot(3,2,2)
imshow(FPCP)
title('FPCP')
    subplot(3,2,4)
imshow(GoDec)
title('GoDec')
    subplot(3,2,6)
imshow(SSGoDec)
title('SSGoDec')

clear FPCP GoDec SSGoDec

%% Plot the X = L + S

num = 797;
data_type = 'highway';
path = ['C:\Users\Dick\Desktop\dataset2014\dataset\baseline\' data_type '\input'];
IN1 = imread([path '\in000' num2str(num) '.jpg']);
path = [base_path '\Output\FPCP\' data_type '\images'];
FPCP = imread([path '\img' num2str(num) '.jpg']);
FPCP = FPCP(:,320:end);
path = [base_path '\Output\GoDec\' data_type '\images'];
GoDec = imread([path '\img' num2str(num) '.jpg']);
GoDec = GoDec(:,320:end);
path = [base_path '\Output\SSGoDec\' data_type '\images'];
SSGoDec = imread([path '\img' num2str(num) '.jpg']);
SSGoDec = SSGoDec(:,320:end);

figure()
    subplot(1,2,1)
imshow(IN1)
title('Input')
    subplot(3,2,2)
imshow(FPCP)
title('FPCP')
    subplot(3,2,4)
imshow(GoDec)
title('GoDec')
    subplot(3,2,6)
imshow(SSGoDec)
title('SSGoDec')

clear FPCP GoDec SSGoDec



num = 478;
data_type = 'pedestrians';
path = ['C:\Users\Dick\Desktop\dataset2014\dataset\baseline\' data_type '\input'];
IN1 = imread([path '\in000' num2str(num) '.jpg']);
path = [base_path '\Output\FPCP\' data_type '\images'];
FPCP = imread([path '\img' num2str(num) '.jpg']);
FPCP = FPCP(:,360:end);
path = [base_path '\Output\GoDec\' data_type '\images'];
GoDec = imread([path '\img' num2str(num) '.jpg']);
GoDec = GoDec(:,360:end);
path = [base_path '\Output\SSGoDec\' data_type '\images'];
SSGoDec = imread([path '\img' num2str(num) '.jpg']);
SSGoDec = SSGoDec(:,360:end);

figure()
    subplot(1,2,1)
imshow(IN1)
title('Input')
    subplot(3,2,2)
imshow(FPCP)
title('FPCP')
    subplot(3,2,4)
imshow(GoDec)
title('GoDec')
    subplot(3,2,6)
imshow(SSGoDec)
title('SSGoDec')

clear FPCP GoDec SSGoDec
