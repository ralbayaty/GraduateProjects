function X = loadImages(path)



cd(path);
list = dir(path);
N = size(list,1);
h = waitbar(0,'Please wait while loading data.');
for i = 3:N
    imgName = list(i).name;
    img = imread([path '\' imgName]);
    X(:,i-2) = double(img(:)');
    waitbar(i/N);
end
close(h);
clear img h imgName N