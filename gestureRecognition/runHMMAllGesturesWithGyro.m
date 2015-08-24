clear,clc

% Load the gesture data from file
load('C:\Users\Dick\Dropbox\School\UF\2014-1 Spring\EEL6825 Pattern Recognition\Project\Programs\Data\test2\gestureData2.mat');
load('C:\Users\Dick\Dropbox\School\UF\2014-1 Spring\EEL6825 Pattern Recognition\Project\Programs\Data\test2\OthersGestureData2.mat')

O = 6;          %Number of coefficients in a vector (Dimension of Observation Space)
nex = 10;       %Number of Observation sequences
T = 300;        %Number of vectors in a sequence (time)
M = 11;         %Number of Gaussian mixtures 
Q = 11;         %Number of states
missclass = zeros(9,3);
runtimes = zeros(1,6);


for runs = 7
tic;
percentTraining = runs/10;   % per gesture


numTrain = round(percentTraining*10);
numTest = 10 - numTrain;

nex = numTrain;

% Names of the gesture motions
Motions = {'square','circle','scrollRight','scrollLeft','scrollUp','scrollDown','goHome','play','pause','star','still'};


% Create HMM per gesture
for i = 1:Q
    
    eval( ['[ loglik' num2str(i) ', LL' num2str(i) ', prior' num2str(i) ', transmat' num2str(i) ', mu' num2str(i) ', Sigma' num2str(i) ', mixmat' num2str(i) ' ] = GenMHMM( ' Motions{i} '_data(:,:,1:numTrain),O,M,Q );'] );
    fprintf('Gesture %d created.\n\n',i);
    
end

%% Run the test sets through the HMM's
     
% Test with the remaining data sets
LL = zeros(1,Q);
Confusion = zeros(Q,Q);

% Iterate over the number of test sets (numTest)
for i = 1:numTest
    
    % Iterate over each type of gesture's testing data
    for j = 1:Q
        
        
        % Test each model for its log likelihood to the data
        for k = 1:Q
        eval(['LL(' num2str(k) ') = mhmm_logprob(' Motions{j} '_data(:,:,numTrain+' num2str(i) '), prior' num2str(k) ', transmat' num2str(k) ', mu' num2str(k) ', Sigma' num2str(k) ', mixmat' num2str(k) ');']);
             
        end
        
        % Find the maximum log likelihood to determine the best classifier for
        % the test case
        [maxVal,loc] = max(LL);

        % Confusion(i,j) corresponds to the i-th real gesture classification into the j-th gesture
        Confusion(j,loc) = Confusion(j,loc) + 1;
        
    end
    

end

 Confusion./sum(sum(Confusion))
 missclass(runs,1) = ( sum(sum(Confusion))-sum(diag(Confusion)) )/sum(sum(Confusion));
   
%    figure()
%    bar3(Confusion)
%    ylabel('Reality')
%    xlabel('Test')
%    zlabel('Classification Percentages')
%    title('Confusion Matrix for Testing Data')
   
   
   
   
%% Run an additional user's gestures through the HMM's
% Test with the remaining data sets
LL2 = zeros(1,Q-1);
Confusion2 = zeros(Q,Q);
Motions2 = {'squareM','circleM','scrollRightM','scrollLeftM','scrollUpM','scrollDownM','goHomeM','playM','pauseM','starM','stillM'};

% Iterate over the number of test sets (numTest)
for i = 1:2
    
    % Iterate over each type of gesture's testing data (w/o 'still')
    for j = 1:Q-1        
        
        % Test each model for its log likelihood to the data
        for k = 1:Q-1
        eval(['LL2(' num2str(k) ') = mhmm_logprob(' Motions2{j} '_data(:,:,' num2str(i) '), prior' num2str(k) ', transmat' num2str(k) ', mu' num2str(k) ', Sigma' num2str(k) ', mixmat' num2str(k) ');']);
             
        end
        
        % Find the maximum log likelihood to determine the best classifier for
        % the test case
        [maxVal2,loc2] = max(LL2);

        % Confusion(i,j) corresponds to the i-th real gesture classification into the j-th gesture
        Confusion2(j,loc2) = Confusion2(j,loc2) + 1;

        
    end
    

end

 Confusion2./sum(sum(Confusion2))
  missclass(runs,2) = ( sum(sum(Confusion2))-sum(diag(Confusion2)) )/sum(sum(Confusion2));
%   
%     figure()
%    bar3(Confusion2)
%    ylabel('Reality')
%    xlabel('Test')
%    zlabel('Classification Percentages')
%    title('Confusion Matrix for Additional User Gestures')
 
 
%% Look at the results of all user gestures (both users)
 
   
   
   ConfusionTot = Confusion+Confusion2
   missclass(runs,3) = ( sum(sum(ConfusionTot))-sum(diag(ConfusionTot)) )/sum(sum(ConfusionTot));
   missclass(runs,:) = missclass(runs,:)*100
   
   fprintf('Test set missclassification rate: %.2f %%\n',missclass(runs,1))
   fprintf('2nd User set missclassification rate: %.2f %%\n',missclass(runs,2))
   fprintf('Total data missclassification rate: %.2f %%\n',missclass(runs,3))
   
   runtimes(runs-3) = toc;
   
   figure()
   subplot(1,2,1)
   bar3(Confusion)
   ylabel('Reality')
   xlabel('Test')
   zlabel('Classifications')
   title('Confusion Matrix for Testing Data')
   
%    figure()
   subplot(1,2,2)
   bar3(Confusion2)
   ylabel('Reality')
   xlabel('Test')
   zlabel('Classifications')
   title('Confusion Matrix for 2^{nd} User''s Gestures')
   
   figure()
   bar3(ConfusionTot./sum(sum(ConfusionTot)))
   ylabel('Reality')
   xlabel('Test')
   zlabel('Classification Percentages')
   title('Confusion Matrix for test cases: 2 users')
   
   
end

runtimes

%    figure()
%    stem([40,50,60,70,80,90],runtimes(1:6))
%    xlabel('Training Data % of Total Data')
%    ylabel('Time (seconds) Comparison')
%    title('Comparison in Run Times for varying % Training Data')
