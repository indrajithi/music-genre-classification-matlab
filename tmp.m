ext = '*.au';
auDir='/media/l1f3/Ath/lab/project/music_proj/genres'
dirinfo = dir(auDir);
dirinfo(~[dirinfo.isdir]) = [];  %remove non-directories
tf = ismember( {dirinfo.name}, {'.', '..'});
dirinfo(tf) = [];  %remove current and parent directory.
numsubdir = length(dirinfo);

for K = 1 : numsubdir
  subdirinfo = dir(fullfile(dirinfo(K).name, ext));
%  load subdirinfo.name
    
end

audio='blues.au';
[speech,fs] = audioread(audio);

           Tw = 25;           % analysis frame duration (ms)
           Ts = 10;           % analysis frame shift (ms)
           alpha = 0.97;      % preemphasis coefficient
           R = [ 300 3700 ];  % frequency range to consider
           M = 20;            % number of filterbank channels 
           C = 13;            % number of cepstral coefficients
           L = 22;            % cepstral sine lifter parameter
hamming = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));

[ M1, FBEs, frames ] =  mfcc( speech, fs, Tw, Ts, alpha, hamming, R, M, C, L );

figure('Position', [30 100 800 200], 'PaperPositionMode', 'auto', ... 
                  'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
      
           imagesc( [1:size(MFCCs,2)], [0:C-1], MFCCs ); 
           axis( 'xy' );
           xlabel( 'Frame index' ); 
           ylabel( 'Cepstrum index' );
           title( 'Mel frequency cepstrum' );










  Tw = 25;           % analysis frame duration (ms)
            Ts = 10;           % analysis frame shift (ms)
            alpha = 0.97;      % preemphasis coefficient
            R = [ 300 3700 ];  % frequency range to consider
            M = 20;            % number of filterbank channels 
            C = 13;            % number of cepstral coefficients
            L = 22;            % cepstral sine lifter parameter
        
            % hamming window (see Eq. (5.2) on p.73 of [1])
            hamming = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));
        
            % Read speech samples, sampling rate and precision from file
             
            % Feature extraction (feature vectors as columns)
            [ MFCCs, FBEs, frames ] = ...
                            mfcc( speech, fs, Tw, Ts, alpha, hamming, R, M, C, L );
        