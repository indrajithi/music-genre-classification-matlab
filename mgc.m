%Music genre classification
%Indrajith Indraprastham
%Thu Mar  9 09:36:35 IST 2017

%Pre processing
auDir='/media/l1f3/Ath/lab/project/music_proj/genre-test/all';
ext = '*.au';
allAudio = getAllFiles(auDir, 'FileFilter', '\.au$');

fprintf('%d files loaded..\n',length(allAudio));

oldDir = pwd
cd auDir
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
for i=1:10
 [speech,fs] = audioread(dirinfo(i).name);
 [ MFCCs, FBEs, frames ] =  mymfcc( speech, fs, Tw, Ts, alpha, hamming, R, M, C, L );
 t(:,end+1) = MFCCs(:,1);
end




% F = dir('*.txt');
%for i = 1:length(F)
%   text = fileread(F(i).name) ;
   % Do further operations
%end