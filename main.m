%Music genre classification
%Indrajith Indraprasthaam
%Mon Jan 16 06:25:39 IST 2017



clear;clc;

%flags
showPlots = 0




%Platform and version
fprintf('\n-------------WELCOME TO MUSIC GENRE CLASSIFICATION-------------\n\n');

fprintf('Platform: %s\n', computer);
fprintf('MATLAB version: %s\n', version);
scriptStartTime=tic;
fprintf('\npress any key to continue..\n');
pause;

%woring directory
cd '/media/l1f3/Atharva/installed/matlab/proj/genres/src'

%collect the dataset 1000 songs

auDir='/media/l1f3/Atharva/installed/matlab/proj/genres'
opt=mmDataCollect('defaultOpt');
opt.extName='au';
auSet=mmDataCollect(auDir, opt, 1);

%extract feature and save in ds.mat else load it.
if ~exist('ds.mat')
    myTic=tic;
    opt=dsCreateFromMm('defaultOpt');
    opt.auFeaFcn=@mgcFeaExtract;    % Function for feature extraction
    opt.auFeaOpt=feval(opt.auFeaFcn, 'defaultOpt'); % Feature options
    opt.auEpdFcn='';        % No need to do endpoint detection
    ds=dsCreateFromMm(auSet, opt, 1);
    fprintf('Time for feature extraction over %d files = %g sec\n', length(auSet), toc(myTic));
    fprintf('Saving ds.mat...\n');
    save ds ds
else
    fprintf('Loading ds.mat...\n');
    load ds.mat
end

if showPlots

fprintf('\nvisualization\npress any key to continue..\n\nsize of each class:');
pause;


%visualization

%we can display the size of each class:
figure;
[classSize, classLabel]=dsClassSize(ds, 1);
fprintf('\npress any key to continue..\n');
pause;

%We can plot the range of features of the dataset:
figure; dsRangePlot(ds);
fprintf('\nrange of features of the dataset:\npress any key to continue..\n');
pause;

%We can plot the feature vectors within each class:
figure; dsFeaVecPlot(ds); figEnlarge;
fprintf('\nfeature vectors within each class:\npress any key to continue..\n');
pause;
end


fprintf('\nDimensionality reduction\npress any key to continue..\n');
pause;


%Dimensionality reduction
dim=size(ds.input, 1)

[input2, eigVec, eigValue]=pca(ds.input);
cumVar=cumsum(eigValue);
cumVarPercent=cumVar/cumVar(end)*100;

if showPlots
figure; plot(cumVarPercent, '.-');
xlabel('No. of eigenvalues');
ylabel('Cumulated variance percentage (%)');
title('Variance percentage vs. no. of eigenvalues');

fprintf('Reduce the Dimension\n press any key\n\n');
pause;

end

cumVarTh=95;
index=find(cumVarPercent>cumVarTh);
newDim=index(1);
ds2=ds;
ds2.input=input2(1:newDim, :);
fprintf('Reduce the dimensionality to %d to keep %g%% cumulative variance via PCA.\n', newDim, cumVarTh);


fprintf('\npress any key to continue..\n');
pause;

fprintf('project the original dataset into 2-D space.\nThis can be achieved by LDA (linear discriminant analysis):');
ds2d=lda(ds);
ds2d.input=ds2d.input(1:2, :);

if showPlots
figure; dsScatterPlot(ds2d); xlabel('Input 1'); ylabel('Input 2');
title('Features projected on the first 2 lda vectors');
end

%...........................
%classification
fprintf('\n\n\nKNN classification\npress any key to continue..\n');
pause;

%..............................
fprintf('knn using 10 feature vectors');

sumr=0;sumk=0;
for i=1:5
    [md, rloss, kloss] = myKnn(ds2, i);
    sumr = sumr + rloss;
    sumk = sumk + kloss;
end

fprintf('\naverage resubstitution loss = %g %%\n',sumr*100/5);
fprintf('\naverage cross-validation loss loss = %g %%\n',sumk*100/5);

%................................
fprintf('knn using 156  feature vectors');

sumr=0;sumk=0;
for i=1:5
    [md, rloss, kloss] = myKnn(ds, i);
    sumr = sumr + rloss;
    sumk = sumk + kloss;
end
md
fprintf('\naverage resubstitution loss = %g %%\n',sumr*100/5);
fprintf('\naverage cross-validation loss loss = %g %%\n',sumk*100/5);

%.................................
fprintf('knn using 2  feature vectors: LDA (linear discriminant analysis)');

sumr=0;sumk=0;
for i=1:5
    [md, rloss, kloss] = myKnn(ds, i);
    sumr = sumr + rloss;
    sumk = sumk + kloss;
end
md
fprintf('\naverage resubstitution loss = %g %%\n',sumr*100/5);
fprintf('\naverage cross-validation loss loss = %g %%\n',sumk*100/5);

%.................................
fprintf('\nProgram finished executing \n\npress any key to continue..\n');
pause;
fprintf('----------END------------\n')
toc(scriptStartTime)
