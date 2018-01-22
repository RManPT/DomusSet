function [accuracy,precision,recall] = test_multiclass()
    %Multi-class test
    clear all 
    load("SVM_NN");

    model = initlssvm(X,Y,'c',[],[],'RBF_kernel');
    model = tunelssvm(model,'simplex','crossvalidatelssvm',{10,'misclass'},'code_OneVsOne');
    model = trainlssvm(model);
    Ytest = simlssvm(model,Xt);

 %     recall = TP / P; % TP / (TP + FN)
%     precision = TP / (TP + FP);
    accuracy = 100*sum(Ytest==Yt)/length(Yt);
    C = confusionmat(Ytest,Yt)
    precision = mean(diag(C)./sum(C,2))*100;
    recall = mean(diag(C)./sum(C,1)')*100;
    fprintf("DONE!\n");

    plotlssvm(model,[],150);
end