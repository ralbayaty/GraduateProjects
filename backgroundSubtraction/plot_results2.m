function plot_results2(I,results,nFrame,vidHeight,vidWidth,showO,plotSave,data_type)
% I - Input sequence
% L - Low-rank sequence
% S - Sparse sequence
% O - Outliers sequence
% nFrame - Number of frames
% vidHeight - Video height
% vidWidth - Video width

L = results.L;
S = results.S;
O = results.O;
% F(nFrame) = struct('cdata',[],'colormap',[]);

for i = 1:nFrame
        
    Input = reshape(I(:,i),vidHeight,vidWidth);
    LowRank = reshape(L(:,i),vidHeight,vidWidth);
    Sparse = reshape(S(:,i),vidHeight,vidWidth);
    if(~isempty(O))
      Outlier = reshape(O(:,i),vidHeight,vidWidth);
    else
      Outlier = uint8(zeros(size(Input)));
    end

    
    if strcmp(plotSave,'plot')
        Img = [Input,LowRank,Sparse];
        if strcmp(showO,'showO')
                subplot(1,2,1)
            imshow(Img,[]);
                subplot(1,2,2)
            imshow(Outlier,[]);
        else
            imshow(Img,[]);
        end
        drawnow
    else
        Img = [uint8(Input),uint8(LowRank),uint8(Sparse)];
        Img = imadjust(Img,[]);
        imwrite(Img,[data_type '\images\' 'img' num2str(i) '.jpg']);
        imwrite(Outlier,[data_type '\outliers\' 'outlier' num2str(i) '.jpg']);
    end
    
%     figure()
%         subplot(1,4,1)
%     imshow(Input2)
%     title('Original')
%         subplot(1,4,2)
%     imshow(LowRank2)
%     title('Background: Low Rank')
%         subplot(1,4,3)
%     imshow(Sparse2)
%     title('Foreground: Sparse')
%         subplot(1,4,4)
%     imshow(Outlier)
%     title('Outlier Flag: logical 0 or 1')

%     F(i) = im2frame(uint8(Img),gray(256));

end

end

