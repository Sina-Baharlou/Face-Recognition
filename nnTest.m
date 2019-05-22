% Face Recognition using Independent Component Analysis (ICA)
% Created on Mar 2015
% Authors: Sid Ali Rezetane, Sina M. Baharlou, Harold Agudelo

% face recognition parameters 
trainPath = 'datasets/orl_faces/s%d/';
testPath = 'datasets/orl_faces/s%d/';
nImage = 5;
nClass = 20;
offset = 0;
thresh = 0.99;

% run the two architectures
[b, r, u, w, a, m, evec] = archOne(trainPath, nImage, nClass, offset, thresh);
[b2, r2, u2, w2, a2, m2, evec2] = archTwo(trainPath, nImage, nClass, offset, thresh);

% creating the labels
labels = [];
for i = 1:nClass
    for j = 1:nImage
        labels = [labels, bvector(nClass, i)];
    end
end

% train the neural network for classification 
[netICA, pICA] = annClassifier(b',labels,nClass);
[netICA2, pICA2] = annClassifier(b2, labels, nClass);

% load the test dataset
T = loadsetEx(testPath, nImage, nClass, 0);
t_size = size(T);
TM = T - (ones(t_size(2), 1) * m)';

% calculate parameters for ARCH1
% calculate the Rm matrix
RmT = TM'*evec;

% calculate B1 matrix
% BmatT=RmT*inv(Wi);
BmatT = RmT * a;

% calculate parameters for ARCH2
[zmTest, mm] = subMean(RmT);
BmatT2 = w2 * zmTest';

% check the results for the first arch
resTICA = netICA(BmatT');
[dontcare, indexTICA] = max(resTICA);
[dontcare, indexTLabel] = max(labels);
errTICA = sum(abs(indexTICA - indexTLabel) > 0) / (nImage * nClass) * 100;
disp(sprintf('The error percentage of arch1 over %d images is : %f', nClass * nImage, errTICA));

% check the results for the second arch
resTICA2 = netICA2(BmatT2);
[dontcare, indexTICA2] = max(resTICA2);
[dontcare, indexTLabel2] = max(labels);
errTICA2 = sum(abs(indexTICA2 - indexTLabel2) > 0) / (nImage * nClass) * 100;
disp(sprintf('The error percentage of arch2 over %d images is : %f', nClass * nImage, errTICA2));

% the combination of the two archs 
c_comb = (indexTICA2 == indexTICA);
c_acctual = indexTLabel .* c_comb;
c_result = indexTICA2 .* c_comb;
c_final = sum(abs(c_acctual - c_result) > 0) / sum(c_comb) * 100.0;
disp(sprintf('The error percentage of combination of the two archs over %d images is : %f', nClass * nImage, c_final));
disp(sprintf('Number of detected faces :%d', sum(c_comb)));
