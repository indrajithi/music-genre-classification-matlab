%Music genre classification
%Indrajith Indraprastham
%Thu Mar  9 11:02:52 IST 2017

auDir = pwd;
ext = '*.au';
allAudio = getAllFiles(auDir, 'FileFilter', '\.au$');

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
 
 %Reducing Feature Dimeansion
 mf = mean(mm,2); %row mean
 cf = cov(mm'); % covariance
 ff = mf;
    for i=0:(size(mm,1)-1)
     ff = [ff;diag(cf,i)]; %use diagonals 
    end

 t(:,end+1) = ff(:,1);
 
end