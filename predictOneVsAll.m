 function p = predictOneVsAll(all_theta, X)
%PREDICT Predict the label for a trained one-vs-all classifier. The labels 
%are in the range 1..K, where K = size(all_theta, 1). 

m = size(X, 1);
num_labels = size(all_theta, 1);

% We need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% Add ones to the X data matrix
X = [ones(m, 1) X];

     
h=sigmoid(X * all_theta');

[acc, p]=max(h,[],2); % p is the index




end
