function [ motion ] = MakeMotion( fileName,N, show )

    
    path = strcat('C:\Users\Dick\Dropbox\School\UF\2014-1 Spring\EEL6825 Pattern Recognition\Project\Programs\Data\test2\', fileName);
    
%     a = strsplit('.txt',fileName);
%     fileName = a{1};
    
    file = fopen(char(path));
    [Ax,Ay,Az,Gx,Gy,Gz] = GetData(file,N);
    motion = struct('Ax',Ax,'Ay',Ay,'Az',Az,'Gx',Gx,'Gy',Gy,'Gz',Gz,'A',sqrt(Ax.^2+Ay.^2+Az.^2),'G',sqrt(Gx.^2+Gy.^2+Gz.^2));


    
    if show == 1
        PlotMotion(motion,1)
    end


    

end