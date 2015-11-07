% Purpose : Test the  GMM models for speaker verification without norm

clear all; close all; clc;

testfeatspath = '..\mfcctestfeats\';
modelpath = '..\models_siva_nnml\';
modelname = 'g16';
modelpath = strcat(modelpath,modelname,'\');
modellist = dir(modelpath);

cf = zeros(length(modellist)-2);

spks = dir(modelpath);
ncorrect = 0;
nwrong = 0;

for i = 3:10%length(spks)
     [tok1 rem]=strtok(spks(i).name,'.');
    testfiles = dir(strcat( '..\mfcctestfeats\',tok1));

for j = 3:length(testfiles)
    strcat(testfeatspath,tok1,'\',testfiles(j).name)
    [str,tok] = strtok(testfiles(j).name,'.');
    str=strcat('_',str);
     %[str,tok] = strtok(str,'_');
       
     if strcmp(str,'_sa1') || strcmp(str,'_sa2')

    %if strcmp(tok,'_sa1') || strcmp(tok,'_sa2')
        
        X = dlmread(strcat(testfeatspath,tok1,'\',testfiles(j).name));
        X = X'; % N x d
%         X = bsxfun(@minus,X,mean(X));
%         X = bsxfun(@rdivide,X,std(X));

        % Compare the input to all the models
        for k = 3:length(modellist)
           load(strcat(modelpath,modellist(k).name))
           [idx,nlogl,P,logpdf,M] = cluster(obj,X);
           dist_vec(k-2) = nlogl;
            
        end
        
        % Take that model which gives least distortion
        [mind,minix] = min(dist_vec);
        
        % Compare the actual speaker name with the predicted speaker name
        [pspkname,tok] = strtok(modellist(minix+2).name,'.');
        
        
        if strcmp(tok1,pspkname)
  
       % if strcmp(spks(i).name,pspkname)
            tok1
            pspkname    
            ncorrect = ncorrect + 1;
            ncorrect
        else
            nwrong = nwrong + 1;
            tok1
            pspkname
            nwrong
        end
        
    end
    
end

end

accuracy = ncorrect/(ncorrect + nwrong);

