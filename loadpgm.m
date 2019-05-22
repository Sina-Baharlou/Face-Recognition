% Face Recognition using Independent Component Analysis (ICA)
% Created on Mar 2015
% Authors: Sid Ali Rezetane, Sina M. Baharlou, Harold Agudelo

% simply load the pgm file to the memory convert it to grayscale and reshape it to a vector
function X = loadpgm(filename)
    % read the image file
    img = imread(filename);
 
    % convert it to gray scale ( also this convert the image to double)
    gray = mat2gray(img);
 
    % get image size
    imsize = size(gray);
 
    % reshape the image into single column vector
    X = reshape(gray, [imsize(1) * imsize(2), 1]);
 
