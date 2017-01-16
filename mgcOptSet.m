function opt=mgcOptSet
% Set options for MGC (music genre classification)

% ====== Input processing
opt.useInputNormalize=1;

% === Cross-validation (inf means LOO)
opt.foldNum=inf;

% ====== Classifier
opt.classifier='gmmc';      % GMMC classifier
opt.classifier='qc';        % Quadratic classifier
opt.classifier='src';       % Sparse-representation classifier
opt.classifier='svmc';      % SVM classifier, 76.9% (wave2mfcc), 56.80% (wave2mfccMex), 