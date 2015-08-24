function X1 = batchResize(X,scale,n1,n2)

for i = 1:size(X,2)
    temp = X(:,i);
    temp = imresize(reshape(temp,n1,n2),scale);
    X1(:,i) = temp(:);
end
