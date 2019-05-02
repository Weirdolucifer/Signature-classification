clc;
clear;

prompt='Change the Path if file not found error is displayed ';
disp(prompt);
% path  = 'E:\study material\sem 6\IIVP\project\GPDS300\';
path = '.\dataset\';
prompt='Enter the starting number of user :  ';
snu = input(prompt);
disp(snu);

prompt='Enter the Ending number of user :  ';
nu = input(prompt);
disp(nu);

samples = 24;
 map = zeros(samples*(nu-snu+1),12);
% whos map(1)


ending = 0;
for (user = 1 : nu)
   
    
    chr = int2str(user);
    path1 = strcat(path,chr,'\');
    path1 = strcat(path1,'c-');
    if(user<10)
        path1 = strcat(path1,'00',chr,'-');
    elseif (user <100)
         path1 = strcat(path1,'0',chr,'-'); 
    else
         path1 = strcat(path1,chr,'-'); 
    end
    

end_correct = samples;
start = ending;
ending = end_correct*user;
for it=1:samples
   
    if(it <10)
        file = strcat(path1,'0');
    end
     if(it>=10)
         file = path1;
     end
    chr = int2str(it);
    file = strcat(file,chr);
    file = strcat(file,'.jpg')
    img = imread(file);

tmap = extract_features(img);
for i=1 : 11
    map(it+start,i) = tmap(i);
end
map(it+start,12) = user;


end

end
% To save the features in csv format.
% csvwrite('E:\study material\sem 6\IIVP\project\GPDS300\new_features_incorrect_all.csv',map);

min = 100;
temp = 1;
disp('KNN');
for n = 1:samples
    
%mdl = fitcknn(map(2:(samples*(nu-snu)+1),1:10),map(2:(samples*(nu-snu)+1),12),'NumNeighbors',n);
mdl = fitcknn(map(1:(samples*(nu-snu+1)),1:10),map(1:(samples*(nu-snu+1)),12),'NumNeighbors',n);
classOrder = mdl.ClassNames;
CVKNNModel = crossval(mdl);
classLoss = kfoldLoss(CVKNNModel);
if min>classLoss
    min = classLoss;
    temp = n;
end
end

disp('selected Mode with k = ');
disp(temp);
% mdl = fitcknn(map(2:(samples*(nu-snu+1)+1),1:10),map(2:(samples*(nu-snu+1)+1),12),'NumNeighbors',temp);
mdl = fitcknn(map(1:(samples*(nu-snu+1)),1:10),map(1:(samples*(nu-snu+1)),12),'NumNeighbors',temp);
classOrder = mdl.ClassNames;
CVKNNModel = crossval(mdl);
classLoss = kfoldLoss(CVKNNModel);
disp('Accuracy in %');
disp((1-classLoss)*100);

t = templateSVM('Standardize',1);
disp('SVM');
% SVMModel = fitcecoc(map(2:(samples*(nu-snu+1)+1),1:11),map(2:(samples*(nu-snu+1)+1),12),'Learners',t);
SVMModel = fitcecoc(map(1:(samples*(nu-snu+1)),1:11),map(1:(samples*(nu-snu+1)),12),'Learners',t);
classOrder = SVMModel.ClassNames
% sv = SVMModel.SupportVectors;
isLoss = resubLoss(SVMModel);
CVSVMModel = crossval(SVMModel);
classLoss = kfoldLoss(CVSVMModel);
disp('training set Accuracy in %');
disp((1-isLoss)*100);

disp('Validation Accuracy in %');
disp((1 - classLoss)*100);

% 
% 

