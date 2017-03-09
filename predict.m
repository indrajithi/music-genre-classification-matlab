function p = predict(Theta1, Theta2, X)

m = size(X, 1);
num_labels = size(Theta2, 1);


p = zeros(size(X, 1), 1);

X2 = [ones(m,1) X]; % Adds a colum of ones for baias usint a^(1) = x;
a2 = sigmoid(X2 * Theta1');% Hidden layer  z^(2) = Theta^(1)*a^(1); a^(2)=g(z)
a2 = [ones(m,1) a2]; %bias
a3 = sigmoid(a2 * Theta2'); % z^(3) = Theta^(2)*z^(2)
h =  sigmoid(a3); 
[acc, p]=max(h,[],2);


end