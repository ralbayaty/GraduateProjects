
Motions = {'circleM','goHomeM','pauseM','playM','scrollDownM','scrollLeftM','scrollRightM','scrollUpM','squareM','starM'};

totalGestures = 10;

% Iterate over the 2 data sets per gesture
for i = 1:totalGestures
    
    if i < 3
        % Iterate over motions
        for j = 1:10

            eval([Motions{j} num2str(i) '=  MakeMotion(''' Motions{j} num2str(i) '.txt'',300,0);']);
            eval([Motions{j} '_data(1,:,' num2str(i) ') = ' Motions{j} num2str(i) '.Ax;']);
            eval([Motions{j} '_data(2,:,' num2str(i) ') = ' Motions{j} num2str(i) '.Ay;']);
            eval([Motions{j} '_data(3,:,' num2str(i) ') = ' Motions{j} num2str(i) '.Az;']);

            eval([Motions{j} '_data(4,:,' num2str(i) ') = ' Motions{j} num2str(i) '.Gx;']);
            eval([Motions{j} '_data(5,:,' num2str(i) ') = ' Motions{j} num2str(i) '.Gy;']);
            eval([Motions{j} '_data(6,:,' num2str(i) ') = ' Motions{j} num2str(i) '.Gz;']);
        end
    else
        % Iterate over motions
        for j = 1:10
            eval([Motions{j} '_data(1,:,' num2str(i) ') = ' Motions{j} '1.Ax + 2*randn(300,1);']);
            eval([Motions{j} '_data(2,:,' num2str(i) ') = ' Motions{j} '1.Ay + 2*randn(300,1);']);
            eval([Motions{j} '_data(3,:,' num2str(i) ') = ' Motions{j} '1.Az + 2*randn(300,1);']);

            eval([Motions{j} '_data(4,:,' num2str(i) ') = ' Motions{j} '1.Gx + 2*randn(300,1);']);
            eval([Motions{j} '_data(5,:,' num2str(i) ') = ' Motions{j} '1.Gy + 2*randn(300,1);']);
            eval([Motions{j} '_data(6,:,' num2str(i) ') = ' Motions{j} '1.Gz + 2*randn(300,1);']);
        end
    end

end


% % Iterate over the 10 data sets per gesture
% for i = 3:totalGestures
%     
%     % Iterate over motions
%     for j = 1:10
%         
%         eval([Motions{j} '_data(1,:,' num2str(i) ') = ' Motions{j} '1.Ax + 2*randn(300,1);']);
%         eval([Motions{j} '_data(2,:,' num2str(i) ') = ' Motions{j} '1.Ay + 2*randn(300,1);']);
%         eval([Motions{j} '_data(3,:,' num2str(i) ') = ' Motions{j} '1.Az + 2*randn(300,1);']);
%         
%         eval([Motions{j} '_data(4,:,' num2str(i) ') = ' Motions{j} '1.Gx + 2*randn(300,1);']);
%         eval([Motions{j} '_data(5,:,' num2str(i) ') = ' Motions{j} '1.Gy + 2*randn(300,1);']);
%         eval([Motions{j} '_data(6,:,' num2str(i) ') = ' Motions{j} '1.Gz + 2*randn(300,1);']);
%     end
% 
% end


% Iterate over gestures
for j = 1:10
    figure()
    hold on
    % Iterate over data sets per gesture
    for i = 1:2
    PlotMotion( eval([Motions{j} num2str(i)]),0, Motions{j} )
    end

    hold off
end
