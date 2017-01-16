function [md, rloss, kloss] = myKnn(ds, k)

% ACCEPTS:
% a data structure having input and output attribute
% k as the number of nearest neighbours to consider

% Returns:
% md = a knn-model
% rloss : resubstitution loss,
%         resubstitution loss, which, by default, is the fraction of misclassifications
%         from the predictions of md
% kloss : cross-validation loss, 
%         which is the average loss of each cross-validation model
%         when predicting on data that is not used for training.

if nargin<1
    fprintf('ACCEPTS: a data structure having input and output attribute. \nAnd k as the number of nearest neighbours to consider\n');
return;
end

if nargin==1
    k=1
end

[dim, dataNum] = size(ds.input);

x = ds.input' ; %transpose of the input
y = ds.output'; %transpose of the given output 

md = fitcknn(x,y,'NumNeighbors',k);
rloss =  resubLoss(md); % Examine the resubstitution loss

cval = crossval(md); % Construct a cross-validated classifier from the model.

kloss = kfoldLoss(cval); % Cross-validation loss


end
