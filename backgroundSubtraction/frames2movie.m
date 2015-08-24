function frames2movie(F,name)

    nFrame = size(F,2);
    writerObj = VideoWriter(name);
    open(writerObj);

    for i = 1:nFrame
        writeVideo(writerObj,F(i).cdata);
    end
    close(writerObj);

end

