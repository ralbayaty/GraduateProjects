

cd('C:\Users\Dick\Dropbox\School\UF\2014-2 Fall\EEL6512 Image Processing\Project\Programs\External\lrslibrary-master\dataset');


source = 'C:\Users\Dick\Dropbox\School\UF\2014-2 Fall\EEL6512 Image Processing\Project\Programs\External\lrslibrary-master\dataset\ben.mp4';
vidobj = VideoReader(source);
frames = vidobj.Numberofframes;
for f = 1:frames
    thisframe = read(vidobj,f);
    hf = figure(1);
    set(hf, 'position', [150 150 vidobj.Width vidobj.Height]);
    imagesc(thisframe);axis off;
    thisfile = ['C:\Users\Dick\Desktop\ben\frame_' num2str(f) '.jpg'];
    imwrite(thisframe,thisfile);
    fprintf('Frame %d saved. \n',f);
    mov(f).cdata = thisframe;
    mov(f).colormap = [];
end


%% Make movie and play it
for f = 1:743
    mov(f).cdata = imread(['C:\Users\Dick\Desktop\ben\480x270\frame_' num2str(f) '_480x270.jpg']);
    mov(f).colormap = [];
end

hf = figure(2);
set(hf, 'position', [150 150 480 270])
% Playback movie once at the video's frame rate
movie(hf, mov, 1, 30);

%% Downsample images
root = 'C:\Users\Dick\Desktop\ben\1920x1080';

changeSize = 1/20;
newWidth = round(1920*changeSize);
newHeight = round(1080*changeSize);

n1 = newHeight;
n2 = newWidth;
numFrames = 743;

if ~exist(['C:\Users\Dick\Desktop\ben\' num2str(newWidth) 'x' num2str(newHeight)],'dir')
    mkdir(['C:\Users\Dick\Desktop\ben\' num2str(newWidth) 'x' num2str(newHeight)]);
end

for f = 1:numFrames
    thisframe = imread([root '\frame_' num2str(f) '.jpg']);
    thisframe = imresize(thisframe,[newHeight newWidth]);
    imwrite(thisframe,['C:\Users\Dick\Desktop\ben\' num2str(newWidth) 'x' num2str(newHeight) '\frame_' num2str(f) '.jpg']);
    fprintf('Frame %d downsized. \n',f);
    data(f,:) = reshape(rgb2gray(thisframe),1,size(thisframe,1)*size(thisframe,2));
end

save(['C:\Users\Dick\Desktop\ben\' num2str(newWidth) 'x' num2str(newHeight) '\data.mat'],'data','n1','n2','numFrames');
