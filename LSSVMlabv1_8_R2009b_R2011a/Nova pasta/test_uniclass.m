function [accuracy,precision,recall] = test_uniclass()
%Uni-class test
    clear all 
    load("SVM_NN");
    
    gam = 10;
    sig2 = 0.2;
    type = 'classification';

    % [alpha,b] = trainlssvm({X,Y,type,gam,sig2,'RBF_kernel'});
    [alpha,b] = trainlssvm({X,Y,type,gam,sig2,'RBF_kernel','preprocess'});
    Ytest = simlssvm({X,Y,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b},Xt);

    figure; plotlssvm({X,Y,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b});
    
%     recall = TP / P; % TP / (TP + FN)
%     precision = TP / (TP + FP);
    accuracy = 100*sum(Ytest==Yt)/length(Yt);
    C = confusionmat(Ytest,Yt);
    precision = mean(diag(C)./sum(C,2))*100;
    recall = mean(diag(C)./sum(C,1)')*100;
    fprintf("DONE!\n");
end
