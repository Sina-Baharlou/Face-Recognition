% Face Recognition using Independent Component Analysis (ICA)
% Created on Mar 2015
% Authors: Sid Ali Rezetane, Sina M. Baharlou, Harold Agudelo

% Load the first n *.pgm images (with offset 'o') from the m specified directory to a matrix
function D = loadsetEx(directory, n, m, o)
    D = [];
    for i = 1:m
        dirEx = sprintf(directory, i);
        file_list = dir([dirEx '/*.pgm']);
        images = {file_list.name};
        for i = 1:n
            D = [D, loadpgm(char(strcat(dirEx, images(i + o))))];
        end
    end
 
 
