

%%
c = yahoo;
s = {'AAPL'};
fromdate = '1/01/2014';
todate = '2/01/2014';

data = builduniverse(c,s,fromdate,todate,'d');
data1(:,1) = {datestr(data(:,1))};
data1(:,2) = {data(:,2)};
close(c)

%%

c = yahoo;
for i = 50:60
    s = stockList(i);
    fromdate = '1/01/2014';
    todate = '6/01/2014';

    data = builduniverse(c,s,fromdate,todate,'d');
%     data1(:,1) = {datestr(data(:,1))};
%     data1(:,2) = {data(:,2)};
    X(i-49,:) = data(:,2)';
end
days = {datestr(data(:,1))};

close(c)



%%
data_path = 'C:\Users\Dick\Copy\School\UF\2014-2 Fall\EEL6935 Network Science\Project\Stock Data\';
list = dir(data_path);
stockList = cell(1,size(list,1)-2);
for i = 3:size(list,1)
    temp = list(i).name;
    stockList(i-2) = {temp(1:end-4)};
end





for iter = 1:7
    %% Construct Granger Causality Matrix
    sigLevel = 0.01;     % The significance level of the F-Test
    timeLag = iter;       % The allowable amount of time lag
    N = size(X,1);
    Granger_hard = zeros(N,N);
    Granger_soft = zeros(N,N);

    warning('off','all');
    for i = 1:N
        for j = 1:N
            % Does X(j,:) Granger Cause X(i,:)?
            [F,c_v,output] = granger_cause(X(i,:),X(j,:),sigLevel,timeLag);
            Granger_hard(i,j) = output;
            Granger_soft(i,j) = F/c_v;
        end
    end
    warning('on','all');

    fprintf('--> Granger causality calculated.\n')


    %%
    eval(['cm' num2str(timeLag) ' = Granger_hard;'])

    cm = Granger_hard;
    ids = stockList(selector);
    bg = biograph(cm,ids);
    view(bg)
end


cmTotal = cm1 & cm2 & cm3 & cm4 & cm5 & cm6 & cm7;
ids = stockList(selector);
bg = biograph(cmTotal,ids);
view(bg)




function [X2,Y2] = sameLength(X1,Y1,gran)
% Inputs:
%   X1    - Input signal 1
%   Y1    - Input signal 2
%   gran  - Desired granularity in minutes
%
% Outputs:
%   X2    - time equalized signal 1
%   Y2    - time equalized signal 2

% Stock times range from 0930 to 1600, M-F

daysX = unique(X1.Day);
daysY = unique(Y1.Day);

commonDays = intersect(daysX,daysY);

lengthX = size(X1.Day,1);
lengthY = size(Y1.Day,1);
time = 930:gran:1600;

X2 = struct;
Y2 = struct;
X2.Days = commonDays;
Y2.Days = commonDays;
X2.Data = NaN(1,numel(commonDays)*numel(time));
Y2.Data = NaN(1,numel(commonDays)*numel(time));

keyboard
for i = 1:numel(commonDays)
    
end

for i = 1:
    temp1 = X1.Time{j};
    temp1 = temp1([1,2,4,5]);
    temp2 = X2.Time{j};
    temp2 = temp2([1,2,4,5]);


% % linearly interpolate
% x={ 1  2  3  4  5  6  7  8 9 10}
% y={ 0.3850 NaN  3.0394 NaN  0.6475  1.0000  1.5000  NaN  1.1506  0.58}
% x=cell2mat(x);y=cell2mat(y);
% xi=x(find(~isnan(y)));yi=y(find(~isnan(y)))
% result=interp1(xi,yi,x,'linear')





% Austin's dataset
% list = dir(data_path);
% stocks = struct;
% for i = 3:5%size(list,1)
%     temp = list(i).name;
%     temp1 = importdata(temp);
%     stocks(i-2).Tickers = {temp(1:end-4)};
%     if isfield(temp1, 'textdata')
%         stocks(i-2).Day = temp1.textdata(:,2);
%         stocks(i-2).Time = temp1.textdata(:,3);
%         stocks(i-2).Open = temp1.data(:,1);
%         stocks(i-2).Close = temp1.data(:,4);
%         stocks(i-2).High = temp1.data(:,2);
%         stocks(i-2).Low = temp1.data(:,3);
%         stocks(i-2).Volume = temp1.data(:,5);
%     end
% end
% clear temp temp1

