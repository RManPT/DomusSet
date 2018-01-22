function [Ytest,accuracy,precision,recall]=testSVM(model,Xt,Yt)
    Xt = double(Xt);
    Yt = double(Yt);
    Ytest = simlssvm(model,Xt);
    accuracy = 100*sum(Ytest==Yt)/length(Yt);
    C = confusionmat(Ytest,Yt);
    precision = mean(diag(C)./sum(C,2))*100;
    recall = mean(diag(C)./sum(C,1)')*100;
% %     plotlssvm(model,[],150);
end