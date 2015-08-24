
path = 'C:\Users\Dick\Dropbox\School\UF\2014-2 Fall\EEL6512 Image Processing\Project\Data\Escalator\';
name = 'escalator_data';
allFiles = dir( path );
allNames = { allFiles.name };
allNames = allNames(3:end);
N = size(allNames,2);
[q_1,q_2] = size(rgb2gray(imread([path allNames{1}])));
P = q_1*q_2;
X = zeros(N,P);

for i = 1:N
    temp = rgb2gray(imread([path allNames{i}]));
    temp = temp(:);
    X(i,:) = temp';
end

save([path name '.mat'],'X','q_1','q_2');