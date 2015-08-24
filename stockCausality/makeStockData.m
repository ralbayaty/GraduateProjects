function [X,badStockData] = makeStockData(stockList,selector,fromdate,todate,period)
    N = numel(selector);
    badStockData = NaN;
    h = waitbar(0,'Please wait while fetching stock prices...');
    c = yahoo;
    for i = 1:N
        s = stockList(selector(i));
%         data = builduniverse(c,s,fromdate,todate,period);
%         if i > 1
%             if size(data(:,2)') == size(X(i-1,:))
%                 X(i,:) = data(:,2)';
%             else
%                 X(i,:) = NaN(size(X(i-1,:)));
%                 badStockData = [badStockData,selector(i)];
%             end
%         else
%             X(i,:) = data(:,2)';
%         end
        [prc,~,~] = trpdata(c,s,fromdate,todate,period);
        if i > 1
            if size(prc(:,2)') == size(X(i-1,:))
                X(i,:) = prc(end:-1:1,2)';
            else
                X(i,:) = NaN(size(X(i-1,:)));
                badStockData = [badStockData,selector(i)];
            end
        else
            X(i,:) = prc(end:-1:1,2)';
        end
        waitbar(i / N)
    end    
    
    if numel(badStockData) > 1
        badStockData = badStockData(2:end);
    end
    close(h);
    close(c);
    
end