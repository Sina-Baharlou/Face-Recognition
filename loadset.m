% Load the first n *.pgm images in the specified directory to a matrix
function D=loadset(directory,n)

% get all pgm files in the specified directory 
file_list=dir([directory '/*.pgm']);
images={file_list.name};


% load the images and put it to a matrix  
D=[];
for i=1:n
D=[D,loadpgm(   char(strcat(directory,images(i)))    )];
end 
