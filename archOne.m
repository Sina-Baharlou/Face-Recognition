% Face Recognition using Independent Component Analysis (ICA)
% Created on Mar 2015
% Authors: Sid Ali Rezetane, Sina M. Baharlou, Harold Agudelo

function [b, r, u, w, a, m, evec] = archOne(filename, nImage, nClass, offset, thresh)
 
    % constants
    blockSize = 30; % infomax blockzize
    epochs = 100; % infomax number of epochs
    learnRate = 0.0005; % infomax learning rate
    whitten = 1; % enable whittening
    method = 1; % 1 - infoMax 2- fastICA
 
    % loading the train dataset
    disp('Loading the dataset...');
    D = loadsetEx(filename, nImage, nClass, offset);
 
    % calculate and subtract the mean
    disp('calculate and subtract the mean...');
    [zm, m] = subMean(D);
 
    % calculate the eigenfaces
    disp('calculate the eigenfaces');
    [evec, eval] = eigenface(zm);
 
    % reduce the dimension
    dim = getN(eval, thresh);
    disp(sprintf('reduce the dimention to %d components. preserves 99 percent of dataset variance.', dim));
    evec = evec(:, 1:dim);
 
    % calculate ICA
    switch method
        case 1
            disp('Calculating Independent Components using infoMax...');
              [u, A, w] = infomax(evec',blockSize,epochs,learnRate,whitten);
        case 2
            disp('Calculating Independent Components using FastICA...');
              [u, A, w] = fastica(evec');
    end
 
    % calculate the Rm matrix
    Rm = zm'*evec;
 
    % calculate B matrix
    Bmat = Rm * A;
 
    b = Bmat;
    r = Rm;
    a = A;
 
end

