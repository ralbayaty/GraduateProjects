function F = results2frames(I,results,nFrame,n1,n2)
% I - Input sequence
% L - Low-rank sequence
% S - Sparse sequence
% O - Outliers sequence
% nFrame - Number of frames
% vidHeight - Video height
% n2 - Video width

L = results.L;
S = results.S;

F(nFrame) = struct('cdata',[],'colormap',[]);


for i = 1:nFrame

    Input = reshape(I(:,i),n1,n2);
    LowRank = reshape(L(:,i),n1,n2);
    Sparse = reshape(S(:,i),n1,n2);            

    Img = [imadjust(Input,stretchlim(Input),[0 1]),imadjust(LowRank,stretchlim(LowRank),[0 1]),imadjust(Sparse,stretchlim(Sparse),[0 1]),imadjust(Outlier,stretchlim(Outlier),[0 1])];
%         Img = [Input,LowRank,Sparse];

    F(i) = im2frame(uint8(Img),gray(256));

end


end

