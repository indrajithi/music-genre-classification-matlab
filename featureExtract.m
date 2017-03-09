%Music genre classification
%Indrajith Indraprastham
%Thu Mar  9 11:02:52 IST 2017

auDir = pwd;
ext = '*.au';
allAudio = getAllFiles(auDir, 'FileFilter', '\.au$');
len=90;
fprintf('%d files loaded..\n',length(allAudio));

dirinfo = dir('*.au');

%Sampling and feature extraction
           Tw = 25;           % analysis frame duration (ms)
           Ts = 10;           % analysis frame shift (ms)
           alpha = 0.97;      % preemphasis coefficient
           R = [ 300 3700 ];  % frequency range to consider
           M = 20;            % number of filterbank channels 
           C = 13;            % number of cepstral coefficients
           L = 22;            % cepstral sine lifter parameter
hamming = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));
t=[];
for i=1:length(allAudio)

 if mod(i,10) == 0
    fprintf('features from %d audios extracted\n',i);
 end

 [speech,fs] = audioread(dirinfo(i).name);
 [ MFCCs, FBEs, frames ] =  mymfcc( speech, fs, Tw, Ts, alpha, hamming, R, M, C, L );
 mm = MFCCs;
 mm(~isfinite(mm))=0;
 
 %Reducing Feature Dimeansion
 mf = mean(mm,2); %row mean
 cf = cov(mm'); % covariance
 ff = mf;
    for i=0:(size(mm,1)-1)
     ff = [ff;diag(cf,i)]; %use diagonals 
    end

 t(:,end+1) = ff(:,1);

end

y = [(ones(len,1)*1);(ones(len,1)*2);(ones(len,1)*3);...
    (ones(len,1)*4);(ones(len,1)*5);(ones(len,1)*6); ...
    (ones(len,1)*7);(ones(len,1)*8);(ones(len,1)*9);(ones(len,1)*len)];

x = t';
save('data.mat','x','y');