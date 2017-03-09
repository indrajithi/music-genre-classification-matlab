function [J, grad] = lrCostFunction(theta, X, y, lambda)

%Music genre classification
%Indrajith Indraprastham
%Thu Mar  9 15:35:40 IST 2017

m = length(y); % number of training examples
J = 0;
grad = zeros(size(theta));


htheta = sigmoid(X * theta);
%J = -(1 /m ) * (y .* log(htheta) + (1-y) .* log(1 - htheta)) + lambda/(2*m) * sum(theta(2:end) .^ 2)
J = 1 / m * sum(-y .* log(htheta) - (1 - y) .* log(1 - htheta)) + lambda / (2 * m) * sum(theta(2:end) .^ 2);
theta = [0;theta(2:end)]; 
grad = (1/m) * (X' * (htheta - y) + lambda * theta);
    