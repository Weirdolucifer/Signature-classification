clc;
clear;
end_correct = 24;
disp(end_correct);
% path  = 'E:\study material\sem 6\IIVP\project\GPDS300\';
path = '.\dataset\';
prompt='Enter the user : ';
user = input(prompt);
% user = 24;
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

end_incorrect = 30;
map = zeros(end_correct+end_incorrect,13);
% whos map(1)
for it=1:end_correct
   
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
%     bin_img = imbinarize(img);

tmap = extract_features(img);
for i=1 : 11
    map(it,i) = tmap(i);
end
map(it,13)= 1;


end
    chr = int2str(user);
    path1 = strcat(path,chr,'\');
    path1 = strcat(path1,'cf-');
    if(user<10)
        path1 = strcat(path1,'00',chr,'-');
    elseif (user <100)
         path1 = strcat(path1,'0',chr,'-'); 
    else
         path1 = strcat(path1,chr,'-'); 
    end

for it=1:end_incorrect
   
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
    map(it+end_correct,i) = tmap(i);
end
map(it+end_correct,13)= 0;


end

disp('SVM');
SVMModel = fitcsvm(map(1:54,1:11),map(1:54,13));
classOrder = SVMModel.ClassNames;
sv = SVMModel.SupportVectors;

CVSVMModel = crossval(SVMModel);
classLoss = kfoldLoss(CVSVMModel);
disp('Accuracy in %');
disp(1-classLoss);

min = 1;
temp = 1;
disp('KNN');
for n = 1:24
    
mdl = fitcknn(map(1:54,1:11),map(1:54,13),'NumNeighbors',n);
classOrder = mdl.ClassNames;
CVKNNModel = crossval(mdl);
classLoss = kfoldLoss(CVKNNModel);
% disp(1-classLoss);
if min>classLoss
    min = classLoss;
    temp = n;
end
end

disp('selected Mode with k = ');
disp(temp);
disp('Accuracy in %');
disp(1-min);


%  prompt = 'Do you want to predict custom sign? 1-Yes else - No';
%  t = input(prompt);
%  if(t==1)
% for it = 0 :54
%     
%     prompt='Enter the filename to check :  ';
%     user_input = input(prompt,'s');
%     tf = strcmp(user_input,'end');
%     if(tf==1)
%         break;
%     end
%     img = imread(user_input);
%     tmap = extract_features(img);
% 
%     
% %     [label,score] = predict(SVMModel,tmap(1:8));
% %     disp('SVM label');
% %     disp(label);
% 
%     [label,score] = predict(mdl,tmap(3:8));
%     disp('KNN label');
%     disp(label);
% end

