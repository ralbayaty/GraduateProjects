% 
% 
% for i = 1:6
%     eval(['circleM' num2str(i) '=  MakeMotion(''circleM' num2str(i) '.txt'',300,0);']);
% 
%     eval(['circleM_test(1,:,' num2str(i) ') = circleM' num2str(i) '.Ax;']);
%     eval(['circleM_test(2,:,' num2str(i) ') = circleM' num2str(i) '.Ay;']);
%     eval(['circleM_test(3,:,' num2str(i) ') = circleM' num2str(i) '.Az;']);
%         
%     if i < 6
%         eval(['squareM' num2str(i) '=  MakeMotion(''squareM' num2str(i) '.txt'',300,0);']);
%         
%         eval(['squareM_test(1,:,' num2str(i) ') = squareM' num2str(i) '.Ax;']);
%         eval(['squareM_test(2,:,' num2str(i) ') = squareM' num2str(i) '.Ay;']);
%         eval(['squareM_test(3,:,' num2str(i) ') = squareM' num2str(i) '.Az;']);
%     end
% 
% end
% 
% PlotAllMotions(circleM1,circleM2,circleM3,circleM4,circleM5);
% PlotAllMotions(squareM1,squareM2,squareM3,squareM4,squareM5);




Motions = {'circleM','goHomeM','pauseM','playM','scrollDownM','scrollLeftM','scrollRightM','scrollUpM','squareM','starM'};



% Iterate over the 2 data sets per gesture
for i = 1:2
    
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

end


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



% PlotAllMotions(circle1,circle2,circle3,circle4,circle5);
% PlotAllMotions(square1,square2,square3,square4,square5);