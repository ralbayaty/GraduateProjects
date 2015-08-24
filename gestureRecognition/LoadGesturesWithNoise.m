

Motions = {'square','circle','scrollRight','scrollLeft','scrollUp','scrollDown','goHome','play','pause','star','still'};
totalGestures = 50;

% Iterate over the 10 data sets per gesture
for i = 1:totalGestures
    
    if i < 11
        % Iterate over motions
        for j = 1:11

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
        for j = 1:11
            eval([Motions{j} '_data(1,:,' num2str(i) ') = ' Motions{j} '1.Ax + 2*randn(300,1);']);
            eval([Motions{j} '_data(2,:,' num2str(i) ') = ' Motions{j} '1.Ay + 2*randn(300,1);']);
            eval([Motions{j} '_data(3,:,' num2str(i) ') = ' Motions{j} '1.Az + 2*randn(300,1);']);

            eval([Motions{j} '_data(4,:,' num2str(i) ') = ' Motions{j} '1.Gx + 2*randn(300,1);']);
            eval([Motions{j} '_data(5,:,' num2str(i) ') = ' Motions{j} '1.Gy + 2*randn(300,1);']);
            eval([Motions{j} '_data(6,:,' num2str(i) ') = ' Motions{j} '1.Gz + 2*randn(300,1);']);
        end
    end

end



% Iterate over gestures
for j = 1:11
    figure()
    hold on
    % Iterate over data sets per gesture
    for i = 1:10
    PlotMotion( eval([Motions{j} num2str(i)]),0, Motions{j} )
    end

    hold off
end



% PlotAllMotions(circle1,circle2,circle3,circle4,circle5);
% PlotAllMotions(square1,square2,square3,square4,square5);