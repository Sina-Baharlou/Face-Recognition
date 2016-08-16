% -- Face recognition parameters -- 


trainPath='datasets/CroppedYale/yaleB%02d/';
testPath='datasets/CroppedYale/yaleB%02d/';
nImage=10;
nClass=35;
offset=10;
k_count=7;

%trainPath='datasets/orl_faces/s%d/';
%testPath='datasets/orl_faces/s%d/';
%nImage=5;
%nClass=40;
%offset=5;
%k_count=3;

k_metric='cosine';
thresh=0.99;

% -- Run the two architectures 

[b,r,u,w,a,m,evec]=archOne(trainPath,nImage,nClass,0,thresh);
[b2,r2,u2,w2,a2,m2,evec2]=archTwo(trainPath,nImage,nClass,0,thresh);


%--  creating the labels 

labels=[];
for i = 1:nClass
for j= 1:nImage
labels=[labels,i];
end
end



% -- Load the test dataset

T=loadsetEx(testPath,nImage,nClass,offset);

t_size=size(T);

TM=T-(ones(t_size(2),1)*m)';


% -- calculate parameters for ARCH1

% calculate the Rm matrix 

RmT=TM'*evec;

% calculate B1 matrix

%BmatT=RmT*inv(Wi);

BmatT=RmT*a;

%-- calculate parameters for ARCH2

[zmTest,mm]=subMean(RmT);
BmatT2= w2 * zmTest';




% -- Check the results for the first arch


resArch1=knnclassify(BmatT,b,labels',k_count,k_metric);

errArch1=sum(abs(resArch1-labels')>0)  / (nImage*nClass) * 100;

disp(sprintf('The error percentage of arch1 over %d images is : %f',nClass*nImage,errArch1));



% -- Check the results for the second arch


resArch2=knnclassify(BmatT2',u2',labels',k_count,k_metric);

errArch2=sum(abs(resArch2-labels')>0)  / (nImage*nClass) * 100;

disp(sprintf('The error percentage of arch2 over %d images is : %f',nClass*nImage,errArch2));



% -- The combination of the two archs -- 


c_comb=(resArch2==resArch1);
c_acctual=labels'.*c_comb;
c_result=resArch2.*c_comb;
c_final=sum(abs(c_acctual-c_result)>0) / sum(c_comb) *100.0;



disp(sprintf('The error percentage of combination of the two archs over %d images is : %f',nClass*nImage,c_final));

disp(sprintf('Number of detected faces :%d',sum(c_comb)));





