load("domusdata");
load("parseddata");
load("domusmodels");

test=[];
for i=1:100
    test = [test; floor(15+rand*15)];
end
% Xtemp_padded = test;
% Ytemp_padded = [1:100];
% [Ytest_Temperature1,accuracy_Temperature1,precision_Temperature1,recall_Temperature1]=testSVM(model_Temperature,Xtemp,Ytemp);
[Ytest_Temperature1_padded,accuracy_Temperature1_padded,precision_Temperature1_padded,recall_Temperature1_padded]=testSVM(model_Temperature_padded,Xtemp_padded,Ytemp_padded);
% [Ytest_Temperature2,accuracy_Temperature2,precision_Temperature2,recall_Temperature2]=testSVM(model_Temperature2,Xtemp2,Ytemp2);
% [Ytest_Temperature2_padded,accuracy_Temperature2_padded,precision_Temperature2_padded,recall_Temperature2_padded]=testSVM(model_Temperature2_padded,Xtemp2_padded,Ytemp2_padded);
% [Ytest_Humidity,accuracy_Humidity,precision_Humidity,recall_Humidity]=testSVM(model_Humidity,Xhumi,Yhumi);
% [Ytest_Luminosity,accuracy_Luminosity,precision_Luminosity,recall_Luminosity]=testSVM(model_Luminosity,Xlum,Ylum);
% [Ytest_Luminosity_padded,accuracy_Luminosity_padded,precision_Luminosity_padded,recall_Luminosity_padded]=testSVM(model_Luminosity_padded,Xlum_padded,Ylum_padded);

% c = [];
% for i=15:30
%     [row_idx, ~] = find(Xtemp_padded(:, 1) == i);
%     c = [c; Ytest_Temperature1_padded(row_idx,:)];
% end
% c