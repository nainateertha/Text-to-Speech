% Purpose : Train K-Means and GMM models for each speaker without norm

clear all; close all; clc;

% Set paths and make directories
featpath = '..\mfccfeats\';
modelpath = '..\models_siva_nnml\';
mkdir(modelpath);
mkdir(strcat(modelpath,'k1\'));
mkdir(strcat(modelpath,'k4\'));
mkdir(strcat(modelpath,'k64\'));

mkdir(strcat(modelpath,'g1\'));
mkdir(strcat(modelpath,'g4\'));
mkdir(strcat(modelpath,'g8\'));
mkdir(strcat(modelpath,'g16\'));
mkdir(strcat(modelpath,'g32\'));
mkdir(strcat(modelpath,'g64\'));

spks = dir(featpath);

for i = 3:length(spks)
    
    trainfiles = dir(strcat(featpath,spks(i).name));
    
    X = [];
    for j = 3:length(trainfiles)
        M = dlmread(strcat(featpath,spks(i).name,'\',trainfiles(j).name));
        X = [X;M'];
    end
   
    [X,gmu,gsigma] = zscore(X);    
    % Training K-Means models for each speaker
    fprintf('training kmeans models for %s ...\n', spks(i).name);
    fprintf('size of feature matrix is %d %d ...\n', size(X,1),size(X,2));
    
%     [IDX,C,sumd,D] = kmeans(X,1);
%     save(fullfile(strcat(modelpath,'/k1/',spks(i).name,'.mat')),'IDX','C','sumd','D');
%    % dlmwrite(strcat(modelpath,'/k1/',spks(i).name,'.mat'),C,'delimiter', '\t')
% 
%     
    
    
%     % Training GMM models for each speaker
%     fprintf('training GMM models for %s ...\n', spks(i).name);
%     fprintf('size of feature matrix is %d %d ...\n', size(X,1),size(X,2));
     

%     obj = gmdistribution.fit(X,1,'Replicates',3,'CovType','diagonal','Regularize',1e-5);
%     save(strcat(modelpath,'/g1/',spks(i).name,'.mat'),'obj');
% obj = gmdistribution.fit(X,4,'Replicates',3,'CovType','diagonal','Regularize',1e-5);
%     save(strcat(modelpath,'/g4/',spks(i).name,'.mat'),'obj');
% obj = gmdistribution.fit(X,8,'Replicates',3,'CovType','diagonal','Regularize',1e-5);
%     save(strcat(modelpath,'/g8/',spks(i).name,'.mat'),'obj');
obj = gmdistribution.fit(X,16,'Replicates',3,'CovType','diagonal','Regularize',1e-5);
    save(strcat(modelpath,'/g16/',spks(i).name,'.mat'),'obj','gmu','gsigma');
obj = gmdistribution.fit(X,32,'Replicates',3,'CovType','diagonal','Regularize',1e-5);
    save(strcat(modelpath,'/g32/',spks(i).name,'.mat'),'obj','gmu','gsigma');
obj = gmdistribution.fit(X,64,'Replicates',3,'CovType','diagonal','Regularize',1e-5);
    save(strcat(modelpath,'/g64/',spks(i).name,'.mat'),'obj','gmu','gsigma');

end




