function [model]=trainSVM(X,Y)
%% Train  SVM 
    model = initlssvm(X,Y,'c',[],[],'RBF_kernel');
    model = tunelssvm(model,'simplex','crossvalidatelssvm',{10,'misclass'},'code_OneVsOne');
    model = trainlssvm(model);

end