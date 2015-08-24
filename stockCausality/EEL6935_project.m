%%%%%
%	EEL6935 Network Science
%   Fall 2014
%	Final Project
%      Cluster S&P500 stocks using Granger Causality
% 
%   Written by:   Dick Al-Bayaty (ralbayaty@ufl.edu)
%   Created:      12/04/2014
%%%%%
clear,clc

%% Load the data:
code_path = 'D:\Copy\UF\2014-2 Fall\EEL6935 Network Science\Project\Programs\';
data_path = 'D:\Copy\UF\2014-2 Fall\EEL6935 Network Science\Project\Data\';
output_path = 'D:\Copy\UF\2014-2 Fall\EEL6935 Network Science\Project\Output';
addpath(genpath(code_path));
addpath(data_path);

% load stockList.mat
load SP500.mat

fromdate = '11/01/2014';
todate = '12/11/2014';

% idx = randperm(502);
% selector = idx(1:end);
selector = 1:502;

[X,badStockData] = makeStockData(stockList,selector,fromdate,todate,'d');
X_cov = cov(X');

e = unique(Sector);
sector_count = zeros(size(e));
for j = 1:numel(Sector)
    for i=1:length(e)
       sector_count(i)=strcmp(e{i},Sector{j}) + sector_count(i);
    end
end

e2 = unique(Industry);
industry_count = zeros(size(e2));
for j = 1:numel(Industry)
    for i=1:length(e2)
       industry_count(i)=strcmp(e2{i},Industry{j}) + industry_count(i);
    end
end



for i = 1:numel(e)
    for j = 1:numel(Sector)
        temp(i,j) = strcmp(e{i},Sector{j});
    end
end

for i = 1:numel(Sector)
    temp1(i) = find(temp(:,i) == 1);
end
temp1 = temp1';



fprintf('--> Data loaded.\n')

%% Construct Granger Causality Matrix
sigLevel = 0.01;     % The significance level of the F-Test
timeLag = 5;       % The allowable amount of time lag
N = size(X,1);
Granger_hard = zeros(N,N);
Granger_soft = zeros(N,N);

warning('off','all');
for i = 1:N
    for j = 1:N
        % Does X(j,:) Granger Cause X(i,:)?
        [F,c_v,output] = granger_cause(X(i,:),X(j,:),sigLevel,timeLag);
        Granger_hard(i,j) = output;
        Granger_soft(i,j) = F-c_v;  % Greater than 1 means Causality
    end
end
warning('on','all');

fprintf('--> Granger causality calculated.\n')

%% Make Adjacency and Weight Matrices

A = Granger_hard;
A(A>0) = 1;
A(A<0) = 0;
D = diag(sum(A,2));

k = numel(unique(Sector));
% k = numel(unique(Industry));

[idx,idx_sym,idx_rw] = spectralClustering(Granger_soft,A,D,k);
labelCorr1 = accumarray([temp1(:), idx(:)],1);
labelCorr2 = accumarray([temp1(:), idx_sym(:)],1);
labelCorr3 = accumarray([temp1(:), idx_rw(:)],1);

[a1,b1] = max(labelCorr1');numel(unique(b1)),b1'
[a2,b2] = max(labelCorr2');numel(unique(b2)),b2'
[a3,b3] = max(labelCorr3');numel(unique(b3)),b3'

figure()
    subplot(1,3,1)
surf(labelCorr1)
title('Labels from L')
view([1,90])
axis([1 10 1 10])
axis square
    subplot(1,3,2)
surf(labelCorr2)
title('Labels from L_sym')
view([1,90])
axis([1 10 1 10])
axis square
    subplot(1,3,3)
surf(labelCorr3)
title('Labels from L_rw')
view([1,90])
axis([1 10 1 10])
axis square


figure()
    subplot(1,3,1)
a = hist(idx,k);
bar(a./sum(a))
title('Unnormalized Spectral Clustering')
axis([1 k 0 1])
axis square
    subplot(1,3,2)
a = hist(idx_sym,k);
bar(a./sum(a))
title('Normalized Spectral Clustering: L_{sym}')
axis([1 k 0 1])
axis square
    subplot(1,3,3)
a = hist(idx_rw,k);
bar(a./sum(a))
title('Normalized Spectral Clustering: L_{rw}')
axis([1 k 0 1])
axis square

figure()
bar(sector_count./sum(sector_count))
title('S&P500 Sector Label Distribution')
axis([1 k 0 1])
axis square



%% Graph plotting

method = 3;

switch method
    case 1
        cm = Granger_hard;
        ids = stockList(selector);
        bg = biograph(cm,ids);
    case 2
        cm = Granger_soft;
        ids = stockList(selector);
        bg = biograph(cm,ids);
    case 3
        cm = Granger_hard;
        antiSym = 0.5*(cm - cm');
        antiSym(antiSym > 0) = 1;
        antiSym(antiSym < 0) = 0;
        cm = antiSym;
        ids = stockList(selector);
        bg = biograph(cm,ids);
    case 4
        cm = Granger_hard;
        Sym = 0.5*(cm + cm');
        Sym(Sym > 0) = 1;
        Sym(Sym < 0) = 0;
        cm = Sym;
        ids = stockList(selector);
        bg = biograph(cm,ids);
end

fprintf('--> Graph created.\n')
% get(bg.nodes,'ID')
% view(bg)

