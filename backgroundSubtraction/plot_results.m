function plot_results(I,L,S,O,nFrame,vidHeight,vidWidth)
% I - Input sequence
% L - Low-rank sequence
% S - Sparse sequence
% O - Outliers sequence
% nFrame - Number of frames
% vidHeight - Video height
% vidWidth - Video width

    if size(I,1) == vidHeight && size(I,2) == vidWidth
        reSize = 0;
    else
        reSize = 1;
    end

  warning('off','all');
  h = figure();
  set(h, 'Position', [100, 100, 600, 150]);

  for i = 1:nFrame
      switch reSize
          case 0
            Input = I;
            LowRank = L;
            Sparse = S;
            if(~isempty(O))
              Outlier = O;
            else
              Outlier = uint8(zeros(size(Input)));
            end  
           
          case 1
            Input = reshape(I(:,i),vidHeight,vidWidth);
            LowRank = reshape(L(:,i),vidHeight,vidWidth);
            Sparse = reshape(S(:,i),vidHeight,vidWidth);
            if(~isempty(O))
              Outlier = reshape(O(:,i),vidHeight,vidWidth);
            else
              Outlier = uint8(zeros(size(Input)));
            end              
      end
      
        ax1=subplot(1,4,1); imshow(Input,[]), title('Input (I)');
        set(ax1,'position',[0 0 1/4 1],'units','normalized');
        ax2=subplot(1,4,2); imshow(LowRank,[]), title('Low Rank (L)');
        set(ax2,'position',[1/4 0 1/4 1],'units','normalized');
        ax3=subplot(1,4,3); imshow(Sparse,[]), title('Sparse (S)');
        set(ax3,'position',[2/4 0 1/4 1],'units','normalized');
        ax4=subplot(1,4,4); imshow(Outlier,[]), title('Outliers (O)');
        set(ax4,'position',[3/4 0 1/4 1],'units','normalized');
        %         subplot(2,3,5), imshow(medfilt2(Outlier, [5 5]),[]), title('Filtered Outliers');
        %         drawnow
        saveas(h,['frame_' num2str(i) '.jpeg']);
  end
  
  warning('on','all');
end

