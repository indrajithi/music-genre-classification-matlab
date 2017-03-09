%Music genre classification
%Indrajith Indraprastham
%Thu Mar  9 09:36:35 IST 2017

%% Setup the parameters
 
clear;clc;
load('mgcTrain.mat');
showPlots =0;
isPca =0
isTest =1;

m=size(x,1);
num_labels = 10; 

fprintf('\nTraining One-vs-All Logistic Regression...\n')

dim=size(x, 1)

if isPca
[input2, eigVec, eigValue]=pca(x');
cumVar=cumsum(eigValue);
cumVarPercent=cumVar/cumVar(end)*100;

figure; plot(cumVarPercent, '.-');
xlabel('No. of eigenvalues');
ylabel('Cumulated variance percentage (%)');
title('Variance percentage vs. no. of eigenvalues');


cumVarTh=95;
index=find(cumVarPercent>cumVarTh);
newDim=index(1);
x2=input2(1:newDim, :)';
end

lambda = 0.1;
[all_theta] = oneVsAll(x, y, num_labels, lambda);
pred = predictOneVsAll(all_theta, x);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

X=x;
Y=y;

%..............................................
if isTest
load('mgcTest.mat');

lambda = 0.1;
pred = predictOneVsAll(all_theta, x);

fprintf('Testing Set Accuracy: %f\n', mean(double(pred == y)) * 100);
end